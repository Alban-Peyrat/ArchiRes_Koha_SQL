SELECT "Items" as source,
    biblionumber,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch
FROM items
WHERE itemnumber = <<Itemnumber>>

UNION ALL

SELECT "Deleted items" as source,
    biblionumber,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch
    
FROM deleteditems
WHERE itemnumber = <<Itemnumber>>
UNION ALL

SELECT "Aqorders items" as source,
    "" AS biblionumber,
    itemnumber,
    "" AS barcode,
    "" AS stocknumber,
    "" AS itemcallnumber,
    "" AS homebranch,
    "" AS holdingbranch
    
FROM aqorders_items
WHERE itemnumber = <<Itemnumber>>

/* Ce rapprot permet de retrouver un item dans al table item ou deleted_items.
Pour les items dans aqorders, liste uniquement s'ils sont présent dans la table */