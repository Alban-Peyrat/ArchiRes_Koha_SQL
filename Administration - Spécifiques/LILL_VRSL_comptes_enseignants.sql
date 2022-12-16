SELECT borrowernumber AS "ID",
    CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'">',borrowernumber,'</a>') as "Lien notice Koha",
    userid AS "userid",
    surname AS "Patronyme",
    firstname AS "Prénom",
    cardnumber AS "Code-barres",
    branchcode AS "Site",
    categorycode AS "Catégorie",
    dateenrolled AS "Date création",
    date_renewed AS "Date renouvellement",
    dateexpiry AS "Date expiration"

FROM borrowers

WHERE (
        (categorycode = "EC")
    AND 
        (
            (branchcode = "LILL")
            OR (branchcode = "VRSL")
        )
    )

ORDER BY dateexpiry ASC, surname ASC, firstname ASC

/* Rapport ID (test) : 1333
Rapport ID (prod) : 1320

Lié à #AR68

Liste les comptes enseignants pour Lille et Versailles */