SELECT b.borrowernumber AS "Borrowernumber",
    b.userid AS "userid",
    b.categorycode AS "Code catégorie",
    b.branchcode AS "Code site",
    b.cardnumber AS "Numéro de carte",
    b.surname AS "Patronyme",
    b.firstname AS "Prénom",
    b.dateexpiry AS "Date d'expiration"

FROM borrowers b

WHERE (b.categorycode = "DOC")

ORDER BY b.dateexpiry

/* Rapport ID (test) : 1320
Rapport ID (prod) : 1311

Liste les usagers avec le categorycode DOC */