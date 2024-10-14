SELECT 
	(
    	SELECT COUNT(pt.id)
		FROM pseudonymized_transactions pt
		LEFT JOIN items i USING(itemnumber)
		LEFT JOIN biblioitems bi ON i.biblionumber = bi.biblionumber
		WHERE pt.transaction_type = "issue"
			AND bi.itemtype =  <<Type de document|TYPEDOC>> 
			AND pt.transaction_branchcode =  <<Bibliothèque|branches>> 
    		AND pt.datetime BETWEEN <<Date de début|date>> AND <<Date de fin|date>> 
    ) / (
    	SELECT COUNT(i.itemnumber)
		FROM items i
		LEFT JOIN biblioitems bi USING(biblionumber)
		WHERE bi.itemtype =  <<Type de document|TYPEDOC>> 
			AND i.homebranch = <<Bibliothèque|branches>>
			AND i.dateaccessioned <= <<Date de fin|date>>
	)
AS "Taux de rotation"

/* Taux de rotation pour un type de document */