SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\">',b.biblionumber,'</a>') AS biblionumber,
    b.title,
    b.author,
    b.subtitle,
    b.unititle,
    bi.itemtype,
    bi.publishercode,
    bi.publicationyear,
    bi.isbn,
    bi.collectiontitle,
    i.homebranch

FROM biblioitems bi
LEFT JOIN items i on (bi.biblioitemnumber=i.biblioitemnumber) 
LEFT JOIN biblio b on (bi.biblionumber=b.biblionumber)

WHERE (bi.isbn IS NULL OR bi.isbn LIKE "")
    AND i.homebranch = <<Bibliothèque |branches>>

GROUP BY b.biblionumber

ORDER BY b.title asc


/* Rapport ID (test) : 1325
Rapport ID (prod) : 1313

Renvoie tous les numéros de notice de l'ENSA Marseille
qui n'ont pas d'ISBN.

Dans le cadre de l'IMVT
Adapté de celui transmis par S A-C */