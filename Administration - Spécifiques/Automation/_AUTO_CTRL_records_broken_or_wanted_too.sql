SELECT biblionumber
FROM biblio_metadata
WHERE metadata REGEXP "[^\\x{0009}\\x{000a}\\x{000d}\\x{0020}-\\x{D7FF}\\x{E000}-\\x{FFFD}]"

/* UTILISÉ DANS DES AUTOMATIONS : liste les documents qui finissent en "Erreurs d'encodage" et cassent plein de trucs.
Bon certains non mais de toute façon elles ont probablement un problème

This bingus : https://stackoverflow.com/questions/14463573/php-simplexml-load-file-invalid-character-error
Real regexp is [^\x{0009}\x{000a}\x{000d}\x{0020}-\x{D7FF}\x{E000}-\x{FFFD}] with flag unicode & global */