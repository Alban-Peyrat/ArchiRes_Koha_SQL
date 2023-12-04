SELECT biblionumber
    
FROM biblio b
JOIN biblio_metadata bm USING(biblionumber)
JOIN biblioitems bi USING(biblionumber)

WHERE (
    ExtractValue(bm.metadata, 'count(//datafield[@tag="328"])') = 0
    OR ExtractValue(bm.metadata, 'count(//datafield[@tag="328"]/subfield[@code="a"])') >= 1
    OR NOT ExtractValue(bm.metadata, '//datafield[@tag="328"]/subfield[@code="b"]') REGEXP "^Mastère$|^Mémoire ENSA$|^Mémoire universitaire$|^MES$|^Mémoire HMONP$|^PFE$|^Thèse$|^TPFE$" /* A compléter */
)
    AND bi.itemtype = "TE"

/* Rapport ID (test) : 1428
Rapport ID (prod) : 1428

UTILISÉ DANS DES AUTOMATIONS AR268 : liste les bibnb de travaux d'étudiants sans 328 / avec 328 incorrectement formatté */