SELECT b.biblionumber AS "bibnb",
    REGEXP_REPLACE(b.title, '[\\x00-\\x1F]', "__/!\\INVALID_CHAR/!\\__") AS "title",
    REGEXP_REPLACE(b.author, '[\\x00-\\x1F]', "__/!\\INVALID_CHAR/!\\__") AS "author",
    REGEXP_REPLACE(i.itemcallnumber, '[\\x00-\\x1F]', "__/!\\INVALID_CHAR/!\\__") AS "itemcallnb"
    
FROM biblio b
JOIN items i USING(biblionumber)

WHERE (
    (author REGEXP '[\\x00-\\x1F]')
    OR (title REGEXP '[\\x00-\\x1F]')
    OR (itemcallnumber REGEXP '[\\x00-\\x1F]')
)

/* Rapport ID (test) : 1338
Rapport ID (prod) : 1338

UTILISÉ DANS DES AUTOMATIONS Identifie les notices avec des caractères ASCII avant 32 (control characters) dans les titres, auteurs ou cotes (j'ai pas de cas dans les cotes, donc je ne sais pas si ça fonctionne)
http://MYOPAC/cgi-bin/koha/svc/report?id=REPORTID
https://fr.wikibooks.org/wiki/MySQL/Regex
https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-instr
*/