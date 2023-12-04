SELECT biblionumber,
    itemnumber,
    homebranch,
    holdingbranch,
    barcode,
    location,
    itemcallnumber
FROM items
WHERE 
    homebranch IS NULL
    OR holdingbranch IS NULL
    OR homebranch NOT IN (
                SELECT branchcode
                FROM branches
                )
    OR holdingbranch NOT IN (
                SELECT branchcode
                FROM branches
                )

/* Rapport ID (test) : 1473
Rapport ID (prod) : 1481

UTILISÉ DANS DES AUTOMATIONS : liste les exemplaires dont l'un des sites est invalide (inspiré du #MT28986) */