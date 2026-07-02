SELECT "Reserves" as source,
    r.reserve_id AS reserve_id,
    r.biblionumber AS biblionumber,
    r.deleted_biblionumber AS deleted_biblionumber,
    r.itemnumber AS itemnumber,
    r.borrowernumber AS borrowernumber,
    r.branchcode AS branchcode,
    r.reservedate AS reservedate,
    r.waitingdate AS waitingdate,
    r.expirationdate AS expirationdate,
    r.cancellationdate AS cancellationdate,
    r.cancellation_reason AS cancellation_reason,
    r.timestamp AS timestamp

FROM reserves r
WHERE r.biblionumber = TRIM(<<Biblionumber>>)

UNION ALL

SELECT "Old_Reserves" as source,
    olr.reserve_id AS reserve_id,
    olr.biblionumber AS biblionumber,
    olr.deleted_biblionumber AS deleted_biblionumber,
    olr.itemnumber AS itemnumber,
    olr.borrowernumber AS borrowernumber,
    olr.branchcode AS branchcode,
    olr.reservedate AS reservedate,
    olr.waitingdate AS waitingdate,
    olr.expirationdate AS expirationdate,
    olr.cancellationdate AS cancellationdate,
    olr.cancellation_reason AS cancellation_reason,
    olr.timestamp AS timestamp
    
FROM old_reserves olr
WHERE olr.biblionumber = TRIM(<<Biblionumber>>)

/* Ce rapprot permet de lister les réservations pour un biblionumber (reserves & old_reserves)
Attention, old_reserves est anonymisés à mois + 3 (ou dans ces eaux-là) */