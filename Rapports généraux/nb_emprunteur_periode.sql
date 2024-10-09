SELECT COUNT(DISTINCT hashed_borrowernumber) as "Nb d'emprunteurs"
FROM pseudonymized_transactions
WHERE transaction_type = "issue"
    and transaction_branchcode = <<Bibliothèque de prêt|branches>>
    and datetime BETWEEN <<Date de début|date>>  AND <<Date de retour|date>>

/* Rapport listant le nombre d'emprunteurs d'une catégorie donnée sur une période donnée pour une école donnée */
