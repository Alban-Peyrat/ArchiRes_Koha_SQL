SELECT borrowernumber,
    CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'">',borrowernumber,'</a>') AS "link",
    branchcode,
    userid,
    cardnumber,
    email,
    categorycode

FROM borrowers

WHERE ( 
        (email IS NOT NULL OR email != "")
        AND (categorycode NOT IN ("INC", "HMOAUE", "EP", "EXTPR"))
        AND (email IN (
            SELECT email FROM borrowers WHERE (email IS NOT NULL AND email != "") GROUP BY email HAVING COUNT(*) >1
        ))
    )

/*  Rapport ID (test) : 1352
Rapport ID (prod) : 

AR91 : Renvoie tous les comptes qui seront rejetés avec erreur à l'import Omeka-S */