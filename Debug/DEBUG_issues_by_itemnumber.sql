SELECT "Issues" as source,
    itemnumber,
    issue_id,
    issuer_id,
    branchcode,
    issuedate,
    date_due,
    returndate,
    lastreneweddate,
    timestamp
FROM issues
WHERE itemnumber = TRIM(<<Itemnumber>>)

UNION ALL

SELECT "Old_Issues" as source,
    oi.itemnumber AS itemnumber,
    oi.issue_id AS issue_id,
    oi.issuer_id AS issuer_id,
    oi.branchcode AS branchcode,
    oi.issuedate AS issuedate,
    oi.date_due AS date_due,
    oi.returndate AS returndate,
    oi.lastreneweddate AS lastreneweddate,
    oi.timestamp AS timestamp
    
FROM old_issues oi
WHERE itemnumber = TRIM(<<Itemnumber>>)
UNION ALL

SELECT "Pseudo" as source,
    pt.itemnumber AS itemnumber,
    pt.id AS issue_id,
    "" AS issuer_id,
    pt.transaction_branchcode AS branchcode,
    pt.datetime AS issuedate,
    "" AS date_due,
    "" AS returndate,
    "" AS lastreneweddate,
    "" AS timestamp
    
FROM pseudonymized_transactions pt
WHERE itemnumber = TRIM(<<Itemnumber>>) AND pt.transaction_type = "issue"

/* Ce rapprot permet de lister les prêts pour un item dans issues, old_issues et pseudo_transactions.
Prend comme argument un itemnumber */