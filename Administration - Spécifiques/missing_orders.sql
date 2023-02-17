SELECT o.ordernumber,
    o.biblionumber,
    o.entrydate,
    o.quantity,
    o.listprice,
    o.datereceived,
    o.created_by,
    o.datecancellationprinted,
    o.cancellationreason,
    o.basketno,
    b.basketname,
    b.booksellerid,
    v.name,
    b.deliveryplace,
    o.budget_id,
    bud.budget_name

FROM aqorders o
JOIN aqbasket b ON b.basketno = o.basketno
JOIN aqbooksellers v on v.id = b.booksellerid
JOIN aqbudgets bud on bud.budget_id = o.budget_id


ORDER BY ordernumber desc

/*  Rapport ID (test) : 1348
Rapport ID (prod) : 

Rapport à modifier pour identifier le problème des bons de commandes disparus */