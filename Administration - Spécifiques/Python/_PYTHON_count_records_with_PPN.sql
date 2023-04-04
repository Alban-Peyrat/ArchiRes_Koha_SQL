SELECT COUNT(*) AS "nb_biblios"

FROM biblio

WHERE abstract != ''

/* Rapport ID (test) : 1352
Rapport ID (prod) : 1360


POUR PYTHON AR257 : Compte le nombre de notices bibliographiques avec un abstract (PPN supposément) */