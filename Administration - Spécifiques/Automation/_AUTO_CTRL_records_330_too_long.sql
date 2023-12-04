SELECT biblionumber,
    ExtractValue(metadata, 'count(//datafield[@tag="330"])') as nb,
    LENGTHB(ExtractValue(metadata, '//datafield[@tag="330"]/subfield')) AS byte_length
FROM biblio_metadata
WHERE (
    ExtractValue(metadata, 'count(//datafield[@tag="330"])') = 1
    AND LENGTHB(ExtractValue(metadata, '//datafield[@tag="330"]/subfield')) > 9999
)
    
/* Rapport ID (test) : 
Rapport ID (prod) : 

UTILISÉ DANS DES AUTOMATIONS : liste les bibnb avec des 330 trop longues */