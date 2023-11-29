SELECT dbi.itemtype,
    COUNT(*) as "nb_biblios"
    
FROM deletedbiblioitems dbi
JOIN deletedbiblio_metadata dbm USING(biblionumber)

WHERE ExtractValue(dbm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP 'Archires_FUS_BIB.*'

GROUP BY dbi.itemtype

/* Rapport ID (test) : 1392
Rapport ID (prod) : 1437

UTILISÉ DANS DES AUTOMATIONS AR257-260 : Compte le nombre de notices bibliographiques fusionnées par type de documents en se basant sur la table deted_biblio */