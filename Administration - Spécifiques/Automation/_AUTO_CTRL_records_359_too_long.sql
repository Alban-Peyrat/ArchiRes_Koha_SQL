SELECT biblionumber,
    ExtractValue(metadata, 'count(//datafield[@tag="359"])') as nb,
    LENGTHB(ExtractValue(metadata, '//datafield[@tag="359"]/subfield')) AS byte_length
FROM biblio_metadata
WHERE (
    ExtractValue(metadata, 'count(//datafield[@tag="359"])') = 1
    AND LENGTHB(ExtractValue(metadata, '//datafield[@tag="359"]/subfield')) > 9999
)
    
/* Rapport ID (test) : 
Rapport ID (prod) : 

UTILISÉ DANS DES AUTOMATIONS : liste les bibnb avec des 359 trop longues */