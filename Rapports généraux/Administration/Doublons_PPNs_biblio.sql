SELECT COUNT(*) AS "Nombre de doublons",
	b.abstract AS 'PPN',
    ExtractValue(bm.metadata, '//controlfield[@tag="009"]') AS '009',
    GROUP_CONCAT(CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') SEPARATOR ';') AS "Liens Koha",
    GROUP_CONCAT(IFNULL(biblionumber, '') SEPARATOR ';') AS "Numéros de notices"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE (b.abstract IS NOT NULL AND b.abstract != "")

GROUP BY b.abstract HAVING COUNT(*) >1

/* Rapport ID (prod) : 1300

Liste les PPN contenus dans le 009 de plusieurs notices. Basé sur biblio.abstract */