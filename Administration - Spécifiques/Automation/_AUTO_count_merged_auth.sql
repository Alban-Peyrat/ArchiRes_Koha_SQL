SELECT authtypecode,
    COUNT(*) as "nb_auth"
    
FROM auth_header

WHERE ExtractValue(marcxml, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP 'Archires_FUS_AUT.*'

GROUP BY authtypecode

/* Rapport ID (test) : 1331
Rapport ID (prod) : 1331


UTILISÉ DANS DES AUTOMATIONS AR163 : Compte le nombre d'autorités fusionnées par type d'autorités */