SELECT av.authorised_value AS "code",
    av.lib AS "nom"

FROM authorised_values av
LEFT JOIN authorised_values_branches avb ON av.id = avb.av_id

WHERE av.category = <<Code valeur autorisée (LOC = localisation, coll = Collections)>>
    AND avb.branchcode = <<Bibliothèque|branches>>

GROUP BY av.id

/* Rapport ID (prod) : 1600

Liste les valeurs autorisées d'une valeur autorisé spécifiques à une bibliothèque  */