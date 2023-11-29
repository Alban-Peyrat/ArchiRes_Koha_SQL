SELECT biblionumber

FROM biblio b
JOIN biblio_metadata bm USING(biblionumber)
JOIN biblioitems bi USING(biblionumber)

WHERE (
    ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="b"]') REGEXP "^\\d{4}_(CCJP|CEAA|CESP|DPEA|DSA|MASTERE|MES|MHMONP|MEMU|PFE|RAPL|THES|TPFE|TATE)_"
    AND ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="m"]') = ""
    AND bi.itemtype = "TE"
)

/* Rapport ID (test) : 
Rapport ID (prod) : 1542

Identifie les travaux étudiants avec une 029$b de type numéro ArchiRès à la place de 029 */