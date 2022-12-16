SELECT biblionumber,
        CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'">',b.biblionumber,'</a>') AS 'Accès notice',
        ExtractValue(bm.metadata, '//datafield[@tag="098"]/subfield[@code="e"]') AS 'Date de 1re màj Sudoc',
        ExtractValue(bm.metadata, '//datafield[@tag="991"]/subfield[@code="a"]') AS '991$a', 
        b.abstract AS 'PPN',
        ExtractValue(bm.metadata, '//controlfield[@tag="009"]') AS '009'

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE 
	(biblionumber LIKE <<Bibnb0 ?>>)
    OR (biblionumber LIKE <<Bibnb1 ?>>)
    OR (biblionumber LIKE <<Bibnb2 ?>>)
    OR (biblionumber LIKE <<Bibnb3 ?>>)
    OR (biblionumber LIKE <<Bibnb4 ?>>)
    OR (biblionumber LIKE <<Bibnb5 ?>>)
   
/* /!\ NE PAS UTILISER /!\
(sauf si on sait ce qu'on fait)

Rapport ID (prod) : 1299

Changez les selects selon nécessité. 

Donne les informations sélectionnées pour X biblionumber. */