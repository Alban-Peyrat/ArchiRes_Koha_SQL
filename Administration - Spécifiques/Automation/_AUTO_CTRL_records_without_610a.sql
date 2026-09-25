SELECT biblionumber,
    bi.itemtype,
    b.datecreated,
    ExtractValue(bm.metadata, 'count(//datafield[@tag="609"])') AS "nb_609",
    ExtractValue(bm.metadata, 'count(//datafield[@tag="615"])') AS "nb_615"
FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
WHERE TRIM(ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"]')) = ""
    AND bi.itemtype NOT IN ("COLL")
    AND (b.frameworkcode != "ACQ") /* useless btw */
    AND ExtractValue(bm.metadata, 'count(//datafield[@tag="801"])') > 0
/* UTILISÉ DANS DES AUTOMATIONS : liste les documents n'ayant pas de 610$a & n'étant pas d'acquisition */