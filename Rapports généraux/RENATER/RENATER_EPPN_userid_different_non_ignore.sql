SELECT b.borrowernumber,
    b.branchcode AS "Bibliothèque",
    b.firstname AS "Prénom",
    b.surname AS "Patronyme",
    c.description AS "Catégorie",
    b.userid AS "Identifiant Koha (userid)",
    ba.attribute AS "EPPN",
    ba2.attribute AS "Ignorer EPPN ?"

FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN borrower_attributes ba2 ON b.borrowernumber = ba2.borrowernumber AND ba2.code = "IGNEPPN"
LEFT JOIN categories c USING(categorycode)

WHERE ba.attribute IS NOT NULL
	AND ba.attribute != b.userid
	AND (ba2.attribute != "1" OR ba2.attribute IS NULL)

/* Main report for WHERE is RENATER_EPPN_control.sql
Main report for SELECT is RENATER_EPPN_trop_long.sql
Make sure to uppdate all related, except if only applies here */