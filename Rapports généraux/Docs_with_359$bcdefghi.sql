SELECT biblionumber AS "Numéro de notice",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="b"]') AS '359$b',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="c"]') AS '359$c',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="d"]') AS '359$d',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="e"]') AS '359$e',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="f"]') AS '359$f',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="g"]') AS '359$g',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="h"]') AS '359$h',
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="i"]') AS '359$i',
	COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'Titre / Sous-titre',
    b.author AS 'Auteur',
    bi.publicationyear AS "Date de publication"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE (
    ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="b"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="c"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="d"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="e"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="f"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="g"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="h"]') != ''
    OR ExtractValue(bm.metadata, '//datafield[@tag="359"]/subfield[@code="i"]') != ''
)

/* Rapport ID (test) : 1330
Rapport ID (prod) : 

Basé sur le rapport listant les 359a$ (ID PROD : 1317)

Liste les documents avec une 359$bcdefghi */