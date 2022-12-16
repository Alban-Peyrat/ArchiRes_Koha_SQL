SELECT biblionumber AS "Numéro de notice",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    LEFT(ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'), 1) AS '110$a pos. 0',
    b.abstract AS 'PPN',
    ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]') AS '110$a',
	COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'Titre / Sous-titre',
    b.author AS 'Auteur',
    bi.publicationyear AS "Date de publication",
	CONCAT ("[" , bi.itemtype, "] ", av.lib) AS "Type de document"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN authorised_values av ON bi.itemtype = av.authorised_value AND av.category = "TYPEDOC"

WHERE ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]') != ''

/* Rapport ID (test) : 1315
Rapport ID (prod) : 1305

Complément du rapport (prod) ID 1304 qui compte le nombre de documents groupés par 110 $a pos. 0

Liste les documents avec une 110$a */