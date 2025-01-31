SELECT biblionumber
FROM biblio_metadata bm
WHERE TRIM(ExtractValue(bm.metadata, '//datafield[@tag="200"]/subfield[@code="a"]')) = ""

/* Rapport ID (prod) : 1599

UTILISÉ DANS DES AUTOMATIONS AR264 : liste les documents n'ayant pas de 200$a */