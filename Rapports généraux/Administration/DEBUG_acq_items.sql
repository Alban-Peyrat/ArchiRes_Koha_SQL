SELECT ai.itemnumber,
    a.biblionumber,
    ab.budget_name,
    a.budget_id,
    a.ordernumber,
    a.invoiceid,
    ain.invoicenumber,
    a.basketno,
    aba.basketname

FROM aqorders_items ai
LEFT JOIN aqorders a USING(ordernumber)
LEFT JOIN aqbudgets ab ON (a.budget_id = ab.budget_id)
LEFT JOIN aqbasket aba ON (a.basketno = aba.basketno)
LEFT JOIN aqinvoices ain ON (a.invoiceid = ain.invoiceid)

WHERE a.biblionumber = <<Biblionumber>>

/* Ce rapport sert à récupérer les données des exemplaires d'acquisitions d'une notice bibliographique */