SELECT biblionumber,
    itemnumber,
    barcode,
    LEFT(barcode, 4) AS "Code site exemplaire",
    itemcallnumber AS "Cote",
    homebranch AS "Code site"

FROM items

WHERE 
    (homebranch <> <<Choisir un site|branches>>)
    AND (LEFT(barcode, 4) = <<Choisir un site|branches>>)

/* Rapport ID (test) :  1336
Rapport ID (prod) : 1322

Liste les items dont le code-barre commence pas
par le code site sélectionné DANS LES AUTRES BIBLIOTHEQUES
Lié à #AR77 */