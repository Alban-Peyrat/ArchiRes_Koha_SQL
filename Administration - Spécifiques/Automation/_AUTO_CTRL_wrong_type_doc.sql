SELECT b.biblionumber AS 'bibnb',
    bi.itemtype AS 'type_doc',
    b.abstract AS 'ppn',
    (SELECT GROUP_CONCAT(DISTINCT homebranch SEPARATOR '|') FROM items WHERE biblionumber = b.biblionumber) AS "branch",
    (SELECT COUNT(*) FROM aqorders WHERE biblionumber = b.biblionumber) AS "nb_order",
    b.datecreated AS "date_creation_Koha"

FROM biblio b
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN aqorders a USING(biblionumber)

WHERE (
        (
            (bi.itemtype NOT IN (
                SELECT authorised_value 
                FROM authorised_values
                WHERE category = "TYPEDOC"
                )
            )
            OR (bi.itemtype IS NULL)
        )
        AND (a.biblionumber IS NULL OR a.orderstatus = "cancelled")
/*        AND (biblionumber NOT IN (
            SELECT biblionumber
            FROM aqorders
            WHERE orderstatus != "cancelled"
            )
        )*/
        AND (b.abstract != "PPN001" OR b.abstract IS NULL) /* Do not del PPN001 records */
    )

GROUP BY biblionumber

/* Rapport ID (test) : 1328
Rapport ID (prod) : 1328

UTILISÉ DANS DES AUTOMATIONS #AR180
Liste les document sans type de doc / avec type de doc invalide */