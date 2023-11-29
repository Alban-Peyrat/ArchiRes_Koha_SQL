SELECT COUNT(biblionumber) AS "Nombre de notices",
    REGEXP_SUBSTR(ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="m"]'), "(?<=^\\d{4}_)[A-Z]+(?=_[A-Z]{4})") AS w_etud_type
FROM biblio b
JOIN biblio_metadata bm USING(biblionumber)
JOIN biblioitems bi USING(biblionumber)

WHERE (
    ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="m"]') REGEXP CONCAT("^\\d{4}_(CCJP|CEAA|CESP|DPEA|DSA|MASTERE|MES|MHMONP|MEMU|PFE|RAPL|THES|TPFE|TATE)_", <<Bibliothèque |branches>>)
    AND bi.itemtype = "TE"
)

GROUP BY w_etud_type

ORDER BY w_etud_type asc

/* Rapport ID (test) : 1402
Rapport ID (prod) : 1443

Compte le nombre de documents par types de travaux d'étudiants pour une école */