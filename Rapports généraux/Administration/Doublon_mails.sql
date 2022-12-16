SELECT COUNT(*) AS "Nombre de doublons",
	email AS "E-mail",
    GROUP_CONCAT(borrowernumber SEPARATOR '|') AS "Numéros d'adhérent",
    GROUP_CONCAT(CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'">',borrowernumber,'</a>') SEPARATOR '|') AS "Liens notices",
    GROUP_CONCAT(IFNULL(branchcode, '') SEPARATOR '|') AS "Codes des sites de rattachement",
    GROUP_CONCAT(IFNULL(userid, '') SEPARATOR '|') AS "Identifiants",
    GROUP_CONCAT(IFNULL(cardnumber, '') SEPARATOR '|') AS "Numéros de carte"
FROM borrowers
WHERE (email IS NOT NULL AND email != "")
GROUP BY email HAVING COUNT(*) >1

/*  Rapport ID (test) : 1300
Rapport ID (prod) : 1303

Renvoie tous les email principaux qui sont associés à plusieurs adhérents,
avec le nombre de comptes concernés et des informations sur chaque compte.

Séparateur = "|" parce que Koha exporte en ";" comme séparateur

Basé sur le rapport ID 1190 */