SELECT b.borrowernumber,
    b.firstname AS "Prénom",
    b.surname AS "Patronyme",
    c.description AS "Catégorie",
    b.userid AS "Identifiant Koha (userid)",
    ba.attribute AS "EPPN"

FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN categories c USING(categorycode)

WHERE branchcode IN <<Bibliothèque de rattachement (pour en sélectionner plusieurs, appuyer sur la touche Ctrl lors du clic sur le nom de l'école)|branches:in>>
    AND ba.attribute IS NOT NULL
    AND length(ba.attribute) > 50