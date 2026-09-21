SELECT biblionumber,
    ExtractValue(bm.metadata, 'count(//datafield[@tag="941"]/subfield[@code="d"])') as "nb_941$d",
    ExtractValue(bm.metadata, 'count(//datafield[@tag="941"]/subfield[@code="f"])') as "nb_941$f"
    
FROM biblio b
JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata, 'count(//datafield[@tag="941"]/subfield[@code="d"])') != ExtractValue(bm.metadata, 'count(//datafield[@tag="941"]/subfield[@code="f"])')

/* UTILISÉ DANS DES AUTOMATIONS : signale els notices dont le nombre 941$d ou 941$f ne correspondent pas à celui de l'autre */
