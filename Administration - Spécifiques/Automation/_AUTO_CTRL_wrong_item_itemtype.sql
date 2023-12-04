SELECT itemnumber,
    biblionumber,
    b.abstract,
    barcode,
    itype,
    homebranch
FROM items
LEFT JOIN biblio b USING(biblionumber)
WHERE
    itype NOT IN (SELECT itemtype FROM itemtypes)
    OR itype IS NULL

/* Rapport ID (test) : 1467
Rapport ID (prod) : 1482

UTILISÉ DANS DES AUTOMATIONS : liste les exemplaires dont le type de prêt est invalide (#MT42798) */