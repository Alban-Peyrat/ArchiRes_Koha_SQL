SELECT COUNT(biblionumber)
FROM deletedbiblio
WHERE timestamp BETWEEN timestamp(<<Premier jour|date>>) AND timestamp(<<Dernier jour|date>>)
/* Rapport ID (prod) : 1591

Stats, permet de connaître le nombre total de notice supprimées */