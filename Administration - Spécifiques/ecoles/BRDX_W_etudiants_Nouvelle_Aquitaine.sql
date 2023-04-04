/* MINIFY OBLIGATOIRE */

SELECT COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS "title",
    b.author as "author",
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(
                                    REGEXP_REPLACE(
                                        REGEXP_REPLACE(
                                            bm.metadata,
                                            /* Replace \n by spaces */
                                            "\n",
                                            " "
                                        ),
                                        /* Clear white spaces between tags */
                                        ">\\s*<",
                                        "><"
                                    ),
                                    /* Remove all non-70X datafields*/
                                    '<datafield tag="(?!70).*?<\/datafield>',
                                    ""
                                ),
                                /* Remove all non-datafield*/
                                '.*?(<datafield.*<\/datafield>).*',
                                "\\1"
                            ),
                            /* Remove all non $a subfield*/
                            '<subfield code="[^a|b]">.*?<\/subfield>',
                            ""
                        ),
                        /* Add coma bewteen surname and First name*/
                        "subfield><subfield",
                        "subfield>, <subfield"
                    ),
                    /* Remove everything between < > */
                    "<.*?>",
                    "|"
                ),
                /* Removes multiples | */
                "\\|+",
                "|"
            ),
            /* Remove leadeing and trailing | */
            "^\\||\\|$",
            ""
        ),
        /* Remove | between surname and first name*/
        "\\|, \\|",
        ", "
    ) AS "author_v2",
    SUBSTR(ExtractValue(bm.metadata, '//datafield[@tag="100"]/subfield[@code="a"]'), 10, 4) AS "date_100",
    bi.publicationyear AS "date_raw",
    IF(REGEXP_SUBSTR(bi.publicationyear, "\\d{4}") != "", REGEXP_SUBSTR(bi.publicationyear, "\\d{4}"), bi.publicationyear) AS "date_mod",
    av.lib AS "typedoc_name",
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(
                                    bm.metadata,
                                    /* Replace \n by spaces */
                                    "\n",
                                    " "
                                ),
                                /* Clear white spaces between tags */
                                ">\\s*<",
                                "><"
                            ),
                            /* Remove all non-609 datafields*/
                            '<datafield tag="(?!609).*?<\/datafield>',
                            ""
                        ),
                        /* Remove all non-datafield*/
                        '.*?(<datafield.*<\/datafield>).*',
                        "\\1"
                    ),
                    /* Remove all non $a subfield*/
                    '<subfield code="[^a]">.*?<\/subfield>',
                    ""
                ),
                /* Remove everything between < > */
                "<.*?>",
                "|"
            ),
            /* Removes multiples | */
            "\\|+",
            "|"
        ),
        /* Remove leadeing and trailing | */
        "^\\||\\|$",
        ""
    ) AS "localisation",
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(
                                    bm.metadata,
                                    /* Replace \n by spaces */
                                    "\n",
                                    " "
                                ),
                                /* Clear white spaces between tags */
                                ">\\s*<",
                                "><"
                            ),
                            /* Remove all non-610 datafields*/
                            '<datafield tag="(?!610).*?<\/datafield>',
                            ""
                        ),
                        /* Remove all non-datafield*/
                        '.*?(<datafield.*<\/datafield>).*',
                        "\\1"
                    ),
                    /* Remove all non $a subfield*/
                    '<subfield code="[^a]">.*?<\/subfield>',
                    ""
                ),
                /* Remove everything between < > */
                "<.*?>",
                "|"
            ),
            /* Removes multiples | */
            "\\|+",
            "|"
        ),
        /* Remove leadeing and trailing | */
        "^\\||\\|$",
        ""
    ) AS "keywords",
    ExtractValue(bm.metadata, '//datafield[@tag="330"]/subfield[@code="a"]') AS "abstract",
    CONCAT("http://www.archires.archi.fr/recherche/viewnotice/id_sigb/", biblionumber, "/id_site/*/id_profil/61") AS "archires_link",
    IF(
        ExtractValue(bm.metadata, '//datafield[@tag="099"]/subfield[@code="x"]')=1,
        CONCAT("https://omeka.archires.archi.fr/cas/login?gateway=true&redirect_url=https://omeka.archires.archi.fr/s/ensa/get-biblio/", biblionumber),
        "DOCUMENT_IMPRIME"
    ) AS "consulter_le_fichier",
    biblionumber

FROM biblio b
JOIN biblioitems bi USING (biblionumber)
JOIN biblio_metadata bm USING(biblionumber)
JOIN items i USING(biblionumber)
JOIN authorised_values av ON bi.itemtype = av.authorised_value AND av.category = "TYPEDOC"

WHERE 
    (
        bi.itemtype IN ("MEME", "MHMONP", "MEMU", "MES", "PFE", "THES", "TPFE", "TE")
        AND
            (
                i.homebranch = "BRDX"
                OR i.holdingbranch = "BRDX"
            )
        AND biblionumber IN (
            SELECT biblionumber
            FROM biblio_metadata
            WHERE ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="a"]') REGEXP "Charente|Charente-Maritime|Corrèze|Creuse|Dordogne|Gironde|Landes|Lot-et-Garonne|Pyrénées-Atlantique|Deux-Sèvres|Vienne|Haute-Vienne"
        )
    )

/* Rapport ID (test) : 1374
Rapport ID (prod) : 

NE PAS MODIFIER - UTILISÉ PAR UN SERVICE EXTÉRIEUR
#AR244 : liste les travaus étudiants de l'ENSAP Bordeaux ayant comme sujet la Nouvelle Aquitaine

MINIFY OBLIGATOIRE */