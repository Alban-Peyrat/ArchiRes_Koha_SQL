SELECT borrowernumber,
    CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'">',borrowernumber,'</a>') AS "link",
    branchcode,
    userid,
    cardnumber,
    email,
    categorycode

FROM borrowers

WHERE ( 
        (email IS NULL OR email = "")
        OR (categorycode IN ("INC", "HMOAUE", "EP", "EXTPR"))
    )

/*  Rapport ID (test) : 1350
Rapport ID (prod) : 1332

AR91 : Renvoie tous les comptes qui seront rejetés à l'import Omeka-S */