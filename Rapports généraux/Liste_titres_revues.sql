SELECT b.biblionumber,
    bi.issn,
    b.abstract,
    b.title

FROM biblio b
JOIN biblioitems bi USING(biblionumber)
JOIN items i USING(biblionumber)

WHERE bi.itemtype='REV'
    AND i.homebranch = <<Bibliothèque |branches>>

GROUP BY biblionumber

/* Liste les titres de revue
Ex-1169 - #AR230 */