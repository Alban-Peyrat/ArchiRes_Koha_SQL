SELECT biblionumber,
	b.abstract AS "PPN",
	ExtractValue(bm.metadata, 'count(//datafield[@tag="029"])') as "nb_029",
    ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="m"]') as "029$m",
    ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="b"]') as "029$b",
    ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="e"]') as "029$e"
    
    
FROM biblio b
JOIN biblio_metadata bm USING(biblionumber)
JOIN biblioitems bi USING(biblionumber)

WHERE (
    ExtractValue(bm.metadata, 'count(//datafield[@tag="029"])') = 0
    OR NOT ExtractValue(bm.metadata, '//datafield[@tag="029"]/subfield[@code="m"]') REGEXP "^\\d{4}_(APR|CCJP|CEAA|CESP|DPEA|DSA|MASTERE|MES|MHMONP|MEMU|PFE|RAPL|RAPS|THES|TPFE|TATE)_"
)
    AND bi.itemtype = "TE"
    AND biblionumber NOT IN ("531407", "545208", "545881")

/* Rapport ID (test) : 1427
Rapport ID (prod) : 1427

UTILISÉ DANS DES AUTOMATIONS AR268 : liste les bibnb de travaux d'étudiants sans 029 / sans 029$m correctement formatté  */