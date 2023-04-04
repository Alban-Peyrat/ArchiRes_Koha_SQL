SELECT authtypecode,
    COUNT(*) as "nb_auth"
    
FROM auth_header

WHERE ExtractValue(marcxml, '//controlfield[@tag="009"]') != ''

GROUP BY authtypecode

/* Rapport ID (test) : 1353
Rapport ID (prod) : 1361


POUR PYTHON AR163 : Compte le nombre d'autorités avec un PPN par type d'autorités */