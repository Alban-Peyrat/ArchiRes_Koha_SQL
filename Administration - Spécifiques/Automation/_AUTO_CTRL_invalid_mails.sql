SELECT cardnumber,
    email
FROM borrowers
WHERE 
    email NOT RLIKE '^[-\\._a-zA-Z0-9]*@[-\\._a-zA-Z0-9]*$'
    AND trim(email) != ''

/* Rapport ID (test) : 1471
Rapport ID (prod) : 1479

UTILISÉ DANS DES AUTOMATIONS : liste les emails avec des caractères invalides (copié du #MT42780) */