SELECT COUNT(*) AS "Nombre de doublons",
	email AS "E-mail",
    GROUP_CONCAT(borrowernumber SEPARATOR '|') AS "Numéros d'adhérent",
    GROUP_CONCAT(CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'">',borrowernumber,'</a>') SEPARATOR '|') AS "Liens notices",
    GROUP_CONCAT(IFNULL(branchcode, '') SEPARATOR '|') AS "Codes des sites de rattachement",
    GROUP_CONCAT(IFNULL(userid, '') SEPARATOR '|') AS "Identifiants",
    GROUP_CONCAT(IFNULL(categorycode, '') SEPARATOR '|') AS "Catégorie",
    GROUP_CONCAT(IFNULL(cardnumber, '') SEPARATOR '|') AS "Numéros de carte",
    GROUP_CONCAT(IFNULL(dateexpiry, '') SEPARATOR '|') AS "dateexpiry",
    GROUP_CONCAT(IFNULL(debarred, '') SEPARATOR '|') AS "restriction",
    GROUP_CONCAT(IFNULL(debarredcomment, '') SEPARATOR '|') AS "noterestriction"
FROM borrowers

WHERE (
    (email IS NOT NULL AND email != "")
    AND (borrowernumber NOT IN (
        SELECT borrowernumber FROM borrower_debarments WHERE comment LIKE '%double compte%'
        ))
    )

GROUP BY email HAVING COUNT(*) >1

/*  Rapport ID (test) : 1300
Rapport ID (prod) : 1303

Renvoie tous les email principaux qui sont associés à plusieurs adhérents,
avec le nombre de comptes concernés et des informations sur chaque compte,
sauf ceux qui sont déjà marqués comme double comptes.

Séparateur = "|" parce que Koha exporte en ";" comme séparateur

Basé sur le rapport ID 1190 */