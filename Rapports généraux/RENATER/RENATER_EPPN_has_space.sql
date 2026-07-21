SELECT b.borrowernumber,
    b.branchcode AS "Bibliothèque",
    b.firstname AS "Prénom",
    b.surname AS "Patronyme",
    c.description AS "Catégorie",
    b.userid AS "Identifiant Koha (userid)",
    ba.attribute AS "EPPN"

FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN categories c USING(categorycode)

WHERE ba.attribute IS NOT NULL
	AND 
    (
        ba.attribute != REGEXP_REPLACE(ba.attribute,"\\s","")
        OR ba.attribute REGEXP "\\s$"
    )

/* Main report for WHERE is RENATER_EPPN_control.sql
Main report for SELECT is RENATER_EPPN_trop_long.sql
Make sure to uppdate all related, except if only applies here

For some Fing reason :
* "a " equals REGEXP_REPLACE(ba.attribute,"\\s","")
* but "a " does not match "a$"
* but "a " does match "\\s$"
*/