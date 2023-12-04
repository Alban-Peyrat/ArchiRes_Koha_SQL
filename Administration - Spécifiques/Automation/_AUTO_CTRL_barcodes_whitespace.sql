SELECT biblionumber,
    itemnumber,
    barcode
FROM items
WHERE
    barcode REGEXP "\\s+$"
    OR barcode REGEXP "^\\s+"

/* Rapport ID (test) : 1472
Rapport ID (prod) : 1480

UTILISÉ DANS DES AUTOMATIONS : liste les code-barre commençant ou s'achevant par un espace */