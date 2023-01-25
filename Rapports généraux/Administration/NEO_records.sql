SELECT b.biblionumber,
    GROUP_CONCAT(ao.ordernumber SEPARATOR '|') AS ordernumbers,
    b.title,
    b.author,
    bi.itemtype,
    COUNT(i.itemnumber) AS Nb_items,
    COUNT(di.itemnumber) AS Nb_deleted_items,
    COUNT(ai.itemnumber) AS Nb_acq_items/*,
    ExtractValue(bm.metadata, '//datafield[@tag="801"]/subfield[@code="b"]') AS "801b"*/

FROM biblio b
/*JOIN biblio_metadata bm ON b.biblionumber = bm.biblionumber*/
JOIN biblioitems bi ON b.biblionumber = bi.biblionumber
LEFT JOIN items i ON b.biblionumber = i.biblionumber
LEFT JOIN deleteditems di ON b.biblionumber = di.biblionumber 
LEFT JOIN aqorders ao ON b.biblionumber = ao.biblionumber
LEFT JOIN aqorders_items ai ON ao.ordernumber = ai.ordernumber 

GROUP BY b.biblionumber

HAVING (
    (COUNT(ao.ordernumber) > 0)
    AND (COUNT(i.itemnumber) = 0)
    AND (COUNT(di.itemnumber) = 0)
    AND (COUNT(ai.itemnumber) = 0)
)

/* Rapport ID (test) : 1347
Rapport ID (prod) : 1348

/!\ Ne pas joindre biblio_metadata sinon le rapport est trop long à exécuter.

Notices NEO (bibliographiques sans traces d'exemplaires mais avec une ligne de commande)
Voir NEO_records dans ArchiRes_Structure_Technique */