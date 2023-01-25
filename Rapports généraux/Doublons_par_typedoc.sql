SELECT b.title,
    i.itemtype,
    i.publicationyear,
    count(*)

FROM biblio b
JOIN biblioitems i USING(biblionumber)

WHERE i.itemtype  = <<type de document |TYPEDOC>>

GROUP BY b.title, i.publicationyear

HAVING count(*) >1

/* Liste des doublons de DVD basé sur le titre et année de publication
Ex-1253 - #AR230 */