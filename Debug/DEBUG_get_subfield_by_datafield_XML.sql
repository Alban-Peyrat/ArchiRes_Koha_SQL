SELECT biblionumber,
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
                /* Remove all datafields with wrong tag */
                CONCAT('<datafield tag="(?!', TRIM(<<Field Tag>>), ').*?<\/datafield>'),
                ""
            ),
            /* Remove all non-datafield*/
            '.*?(<datafield.*<\/datafield>).*',
            "\\1"
        ),
        /* Remove all subfields with wrong tag */
        CONCAT('<subfield code="[^', TRIM("$" FROM TRIM(<<Subfield Code>>)), ']">.*?<\/subfield>'),
        ""
    ) as subfield
FROM biblio_metadata bm
WHERE ExtractValue(bm.metadata,
        CONCAT(
            '//datafield[@tag="',
            TRIM(<<Field Tag>>),
            '"]/subfield[@code="',
            TRIM("$" FROM TRIM(<<Subfield Code>>)),
            '"]'
        )
    ) != ""

/* Ce rapport exporte le contenu du sous-champs voulus pour toutes les notices de la base cotnenant le sous-champs
Retourne du XML avec unqiuement le datafield + subfield voulu */