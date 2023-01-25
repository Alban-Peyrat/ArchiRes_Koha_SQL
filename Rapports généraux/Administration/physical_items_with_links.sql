SELECT biblionumber,
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "link",
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="856"]/subfield[@code="u"]') AS '856$u',
    i.uri AS '995$7'

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN items i USING(biblionumber)

WHERE (
    (bi.itemtype NOT IN ("ECART", "REVELEC", "RESELEC", "ELIV", "EDOCA"))
    AND (
        (ExtractValue(bm.metadata, '//datafield[@tag="856"]/subfield[@code="u"]') <> "")
        OR (i.uri IS NOT NULL)
        )
    )

/*GROUP BY biblionumber*/

/*  Rapport ID (test) : 1353
Rapport ID (prod) : 1335

AR192 : Liste les documents imprimés avec un lien numérique */