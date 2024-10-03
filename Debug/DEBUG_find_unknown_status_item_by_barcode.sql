SELECT "Items" as source,
    biblionumber,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch
FROM items
WHERE barcode = TRIM(<<Barcode>>)

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
WHERE barcode = TRIM(<<Barcode>>)

/* Ce rapprot permet de retrouver un item dans al table item ou deleted_items. */