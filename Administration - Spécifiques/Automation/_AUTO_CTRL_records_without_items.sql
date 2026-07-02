SELECT biblionumber,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="801"]/subfield[@code="b"]') AS "801$b",
    b.title,
    b.author,
    GROUP_CONCAT(IFNULL(a.ordernumber, '') SEPARATOR '_') AS ordernumbers,
    GROUP_CONCAT(IFNULL(a.orderstatus, '') SEPARATOR '_') AS orderstatus


FROM biblio b
JOIN biblioitems bi USING(biblionumber)
JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN items i USING(biblionumber)
LEFT JOIN aqorders a USING(biblionumber)

WHERE (
    (i.itemnumber IS NULL)
    AND (b.frameworkcode != "ACQ")
    AND (b.abstract IS NULL)
    AND (bi.itemtype != "COLL")
    AND (a.biblionumber IS NULL OR a.orderstatus = "cancelled")
)

GROUP BY biblionumber

/* Rapport ID (test) : 1339
Rapport ID (prod) : 1339

AR236 : notices bibliographiques sans exemplaires qui n'ont pas de PPN, ne sont pas d'acquisition et ne sont pas des collections
Adaptation from https://wiki.koha-community.org/wiki/SQL_Reports_Library#Records_without_items */