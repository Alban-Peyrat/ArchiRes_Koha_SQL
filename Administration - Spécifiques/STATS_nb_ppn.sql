SELECT b.abstract IS NOT NULL as PPN, count(biblionumber)
FROM biblio b
LEFT JOIN biblioitems bi USING(biblionumber)
WHERE bi.itemtype IN ("LIV", "DOCA", "CART", "REV")
GROUP BY PPN