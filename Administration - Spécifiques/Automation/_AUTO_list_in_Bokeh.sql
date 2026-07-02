    SELECT
    v.shelfnumber,
    v.shelfname,
    '' AS 'cardnumber',
    CASE 
        WHEN b.branchcode = 'GRNO' THEN 'paniers_GRNO@panierkoha.net'
        WHEN b.branchcode = 'NNCY' THEN 'paniers_NNCY@panierkoha.net'
        WHEN b.branchcode IN ('MRSL', 'IUAR', 'PAYM', 'IMVT') THEN 'paniers_IMVT@panierkoha.net'
    END AS 'email',
    '1' AS 'admin',
    vc.biblionumber
    FROM virtualshelfcontents vc
    LEFT JOIN virtualshelves v ON (vc.shelfnumber=v.shelfnumber)
    LEFT JOIN borrowers b ON (v.owner=b.borrowernumber)
    WHERE v.shelfnumber IS NOT NULL AND (vc.biblionumber IS NOT NULL OR vc.biblionumber!='')
    AND v.public=1 
    AND b.branchcode in ('GRNO', 'NNCY', 'MRSL', 'IUAR', 'PAYM', 'IMVT')
    GROUP BY vc.shelfnumber, vc.biblionumber
    ORDER BY v.shelfnumber

    /* L'original fait GROUP BY vc.biblionumber sauf que si une notice est dans 2 paniers elle n'appraît que dans le premier */