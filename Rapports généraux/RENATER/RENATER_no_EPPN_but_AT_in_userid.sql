SELECT b.borrowernumber,
    br.branchname AS "Bibliothèque",
    b.firstname AS "Prénom",
    b.surname AS "Patronyme",
    c.description AS "Catégorie",
    b.userid AS "Identifiant Koha (userid)",
    ba.attribute AS "EPPN"

FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN categories c USING(categorycode)
LEFT JOIN branches br ON b.branchcode = br.branchcode

WHERE ba.attribute IS NULL
	AND INSTR(b.userid, "@") > 0

/* Main report for WHERE is RENATER_EPPN_control.sql
Main report for SELECT is RENATER_EPPN_trop_long.sql
Make sure to uppdate all related, except if only applies here */