SELECT biblionumber,
    itemnumber,
    barcode,
    LEFT(barcode, 4) AS "Code site exemplaire",
    itemcallnumber AS "Cote",
    homebranch AS "Code site"

FROM items

WHERE 
    (homebranch=<<Choisir un site|branches>>)
    AND (LEFT(barcode, 4) <> <<Choisir un site|branches>>)

/* Rapport ID (test) :  1334
Rapport ID (prod) : 1321

Liste les items dont le code-barre ne commence pas
par le code site sélectionné
Lié à #AR77 */