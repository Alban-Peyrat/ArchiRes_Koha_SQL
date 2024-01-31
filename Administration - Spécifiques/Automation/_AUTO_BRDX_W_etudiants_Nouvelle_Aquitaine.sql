SELECT COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS "title",
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
    ) AS "author",
    av.lib AS "typedoc_name",
    TRIM(TRAILING '|' FROM ExtractValue(bm.metadata, "concat(//datafield[@tag='609']/subfield[@code='a'][1], concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][2], concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][3], concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][4], concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][5], concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][6],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][7],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][8],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][9],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][10],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][11],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][12],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][13],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][14],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][15],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][16],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][17],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][18],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][19],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][20],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][21],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][22],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][23],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][24],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][25],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][26],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][27],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][28],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][29],concat('|', concat(//datafield[@tag='609']/subfield[@code='a'][30], '|')))))))))))))))))))))))))))))))))))))))))))))))))))))))))))")) AS "localisation",
    TRIM(TRAILING '|' FROM ExtractValue(bm.metadata, "concat(//datafield[@tag='610']/subfield[@code='a'][1], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][2], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][3], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][4], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][5], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][6],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][7],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][8],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][9],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][10],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][11],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][12],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][13],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][14],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][15],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][16],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][17],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][18],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][19],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][20],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][21],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][22],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][23],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][24],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][25],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][26],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][27],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][28],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][29],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][30], '|')))))))))))))))))))))))))))))))))))))))))))))))))))))))))))")) AS "keywords",
    ExtractValue(bm.metadata, '//datafield[@tag="330"]/subfield[@code="a"]') AS "abstract",
    CONCAT("http://www.archires.archi.fr/recherche/viewnotice/id_sigb/", biblionumber, "/id_site/*/id_profil/61") AS "archires_link",
    IF(
        ExtractValue(bm.metadata, '//datafield[@tag="099"]/subfield[@code="x"]')=1,
        CONCAT("https://omeka.archires.archi.fr/cas/login?gateway=true&redirect_url=https://omeka.archires.archi.fr/s/ensa/get-biblio/", biblionumber),
        "DOCUMENT_IMPRIME"
    ) AS "omeka_link",
    biblionumber

FROM biblio b
LEFT JOIN biblioitems bi USING (biblionumber)
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN items i USING(biblionumber)
LEFT JOIN authorised_values av ON REGEXP_SUBSTR(ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="m"]'), "(?<=\\d{4})_[A-Z]+_") = REPLACE(REPLACE(av.authorised_value, "*", ""), '"', "")  AND av.category = "diss"

WHERE 
    (
        bi.itemtype = "TE"
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
        AND (
            SUBSTR(ExtractValue(bm.metadata, '//datafield[@tag="100"]/subfield[@code="a"]'), 10, 4) = <<Date>> /*date_100*/
            OR REGEXP_SUBSTR(bi.publicationyear, "\\d{4}") = <<Date>> /*date_mod*/
        )
    )

/* Rapport ID (test) : 1486
Rapport ID (prod) : 

UTILISÉ DANS DES AUTOMATIONS #AR244 : liste les travaux étudiants de l'ENSAP Bordeaux ayant comme sujet la Nouvelle Aquitaine */