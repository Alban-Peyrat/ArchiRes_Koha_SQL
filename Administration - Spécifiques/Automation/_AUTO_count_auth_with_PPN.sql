SELECT authtypecode,
    COUNT(*) as "nb_auth"
    
FROM auth_header

WHERE ExtractValue(marcxml, '//controlfield[@tag="009"]') != ''

GROUP BY authtypecode

/* Rapport ID (test) : 1361
Rapport ID (prod) : 1361


UTILISÉ DANS DES AUTOMATIONS AR163 : Compte le nombre d'autorités avec un PPN par type d'autorités */