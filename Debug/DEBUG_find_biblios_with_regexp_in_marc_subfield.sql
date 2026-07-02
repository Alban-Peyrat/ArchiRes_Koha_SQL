SELECT biblionumber,
    ExtractValue(bm.metadata,
        CONCAT('//', 
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', 'controlfield', 'datafield'),
            '[@tag="',
            TRIM(<<Field Tag>>),
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', '', CONCAT('"]/subfield[@code="', TRIM("$" FROM TRIM(<<Subfield Code>>)))), 
            '"]'
        )
    ) AS subfield,
    ExtractValue(bm.metadata,
        CONCAT('count(//', 
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', 'controlfield', 'datafield'), 
            '[@tag="',
            TRIM(<<Field Tag>>),
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', '', CONCAT('"]/subfield[@code="', TRIM("$" FROM TRIM(<<Subfield Code>>)))), 
            '"])'
        )
    ) AS nb_subfields

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata,
        CONCAT('//', 
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', 'controlfield', 'datafield'), 
            '[@tag="',
            TRIM(<<Field Tag>>),
            IF(TRIM(<<Field Tag>>) BETWEEN '000' AND '009', '', CONCAT('"]/subfield[@code="', TRIM("$" FROM TRIM(<<Subfield Code>>)))), 
            '"]'
        )
    ) REGEXP <<Expression régulière>>

/* Ce rapport sert à lister les notices contenant le sous-champ voulu en MARC */