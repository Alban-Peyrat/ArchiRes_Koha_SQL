SELECT biblionumber AS "Numéro de notice",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    ExtractValue(bm.metadata, '//datafield[@tag="923"]/subfield[@code="a"]') AS '923$a',
	COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'Titre / Sous-titre',
    b.author AS 'Auteur',
    bi.publicationyear AS "Date de publication",
	bi.itemtype AS "Type de document"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE (
    LEFT(ExtractValue(bm.metadata, '//datafield[@tag="923"]/subfield[@code="a"]'), 1) <> ""
    AND bi.itemtype <> "REV"
    )



/* Rapport ID (test) : 1342
Rapport ID (prod) : 1326


Liste les documents avec une 923 qui ne sont pas des revues */