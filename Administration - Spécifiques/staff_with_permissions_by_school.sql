SELECT
	a.borrowernumber,
	surname AS 'Patronyme',
  	firstname AS 'Prénom',
  	Cardnumber AS "Numéro de carte",
  	categories.description AS 'Catégorie',
  	Superlibrarian AS "Superlibrarian ?"

FROM (
    SELECT
        surname,
        firstname,
        branchcode,
        categorycode,
        borrowers.borrowernumber,
        CONCAT(
            '<a href="http://',
            (SELECT value FROM systempreferences WHERE variable='staffClientBaseURL'),
            '/cgi-bin/koha/members/moremember.pl?borrowernumber=',
            bn.borrowernumber,
            '">',
            cardnumber,
            '</a>'
        ) AS 'Cardnumber',
        CASE WHEN flags%2=1 THEN 'Oui' WHEN flags%2=0 THEN 'Non' END AS Superlibrarian
    FROM (
        SELECT borrowernumber
        FROM borrowers
        WHERE flags > 0
        UNION
        SELECT DISTINCT borrowernumber
        FROM user_permissions
    ) bn 
    LEFT JOIN borrowers ON (borrowers.borrowernumber=bn.borrowernumber)
    WHERE branchcode =  <<Bibliothèque|branches>> 
) a
LEFT JOIN categories ON (a.categorycode=categories.categorycode)

ORDER BY branchcode ASC, surname ASC

/* Main report is staff_with_permissions.sql
Make sure to uppdate all related, except if only applies here */