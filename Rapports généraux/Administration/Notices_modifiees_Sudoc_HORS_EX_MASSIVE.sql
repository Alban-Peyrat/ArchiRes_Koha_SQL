SELECT biblionumber,
        CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'">',b.biblionumber,'</a>') AS 'Accès notice',
        ExtractValue(bm.metadata, '//datafield[@tag="098"]/subfield[@code="e"]') AS 'Date de 1re màj Sudoc',
        ExtractValue(bm.metadata, '//datafield[@tag="991"]/subfield[@code="a"]') AS '991$a', 
        b.abstract AS 'PPN',
        b.title AS "Titre propre",
        b.author AS "Auteurs (200$f)",
        bi.itemtype AS "Type de document"
FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
WHERE (ExtractValue(metadata, '//datafield[@tag="098"]/subfield[@code="e"]') LIKE CONCAT(<<Sélectionnez le jour (JJ/MM/AAAA)|date>>,'%'))
AND NOT (
                (
                ExtractValue(metadata, '//datafield[@tag="991"]/subfield[@code="a"]')
                LIKE CONCAT("%Exemplaire créé en masse par ITEM. le ",
                        DATE_FORMAT(DATE_SUB(<<Sélectionnez le jour (JJ/MM/AAAA)|date>>, INTERVAL 1 DAY),'%d-%m-%Y'),
                        '%')
                )
        OR
                (
                ExtractValue(metadata, '//datafield[@tag="991"]/subfield[@code="a"]')
                LIKE CONCAT("%Exemplaire créé en masse par ITEM. le ",
                        DATE_FORMAT(DATE_SUB(<<Sélectionnez le jour (JJ/MM/AAAA)|date>>, INTERVAL 2 DAY),'%d-%m-%Y'),
                        '%')
                )
        OR
                (
                ExtractValue(metadata, '//datafield[@tag="991"]/subfield[@code="a"]')
                LIKE CONCAT("%Exemplaire créé en masse par ITEM. le ",
                        DATE_FORMAT(DATE_SUB(<<Sélectionnez le jour (JJ/MM/AAAA)|date>>, INTERVAL 3 DAY),'%d-%m-%Y'),
                        '%')
                )
        )

/* Renvoie toutes les notices importées du Sudoc le jour renseigné
SAUF celles dont un exemplaire a été créé dans les 3 derniers jours par ITEM

ID base de test : 1299
ID base de prod : 1298

Les imports ont un délai de 1 ou 2 ou 3 jours de ce que j'ai pu voir
Pour des tests :
 - 2021-03-18 (import le 17)
 - 2021-03-08 (import le 06)
 - 2022-07-11 pour voir que les vieux exports ne sont pas comptés

Performances :
 - Script original (ID 733) :
   - sur le 18/03/2021 : 38 secondes
   - sur le 08/03/2021 : 34 secondes
 - Mon script (ID 1299 base Test (avec seulement 2 OR)) :
   - sur le 18/03/2021 : 56 secondes
   - sur le 08/03/2021 : 53 secondes */