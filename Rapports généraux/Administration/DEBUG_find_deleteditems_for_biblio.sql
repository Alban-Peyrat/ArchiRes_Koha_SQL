SELECT biblionumber as biblionumber,
    itemnumber,
    barcode,
    stocknumber,
    itemcallnumber,
    homebranch,
    holdingbranch,
    dateaccessioned,
    timestamp,
    enumchron
    
FROM deleteditems
WHERE biblionumber = <<Biblionumber>>

/* Ce rapprot permet de retrouver tous les item de la table deleted_items pour un biblionumber */