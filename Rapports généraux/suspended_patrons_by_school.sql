SELECT borrowernumber,
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
    WHERE 
        expiration > CURRENT_DATE()
        OR expiration IS NULL
    ORDER BY expiration ASC
    ) AS db
LEFT JOIN borrowers b USING(borrowernumber)
LEFT JOIN categories c USING(categorycode)
WHERE b.branchcode = <<Bibliothèque|branches>> 
GROUP BY borrowernumber
ORDER BY db.expiration ASC

/* Main report is suspended_patrons.sql
Make sure to uppdate all related, except if only applies here */