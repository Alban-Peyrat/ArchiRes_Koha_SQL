SELECT "EPPN présent" as info, COUNT(*) as nb_comptes
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL

UNION ALL

SELECT "EPPN trop long" as info, COUNT(*) as nb_comptes
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL
	AND length(ba.attribute) > 50

UNION ALL

SELECT "Userid n'est pas EPPN" as info, COUNT(*) as nb_comptes
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
WHERE ba.attribute IS NOT NULL
	AND ba.attribute != b.userid
    
UNION ALL

SELECT "Userid n'est pas EPPN et EPPN n'est pas ignoré" as info, COUNT(*) as nb_comptes
FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"
LEFT JOIN borrower_attributes ba2 ON b.borrowernumber = ba2.borrowernumber AND ba2.code = "IGNEPPN"
WHERE ba.attribute IS NOT NULL
	AND ba.attribute != b.userid
	AND ba2.attribute = "1"