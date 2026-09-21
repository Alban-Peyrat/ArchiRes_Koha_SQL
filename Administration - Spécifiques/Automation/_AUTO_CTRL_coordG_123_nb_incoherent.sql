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
        (data.q != "") + (data.r != "") + (data.s != "") + (data.t != "") IN (1,3)
    ) OR (
        (data.q != "") + (data.r != "") + (data.s != "") + (data.t != "") = 2
        AND (
            ((data.q != "") + (data.s != "") != 2)
            OR ((data.r != "") + (data.t != "") != 2)
        )
    )

/* UTILISÉ DANS DES AUTOMATIONS : signale autorités qui ont des incohérences sur el nombre de 123$qrst */
