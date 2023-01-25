SELECT borrowernumber,
    CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'">',borrowernumber,'</a>') AS "link",
    branchcode,
    userid,
    cardnumber,
    email,
    categorycode

FROM borrowers

WHERE (
    (categorycode IN ("INC", "EXTPR"))
    OR (borrowernumber IN (
        SELECT borrowernumber FROM borrower_debarments WHERE comment LIKE '%double compte%'
        ))
    )

/*  Rapport ID (test) : 1351
Rapport ID (prod) : 

AR91 : Renvoie tous les comptes qui seront rejetés à l'import Bokeh */