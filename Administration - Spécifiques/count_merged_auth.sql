SELECT authtypecode,
    COUNT(*)
    
FROM auth_header

WHERE ExtractValue(marcxml, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP '^Archires_FUS_AUT.*'

GROUP BY authtypecode

/* Rapport ID (test) : 1349
Rapport ID (prod) : 1331


AR163 : Compte le nombre d'autorités fusionnées par type d'autorités */