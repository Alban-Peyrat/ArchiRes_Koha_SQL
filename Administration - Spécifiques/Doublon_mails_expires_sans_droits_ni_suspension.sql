SELECT COUNT(*) AS "nb",
	b.email AS "email",
    GROUP_CONCAT(borrowernumber SEPARATOR '|') AS "borrowernumbers",
    GROUP_CONCAT(IFNULL(b.branchcode, '') SEPARATOR '|') AS "branchcodes",
    GROUP_CONCAT(IFNULL(b.userid, '') SEPARATOR '|') AS "userids",
    GROUP_CONCAT(IFNULL(b.cardnumber, '') SEPARATOR '|') AS "cardnumbers",
    GROUP_CONCAT(IFNULL(b.dateexpiry, '') SEPARATOR '|') AS "dateexpiry",
    GROUP_CONCAT(IFNULL(b.debarred, '') SEPARATOR '|') AS "restriction",
    GROUP_CONCAT(IFNULL(b.debarredcomment, '') SEPARATOR '|') AS "noterestriction"
    

FROM borrowers b

WHERE (b.email IS NOT NULL AND b.email != "")
GROUP BY b.email HAVING COUNT(*) >1

/*  Rapport ID (test) : 1348
Rapport ID (prod) : 1330

AR91 : préparation du passage de Bokeh à la 8.0.173

Renvoie tous les email principaux qui sont associés à plusieurs adhérents,
avec le nombre de comptes concernés et des informations sur chaque compte.

Séparateur = "|" parce que Koha exporte en ";" comme séparateur

Basé sur le rapport ID 1303 */