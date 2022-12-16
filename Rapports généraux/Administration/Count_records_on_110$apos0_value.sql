SELECT COUNT(biblionumber) AS "Nombres de notices",
    ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]') AS '110$a',
    LEFT(ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'), 1) AS '110$a pos. 0'

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]') != ''

GROUP BY LEFT(ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'), 1)

/* Rapport ID (test) : 1314
Rapport ID (prod) : 1304

Compte le nombre de documents groupés par 110 $a pos. 0*/