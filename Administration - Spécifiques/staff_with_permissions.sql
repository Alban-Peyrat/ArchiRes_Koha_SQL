SELECT
	a.borrowernumber,
	surname AS 'Patronyme',
  	firstname AS 'Prénom',
  	branchcode,
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
) a
LEFT JOIN categories ON (a.categorycode=categories.categorycode)

ORDER BY branchcode ASC, surname ASC

/* From https://wiki.koha-community.org/wiki/SQL_Reports_Patrons#Patrons_with_staff_permission.2C_and_if_they_are_superlibrarians
*/