SELECT biblionumber,
    TRIM(BOTH <<Field separator (pas < ou >) >> FROM REGEXP_REPLACE(
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
                        ),
                        /* Replaces subfields tags with infield separator */
                        '<\/subfield><subfield code=".">',
                        TRIM(<<Infield separator (pas < ou >) >>)
                    ),
                    /* Replaces datafield tags with field separator */
                    '<\/datafield><datafield tag="\\d+" ind1="." ind2=".">',
                    TRIM(<<Field separator (pas < ou >) >>)
                ),
                /* Removes all remaining tags*/
                '<\/?.+?>',
                ""
            ),
            /* Remove infield separator if multiples occurrences next to each other */
            CONCAT(TRIM(<<Infield separator (pas < ou >) >>), "+"),
            TRIM(<<Infield separator (pas < ou >) >>)
        ),
        /* Remove field separator if multiples occurrences next to each other */
        CONCAT(TRIM(<<Field separator (pas < ou >) >>), "+"),
        TRIM(<<Field separator (pas < ou >) >>)
    )) as subfield
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
Spécifier le infields + field delimiter */