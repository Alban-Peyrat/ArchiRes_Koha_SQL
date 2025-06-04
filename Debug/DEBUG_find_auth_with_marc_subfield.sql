SELECT authid,
    ExtractValue(marcxml,
        CONCAT('//', 
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', 'controlfield', 'datafield'),
            '[@tag="',
            TRIM(<<Field Tag>>),
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', '', CONCAT('"]/subfield[@code="', TRIM("$" FROM TRIM(<<Subfield Code>>)))), 
            '"]'
        )
    ) AS subfield,
    ExtractValue(marcxml,
        CONCAT('count(//', 
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', 'controlfield', 'datafield'), 
            '[@tag="',
            TRIM(<<Field Tag>>),
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', '', CONCAT('"]/subfield[@code="', TRIM("$" FROM TRIM(<<Subfield Code>>)))), 
            '"])'
        )
    ) AS nb_subfields

FROM auth_header

WHERE ExtractValue(marcxml,
        CONCAT('//', 
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', 'controlfield', 'datafield'), 
            '[@tag="',
            TRIM(<<Field Tag>>),
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', '', CONCAT('"]/subfield[@code="', TRIM("$" FROM TRIM(<<Subfield Code>>)))), 
            '"]'
        )
    ) != ""

/* Ce rapport sert à lister les notices d'autorités contenant le sous-champ voulu en MARC */