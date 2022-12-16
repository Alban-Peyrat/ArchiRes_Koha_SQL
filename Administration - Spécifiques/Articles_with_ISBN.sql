SELECT biblionumber AS "bibnb",
    bi.itemtype AS 'type_doc',
	ExtractValue(bm.metadata, '//datafield[@tag="010"]/subfield[@code="a"]') AS "ISBN_a",
    ExtractValue(bm.metadata, '//datafield[@tag="010"]/subfield[@code="z"]') AS "ISBN_z",
    IF(ExtractValue(bm.metadata, '//datafield[@tag="330"]') != "", 1, 0) AS "resume",
    IF(ExtractValue(bm.metadata, '//datafield[@tag="463"]') != "", 1, 0) AS "463",
    IF(
        (
            ExtractValue(bm.metadata, '//datafield[@tag="700"]') != ""
            OR ExtractValue(bm.metadata, '//datafield[@tag="701"]') != ""
        ),
        1,
        0
    ) AS "auteur",
    IF(ExtractValue(bm.metadata, '//datafield[@tag="215"]') != "", 1, 0) AS "description",
    IF(ExtractValue(bm.metadata, '//datafield[@tag="410"]') != "", 1, 0) AS "410",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien_Koha"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE (
    bi.itemtype = "ART"
    AND (
        ExtractValue(bm.metadata, '//datafield[@tag="010"]/subfield[@code="a"]') != ''
        OR ExtractValue(bm.metadata, '//datafield[@tag="010"]/subfield[@code="z"]') != ''
        )
    )

/* Rapport ID (test) : 1347
Rapport ID (prod) : 1329

#AR179 : Liste les articles de revues avec un ISBN */