SELECT biblionumber AS "Numéro de notice",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    LEFT(ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'), 1) AS '110$a pos. 0',
    b.abstract AS 'PPN',
    ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]') AS '110$a',
    ExtractValue(bm.metadata, '//datafield[@tag="011"]/subfield[@code="a"]') AS '011',
    ExtractValue(bm.metadata, '//datafield[@tag="207"]/subfield[@code="a"]') AS '207',
    ExtractValue(bm.metadata, '//leader') AS 'Label',
    MID(ExtractValue(bm.metadata, '//leader'), 7, 2) AS 'Label type doc',
	COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'Titre / Sous-titre',
    b.author AS 'Auteur',
    bi.publicationyear AS "Date de publication",
	CONCAT ("[" , bi.itemtype, "] ", av.lib) AS "Type de document"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN authorised_values av ON bi.itemtype = av.authorised_value AND av.category = "TYPEDOC"

WHERE (
    b.abstract != ''
    AND ExtractValue(bm.metadata, '//datafield[@tag="011"]') != ''
    AND LEFT(ExtractValue(bm.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'), 1) IN ("a", "c", "d", "e", "j", "m", "n", "z")
    AND ExtractValue(bm.metadata, '//datafield[@tag="207"]') != ''
    AND MID(ExtractValue(bm.metadata, '//leader'), 7, 2) = 'as'
    )

/* Rapport ID (test) : 1317
Rapport ID (prod) : 1308

Liste les documents correspondant à la nouvelle passerelle Sudoc pour le type doc REV */