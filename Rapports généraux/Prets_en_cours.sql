SELECT b.surname,
    b.firstname,
    b.categorycode,
    t.title,
    i.barcode,
    i.itemcallnumber,
    i.location,
    p.date_due

FROM issues p
JOIN items i ON i.itemnumber = p.itemnumber
JOIN biblio t ON t.biblionumber = i.biblionumber
JOIN borrowers b ON b.borrowernumber=p.borrowernumber

WHERE i.homebranch = <<Bibliothèque |branches>>

/* Liste des prêts en cours
Ex-692 #AR230 */