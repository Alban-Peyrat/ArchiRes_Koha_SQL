SELECT biblionumber,
    bi.itemtype,
    b.datecreated
FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
WHERE TRIM(ExtractValue(bm.metadata, '//datafield[@tag="330"]/subfield[@code="a"]')) = ""
    AND bi.itemtype NOT IN ("REV", "REVELEC", "COLL")
    AND (b.frameworkcode != "ACQ") /* useless btw */
    AND ExtractValue(bm.metadata, 'count(//datafield[@tag="801"])') > 0
/* UTILISÉ DANS DES AUTOMATIONS : liste les documents n'ayant pas de 330$a et qui ne sont pas d'acquisitions */