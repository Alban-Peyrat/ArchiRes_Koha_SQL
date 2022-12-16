SELECT i.biblionumber AS 'bibnb',
    COUNT(i.itemnumber) AS "nb_items",
    COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'title',
    b.author AS 'aut',
    bi.publicationyear AS "date"

FROM items i
JOIN biblioitems bi ON i.biblionumber=bi.biblionumber
JOIN biblio b ON i.biblionumber=b.biblionumber

GROUP BY i.biblionumber

HAVING COUNT(i.itemnumber)>999

/* Rapport ID (test) : 1343
Rapport ID (prod) : 1327

#AR172 : liste les documents avec plus de 1000 exemplaires */