SELECT oi.ordernumber,
    oi.itemnumber,
    i.barcode,
    i.biblionumber,
    i.dateaccessioned,
    i.homebranch

FROM aqorders_items oi
JOIN items i ON i.itemnumber = oi.itemnumber

ORDER BY ordernumber desc

/*  Rapport ID (test) : 1349
Rapport ID (prod) : 

Rapport à modifier pour identifier le problème des bons de commandes disparus */