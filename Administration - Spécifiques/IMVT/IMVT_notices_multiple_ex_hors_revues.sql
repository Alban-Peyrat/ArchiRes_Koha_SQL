SELECT i.biblionumber, count(i.itemnumber)
FROM items i JOIN biblioitems bi
ON i.biblioitemnumber=bi.biblioitemnumber
WHERE i.homebranch='MRSL'
AND NOT bi.itemtype = 'REV'
group by i.biblionumber
HAVING count(i.itemnumber)>1

/* Renvoie tous les numéros de notice de l'ENSA Marseille avec au moins
deux exemplaires mais excluant le type de document revues.

Dans le cadre de l'IMVT
Adapté de celui transmis par le SCD de l'AMU */