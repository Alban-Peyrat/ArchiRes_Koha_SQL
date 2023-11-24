SELECT "Items" as source,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch,
    timestamp
FROM items
WHERE biblionumber = <<Biblionumber>>

UNION ALL

SELECT "Deleted items" as source,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch,
    timestamp
    
FROM deleteditems
WHERE biblionumber = <<Biblionumber>>
UNION ALL

SELECT "Aqorders items" as source,
    itemnumber,
    "" AS barcode,
    "" AS stocknumber,
    "" AS itemcallnumber,
    "" AS homebranch,
    "" AS holdingbranch,
    aqorders_items.timestamp
    
FROM aqorders_items
LEFT JOIN aqorders USING(ordernumber)
WHERE aqorders.biblionumber = <<Biblionumber>>

/* Ce rapprot permet de retrouver les items d'une notice dans al table item ou deleted_items.
Pour les items dans aqorders, liste uniquement s'ils sont présent dans la table */