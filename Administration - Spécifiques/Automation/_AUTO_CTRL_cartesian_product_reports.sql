SELECT id,
    report_name,
    notes,
    last_run,
    borrowernumber,
    replace(replace(savedsql,'\r',' '),'\n',' ') AS query,
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            replace(replace(savedsql,'\r',' '),'\n',' '),
            "(?im)\\sFROM\\s",
            "\nFROM "
        ),
        "(?im)\\sWHERE\\s",
        " WHERE\n"
        ) AS new_query

FROM saved_sql

HAVING (
    new_query REGEXP "\nFROM "
    AND new_query REGEXP "\nFROM.*,.*WHERE\n"
)

/* Rapport ID (test) : 1340
Rapport ID (prod) : 1340


UTILISÉ DANS DES AUTOMATIONS AR230 : liste les rapports avec de possibles produits cartésiens
Détection des produits cartésiens par BibLibre https://git.biblibre.com/biblibre/tools/src/branch/master/koha/db_check_reports.sh
https://mariadb.com/kb/en/pcre/#option-setting */