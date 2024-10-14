SELECT 
	(
    	SELECT COUNT(pt.id)
		FROM pseudonymized_transactions pt
		WHERE pt.itemnumber IN (
			SELECT i.itemnumber
			FROM items i
			LEFT JOIN biblioitems bi ON i.biblionumber = bi.biblionumber
			WHERE bi.itemtype =  <<Type de document|TYPEDOC>> 
				AND i.homebranch = <<Bibliothèque|branches>>
				AND i.dateaccessioned BETWEEN <<Date de début|date>> AND <<Date de fin|date>>
				AND bi.publicationyear BETWEEN YEAR(<<Date de début|date>>) - 3 AND YEAR(<<Date de fin|date>>)
			) AND pt.transaction_type = "issue"
    ) / (
    	SELECT COUNT(i.itemnumber)
		FROM items i
		LEFT JOIN biblioitems bi ON i.biblionumber = bi.biblionumber
		WHERE bi.itemtype =  <<Type de document|TYPEDOC>> 
			AND i.homebranch = <<Bibliothèque|branches>>
			AND i.dateaccessioned BETWEEN <<Date de début|date>> AND <<Date de fin|date>>
			AND bi.publicationyear BETWEEN YEAR(<<Date de début|date>>) - 3 AND YEAR(<<Date de fin|date>>)
	)
AS "Taux de rotation nouveautés (sans module acquisition)"

/* Taux de rotation des nouveutés pour un type de document (sans le module d'acquisition) */
