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
        data.q REGEXP "^-?\\d+(\\.\\d+)?$"
        AND (data.q > 180
            OR data.q < -180
        )
    ) OR (
        data.r REGEXP "^-?\\d+(\\.\\d+)?$"
        AND (data.r > 180
            OR data.r < -180
        )
    ) OR (
        data.s REGEXP "^-?\\d+(\\.\\d+)?$"
        AND (data.s > 90
            OR data.s < -90
        )
    ) OR (
        data.t REGEXP "^-?\\d+(\\.\\d+)?$"
        AND (data.t > 90
            OR data.t < -90
        )
    )

/* UTILISÉ DANS DES AUTOMATIONS : signale les autorités dont la 123$q,r,s ou f ne correspondent pas strictement au format attendu par Bokeh */
