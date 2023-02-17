SELECT biblionumber AS "bibnb",
    i.itemnumber AS "itemnb",
    i.itemcallnumber AS "cote",
    ExtractValue(bm.metadata, '//datafield[@tag="463"]/subfield') AS "463",
    ExtractValue(bm.metadata, '//datafield[@tag="463"]/subfield[@code="t"]') AS "463t",
    UPPER(
        TRIM(BOTH " " FROM 
            REPLACE(
                ExtractValue(bm.metadata, '//datafield[@tag="463"]/subfield[@code="t"]'),
                "-",
                " "
                )
            )
        ) AS "463t_clean"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN items i USING(biblionumber)


WHERE (
    (bi.itemtype = "DOS")
    AND (i.itemcallnumber REGEXP 'Revue de presse Gironde')
    )

HAVING (463t_clean = "SUD OUEST")

/* Rapport ID (test) : 1350
Rapport ID (prod) : 1358

AR253 : liste les documents Dossier avec la cote "Revue de presse Gironde" */