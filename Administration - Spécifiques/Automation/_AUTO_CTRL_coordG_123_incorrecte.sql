SELECT data.authid,
    data.q as "123$q",
    data.r as "123$r",
    data.s as "123$s",
    data.t as "123$t"
    
FROM (
    SELECT authid,
        ExtractValue(marcxml, '//datafield[@tag="123"]/subfield[@code="q"]') AS "q",
        ExtractValue(marcxml, '//datafield[@tag="123"]/subfield[@code="r"]') AS "r",
        ExtractValue(marcxml, '//datafield[@tag="123"]/subfield[@code="s"]') AS "s",
        ExtractValue(marcxml, '//datafield[@tag="123"]/subfield[@code="t"]') AS "t"
    FROM auth_header
    WHERE authtypecode = "SNG"
) data

WHERE (
        data.q != ""
        AND NOT data.q REGEXP "^\\s*-?\\d+([\\.|,]\\d+)?\\s*$"
    ) OR (
        data.r != ""
        AND NOT data.r REGEXP "^\\s*-?\\d+([\\.|,]\\d+)?\\s*$"
    ) OR (
        data.s != ""
        AND NOT data.s REGEXP "^\\s*-?\\d+([\\.|,]\\d+)?\\s*$"
    ) OR (
        data.t != ""
        AND NOT data.t REGEXP "^\\s*-?\\d+([\\.|,]\\d+)?\\s*$"
    )

/* UTILISÉ DANS DES AUTOMATIONS : signale les autorités dont la 123$q,r,s ou f ne correspondent pas au format attendu par le plugin d'import */
