SELECT authtypecode,
    COUNT(*) as "nb_auth"
    
FROM auth_header

WHERE ExtractValue(marcxml, '//controlfield[@tag="009"]') = ''
    AND ExtractValue(marcxml, '//datafield[@tag="033"]/subfield[@code="a"]') != ''

GROUP BY authtypecode

/* Rapport ID (test) : 1362
Rapport ID (prod) : 1362


UTILISÉ DANS DES AUTOMATIONS AR163 : Compte le nombre d'autorités avec une 033 mais sans PPN par type d'autorités */