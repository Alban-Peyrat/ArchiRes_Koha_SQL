SELECT i.biblionumber,
 	i.itemnumber,
    i.barcode,
    av2.lib AS "Perdu ?",
    av.lib AS "État",
    (
        SELECT COUNT(*)
        FROM items
        WHERE 
            biblionumber = i.biblionumber
            AND homebranch = <<Bibliothèque|branches>>  
            AND itemlost = 0
            AND notforloan != "8"
    ) AS "Nb exemplaires non perdus pour cette école",
    (
        SELECT COUNT(*)
        FROM items
        WHERE 
            biblionumber = i.biblionumber
            AND homebranch != <<Bibliothèque|branches>> 
    ) AS "Nb total d'exemplaires dans les autres écoles",
    (
        SELECT COUNT(*)
        FROM items
        WHERE 
            biblionumber = i.biblionumber
            AND homebranch != <<Bibliothèque|branches>> 
            AND (
                itemlost != 0
                OR notforloan = "8"
            )
    ) AS "Nb d'exemplaires perdus dans les autres écoles"
FROM items i
LEFT JOIN authorised_values av ON i.notforloan = av.authorised_value AND av.category = "ETAT"
LEFT JOIN authorised_values av2 ON i.itemlost = av2.authorised_value AND av2.category = "LOST"
WHERE 
 	i.homebranch = <<Bibliothèque|branches>> 
    AND (
     	i.itemlost != 0
        OR i.notforloan = "8"
    )

/* Pour une école donnée, liste tous les exemplaires perdus,
le nombre d'exemplaires non perdus pour l'école et le nombre
total d'exempalire / d'exemplaires perdus dans les autres école */