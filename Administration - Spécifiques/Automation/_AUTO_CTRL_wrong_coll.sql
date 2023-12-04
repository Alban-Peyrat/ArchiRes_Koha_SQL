SELECT itemnumber,
    biblionumber,
    b.abstract,
    barcode,
    ccode
FROM items
LEFT JOIN biblio b USING(biblionumber)
WHERE
    ccode NOT IN (
        SELECT authorised_value
        FROM authorised_values
        WHERE category='coll'
        )
    AND ccode IS NOT NULL

/* Rapport ID (test) : 1468
Rapport ID (prod) : 1483

UTILISÉ DANS DES AUTOMATIONS : liste les exemplaires dont la collection est invalide (#MT42798) */