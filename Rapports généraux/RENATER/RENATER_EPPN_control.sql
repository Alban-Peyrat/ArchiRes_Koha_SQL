SELECT "EPPN présent" as info,
	COUNT(*) as nb_comptes,
	"" as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL

UNION ALL

SELECT "EPPN contient des espaces" as info,
	COUNT(*) as nb_comptes,
	'<a href="/cgi-bin/koha/reports/guided_reports.pl?id=1860&op=run">Consulter la liste des comptes concernés dans le rapport 1860</a>' as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL
	AND 
    (
        ba.attribute != REGEXP_REPLACE(ba.attribute,"\\s","")
        OR ba.attribute REGEXP "\\s$"
    )
/* For account list : RENATER_EPPN_has_space.sql

For some Fing reason :
* "a " equals REGEXP_REPLACE(ba.attribute,"\\s","")
* but "a " does not match "a$"
* but "a " does match "\\s$" */

UNION ALL

SELECT "EPPN trop long" as info,
	COUNT(*) as nb_comptes,
	'<a href="/cgi-bin/koha/reports/guided_reports.pl?id=1855&op=run">Consulter la liste des comptes concernés dans le rapport 1855</a>' as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL
	AND length(ba.attribute) > 50
/* For account list : RENATER_EPPN_trop_long.sql */

UNION ALL

SELECT "Userid différent de EPPN" as info,
	COUNT(*) as nb_comptes,
	"" as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL
	AND ba.attribute != b.userid
    
UNION ALL

SELECT "Userid différent de EPPN et EPPN n'est pas ignoré" as info,
	COUNT(*) as nb_comptes,
	'<a href="/cgi-bin/koha/reports/guided_reports.pl?id=1854&op=run">Consulter la liste des comptes concernés dans le rapport 1854</a>' as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN borrower_attributes ba2 ON b.borrowernumber = ba2.borrowernumber AND ba2.code = "IGNEPPN"
WHERE ba.attribute IS NOT NULL
	AND ba.attribute != b.userid
	AND (ba2.attribute != "1" OR ba2.attribute IS NULL)
/* For account list : RENATER_EPPN_userid_different_non_ignore.sql */
    
UNION ALL

SELECT "Userid différent de EPPN, EPPN n'est pas ignoré & EPPN pas trop long" as info,
	COUNT(*) as nb_comptes,
	'<a href="/cgi-bin/koha/reports/guided_reports.pl?id=1857&op=run">Consulter la liste des comptes concernés dans le rapport 1857</a>' as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN borrower_attributes ba2 ON b.borrowernumber = ba2.borrowernumber AND ba2.code = "IGNEPPN"
WHERE ba.attribute IS NOT NULL
	AND ba.attribute != b.userid
	AND length(ba.attribute) < 51
	AND (ba2.attribute != "1" OR ba2.attribute IS NULL)
/* For account list : RENATER_EPPN_userid_different_non_ignore_pas_long.sql */

UNION ALL

SELECT "Userid contient @ mais pas d'EPPN" as info,
	COUNT(*) as nb_comptes,
	'<a href="/cgi-bin/koha/reports/guided_reports.pl?id=1856&op=run">Consulter la liste des comptes concernés dans le rapport 1856</a>' as liste
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NULL
	AND INSTR(b.userid, "@") > 0
/* For account list : RENATER_no_EPPN_but_AT_in_userid.sql */