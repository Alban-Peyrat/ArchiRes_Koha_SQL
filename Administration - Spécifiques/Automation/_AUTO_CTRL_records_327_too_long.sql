SELECT biblionumber,
    ExtractValue(metadata, 'count(//datafield[@tag="327"])') as nb,
    LENGTHB(ExtractValue(metadata, '//datafield[@tag="327"]/subfield')) AS byte_length
FROM biblio_metadata
WHERE (
    ExtractValue(metadata, 'count(//datafield[@tag="327"])') = 1
    AND LENGTHB(ExtractValue(metadata, '//datafield[@tag="327"]/subfield')) > 9999
)

/* Rapport ID (test) : 
Rapport ID (prod) : 

UTILISÉ DANS DES AUTOMATIONS : liste les bibnb avec des 327 trop longues */