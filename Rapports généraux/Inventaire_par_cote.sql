SELECT b.biblionumber,
    bi.itemtype,
    b.title,
    b.author,
    bi.isbn,
    i.barcode,
    i.itemcallnumber,
    i.location,
    i.stocknumber

FROM biblio b
JOIN items i USING(biblionumber)
JOIN biblioitems bi USING(biblionumber)

WHERE  i.homebranch = <<Bibliothèque |branches>>
    AND IF (<<Limiter à un type de document |OUINON>>, bi.itemtype = <<Si oui |TYPEDOC>>, 1)
    AND IF (<<Limiter à une localisation |OUINON>>, i.location = <<Si oui |LOC>>, 1)
    AND  i.itemcallnumber LIKE concat(<<Cote qui débute par >>,'%')

ORDER BY i.itemcallnumber

/* Inventaire par cote, type de document [optionnel] et localisation [optionnel]
Ex-780 Ex-1191 Ex-1205 Ex-1132 #AR230

Rapport ID (prod) : 1341

Optionnal params from "Count of collection by Dewey 10s (tens) optional branch/itemtype limit" (Koha SQL Reports Library) */