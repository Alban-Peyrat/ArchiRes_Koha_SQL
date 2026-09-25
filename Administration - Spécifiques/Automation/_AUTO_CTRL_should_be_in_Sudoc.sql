SELECT b.biblionumber,
    b.datecreated,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="801"]/subfield') as "801"

FROM biblio b
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE b.abstract IS NULL
    AND bi.itemtype IN ("LIV","DOCA","CART","REV","COLL")
    AND b.datecreated > "2026-09-20"
    AND (b.frameworkcode != "ACQ") /* useless btw */
    AND ExtractValue(bm.metadata, 'count(//datafield[@tag="801"])') > 0
/* UTILISÉ DANS DES AUTOMATIONS : liste les documents qui devraient être dans le Sudoc (commence 2026-09-20) */
