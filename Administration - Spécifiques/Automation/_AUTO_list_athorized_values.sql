SELECT category, authorised_value, lib, lib_opac
FROM authorised_values
/* WHERE category IN <<Authorized values IDs|list>> */

UNION ALL 
SELECT "branches" AS category, branchcode AS "authorised_value", branchname as "lib", branchname as "lib_opac"
FROM branches

UNION ALL 
SELECT "itemtypes" AS category, itemtype AS "authorised_value", description as "lib", description as "lib_opac"
FROM itemtypes

/* Rapport ID (test) : 
Rapport ID (prod) : 

UTILISÉ DANS DES AUTOMATIONS : AR491 : liste les valeurs autorisées pour une liste de valeur autorisées */