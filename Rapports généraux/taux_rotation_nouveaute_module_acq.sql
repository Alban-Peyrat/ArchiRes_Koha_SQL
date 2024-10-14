SELECT 
	(
    	SELECT COUNT(pt.id)
		FROM pseudonymized_transactions pt
		WHERE pt.itemnumber IN (
			SELECT ai.itemnumber
			FROM aqorders_items ai
			LEFT JOIN aqorders a ON ai.ordernumber = a.ordernumber
			LEFT JOIN items i ON ai.itemnumber = i.itemnumber
			LEFT JOIN biblioitems bi ON i.biblionumber = bi.biblionumber
			WHERE bi.itemtype =  <<Type de document|TYPEDOC>> 
				AND i.homebranch = <<Bibliothèque|branches>>
				AND a.datereceived BETWEEN <<Date de début|date>> AND <<Date de fin|date>>
			) AND pt.transaction_type = "issue"
    ) / (
    	SELECT COUNT(ai.itemnumber)
		FROM aqorders_items ai
		LEFT JOIN aqorders a ON ai.ordernumber = a.ordernumber
		LEFT JOIN items i ON ai.itemnumber = i.itemnumber
		LEFT JOIN biblioitems bi ON i.biblionumber = bi.biblionumber
		WHERE bi.itemtype =  <<Type de document|TYPEDOC>> 
			AND i.homebranch = <<Bibliothèque|branches>>
			AND a.datereceived BETWEEN <<Date de début|date>> AND <<Date de fin|date>>
	)
AS "Taux de rotation nouveautés (module acquisition)"

/* Taux de rotation des nouveutés pour un type de document (avec le module d'acquisition) */
