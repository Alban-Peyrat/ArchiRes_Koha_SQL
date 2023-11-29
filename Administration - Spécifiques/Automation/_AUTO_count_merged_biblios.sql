SELECT bi.itemtype,
    COUNT(*) as "nb_biblios"
    
FROM biblioitems bi
JOIN biblio_metadata USING(biblionumber)

WHERE ExtractValue(metadata, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP 'Archires_FUS_BIB.*'

GROUP BY bi.itemtype

/* Rapport ID (test) : 1359
Rapport ID (prod) : 1359


UTILISÉ DANS DES AUTOMATIONS AR257 : Compte le nombre de notices bibliographiques fusionnées par type de documents */