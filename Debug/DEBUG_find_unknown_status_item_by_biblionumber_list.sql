SELECT biblionumber,
	"Items" as source,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch,
    timestamp
FROM items
WHERE biblionumber IN  <<Liste de biblionumber|list>>

UNION ALL

SELECT biblionumber,
	"Deleted items" as source,
	itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch,
    timestamp
    
FROM deleteditems
WHERE biblionumber IN  <<Liste de biblionumber|list>>
UNION ALL

SELECT biblionumber,
	"Aqorders items" as source,
    itemnumber,
    "" AS barcode,
    "" AS stocknumber,
    "" AS itemcallnumber,
    "" AS homebranch,
    "" AS holdingbranch,
    aqorders_items.timestamp
    
FROM aqorders_items
LEFT JOIN aqorders USING(ordernumber)
WHERE biblionumber IN  <<Liste de biblionumber|list>>

ORDER BY biblionumber ASC, source DESC, itemnumber ASC

/* Ce rapprot permet de retrouver les items d'une notice dans al table item ou deleted_items.
Pour les items dans aqorders, liste uniquement s'ils sont présent dans la table */