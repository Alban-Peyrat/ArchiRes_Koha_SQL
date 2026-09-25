SELECT b.borrowernumber,
    br.branchname,
    b.categorycode,
    b.userid,
    ba.attribute AS "EPPN"

FROM borrowers b
LEFT JOIN borrower_attributes ba ON b.borrowernumber = ba.borrowernumber AND ba.code = "EPPN"

LEFT JOIN branches br ON b.branchcode = br.branchcode

WHERE length(b.userid) > 50
/* UTILISÉ DANS DES AUTOMATIONS : liste els suerids qui font plus de 50 caractères et sont crops sur Bokeh */