SELECT b.borrowernumber AS "Koha ID",
    CASE WHEN flags%2=1 THEN 'yes' WHEN flags%2=0 THEN 'no' END AS "Superlibrarian",
    GROUP_CONCAT(IFNULL(up.module_bit, '') SEPARATOR '|') AS "Permission module_bit",
    GROUP_CONCAT(IFNULL(up.code, '') SEPARATOR '|') AS "Koha permission code",
    GROUP_CONCAT(IFNULL(p.description, '') SEPARATOR '|') AS "Koha permission name",
    b.branchcode AS "École",
    b.flags AS "Permissions",
    b.cardnumber AS "Code-barre",
    b.surname AS "Patronyme",
    b.firstname AS "Prénom",
    b.categorycode AS "Catégorie",
    b.dateexpiry AS "Expiration le"

FROM borrowers b

LEFT JOIN user_permissions up ON b.borrowernumber = up.borrowernumber
LEFT JOIN permissions p ON up.code = p.code 

WHERE b.flags > 0 OR up.module_bit > 0

GROUP BY b.borrowernumber

ORDER BY b.surname

/*  Rapport ID (test) : 1322
Rapport ID (prod) : 1312

Renvoie les permissions associées à un compte.

Imagine savoir lire et comprendre qu'il y a plusieurs pages dans la bibliothèque de rapport Koha

https://wiki.koha-community.org/wiki/SQL_Reports_Patrons#Patrons_with_staff_permission.2C_and_if_they_are_superlibrarians */