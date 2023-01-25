SELECT biblionumber,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="801"]/subfield[@code="b"]'),
    b.title,
    b.author

FROM biblio b
JOIN biblioitems bi USING(biblionumber)
JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN items i USING(biblionumber)

WHERE (
    (i.itemnumber IS NULL)
    AND (b.frameworkcode != "ACQ")
    AND (b.abstract IS NULL)
    AND (bi.itemtype != "COLL")
)


/* Rapport ID (test) : 1339
Rapport ID (prod) : 1339

AR236 : notices bibliographiques sans exemplaires qui n'ont pas de PPN, ne sont pas d'acquisition et ne sont pas des collections
Adaptation from https://wiki.koha-community.org/wiki/SQL_Reports_Library#Records_without_items */