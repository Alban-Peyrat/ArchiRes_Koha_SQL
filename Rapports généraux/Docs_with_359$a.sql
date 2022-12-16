SELECT biblionumber AS "Numéro de notice",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="a"]') AS '359$a',
	COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'Titre / Sous-titre',
    b.author AS 'Auteur',
    bi.publicationyear AS "Date de publication"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="a"]') != ''

/* Rapport ID (test) : 1329
Rapport ID (prod) : 1317

Basé sur le rapport listant les 110$a pos. 0 = n (ID PROD : 1305)

Liste les documents avec une 359$a */