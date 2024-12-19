SELECT biblionumber,
    ExtractValue(metadata, '//datafield[@tag="610" or @tag="600" or @tag="601" or @tag="609"]/subfield[@code="9"]') as "6XX"
    
FROM biblio_metadata

/* Rapport ID (test) : 1482
Rapport ID (prod) : 1541

Si trop lourd, rajouter un W.HERE pour filtrer a lsite de biblionumber possibles

Exporte toutes les 6XX (sauf 603-4-5) de totues les notices*/