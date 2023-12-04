SELECT biblionumber,
    ExtractValue(bm.metadata, '//controlfield[@tag="009"]') as "009",
    b.abstract AS "abstract",
    ExtractValue(bm.metadata, '//controlfield[@tag="003"]') as "003"
    
FROM biblio b
JOIN biblio_metadata bm USING(biblionumber)

WHERE
    (
        (
            b.abstract IS NULL 
            OR b.abstract = ""
        )
        AND (
            ExtractValue(bm.metadata, '//controlfield[@tag="009"]') != ""
            OR (
                ExtractValue(bm.metadata, '//controlfield[@tag="003"]') != ""
                AND ExtractValue(bm.metadata, '//controlfield[@tag="003"]') LIKE '%www.sudoc.fr%'
            )
        )
    )


/* Rapport ID (test) : 1376
Rapport ID (prod) : 1376


UTILISÉ DANS DES AUTOMATIONS AR264 : Montre les documents ayant un PPN mais pas dans biblio.abstract */