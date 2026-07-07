SELECT borrowernumber,
    b.branchcode,
    b.surname AS "Patronyme",
    b.firstname AS "Prénom",
    c.description AS "Catégorie",
    GROUP_CONCAT(db.expiration SEPARATOR " | ") AS "Date d'expiration",
    GROUP_CONCAT(db.type SEPARATOR " | ") AS "Type de suspension",
    GROUP_CONCAT(db.comment SEPARATOR " | ") AS "Commentaire",
    GROUP_CONCAT(db.created SEPARATOR " | ") AS "Date de création"
FROM (
    SELECT borrowernumber,
        type,
        comment,
        created,
        expiration
    FROM borrower_debarments
    WHERE expiration > CURRENT_DATE()
    ORDER BY expiration ASC
    ) AS db
LEFT JOIN borrowers b USING(borrowernumber)
LEFT JOIN categories c USING(categorycode)
GROUP BY borrowernumber
ORDER BY branchcode ASC, db.expiration ASC
