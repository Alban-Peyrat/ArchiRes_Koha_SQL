SELECT itemnumber,
    biblionumber,
    b.abstract,
    barcode,
    location
FROM items
LEFT JOIN biblio b USING(biblionumber)
WHERE
    location NOT IN (
        SELECT authorised_value
        FROM authorised_values
        WHERE category='LOC'
        )
    AND location IS NOT NULL

/* Rapport ID (test) : 1469
Rapport ID (prod) : 1484

UTILISÉ DANS DES AUTOMATIONS : liste les exemplaires dont la localisation est invalide (#MT42798) */