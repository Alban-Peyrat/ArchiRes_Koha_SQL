SELECT authtypecode, ExtractValue(marcxml, '//controlfield[@tag="009"]') != '' as PPN, COUNT(*) as "nb_auth"
FROM auth_header
WHERE authtypecode IN ("NP", "CO")
GROUP BY authtypecode, PPN