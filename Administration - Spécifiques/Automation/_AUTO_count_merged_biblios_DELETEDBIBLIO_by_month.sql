SELECT DATE_FORMAT(timestamp, '%Y-%m') AS month,
    COUNT(*) as "nb_biblios"
    
FROM deletedbiblio_metadata dbm

WHERE ExtractValue(dbm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP 'Archires_FUS_BIB.*'

GROUP BY month
ORDER BY month

/* Rapport ID (test) : 1438
Rapport ID (prod) : 1438

UTILISÉ DANS DES AUTOMATIONS AR257-260 : Compte le nombre de notices bibliographiques fusionnées par type de documents en se basant sur la table deted_biblio par mois en se basant sur la time stamp */