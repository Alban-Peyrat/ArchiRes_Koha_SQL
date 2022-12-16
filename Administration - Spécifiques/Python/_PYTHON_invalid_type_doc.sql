SELECT biblionumber AS 'bibnb',
    bi.itemtype AS 'type_doc',
    b.abstract AS 'ppn',
    GROUP_CONCAT(DISTINCT i.homebranch SEPARATOR '|') AS "branch",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "lien_koha"

FROM biblio b
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN items i USING(biblionumber)

WHERE (
        (bi.itemtype NOT IN (
        SELECT authorised_value
        
        FROM authorised_values
        
        WHERE category = "TYPEDOC"))
    
        OR bi.itemtype IS NULL
    )

GROUP BY biblionumber

/* Rapport ID (test) : 1344
Rapport ID (prod) : 1328

POUR PYTHON #AR180
Liste les document sans type de doc / avec type de doc invalide */