SELECT av.authorised_value AS "code",
    av.lib AS "name",
    IF(avb.branchcode IS NULL, "All libraries", "Limited") AS "restriction"


FROM authorised_values av
LEFT JOIN authorised_values_branches avb ON av.id = avb.av_id

WHERE av.category = <<Code valeur autorisée (LOC = localisation, coll = Collections)>>
    AND (
        avb.branchcode = <<Bibliothèque|branches>>
        OR avb.branchcode IS NULL
    )

GROUP BY av.id
ORDER BY av.authorised_value ASC

/* Rapport ID (prod) : 1600

Liste les valeurs autorisées d'une valeur autorisé spécifiques à une bibliothèque / celles sans restriction */