SELECT biblionumber,
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    i.itemnumber,
    i.itemcallnumber,
    bi.itemtype,
    i.homebranch
    

FROM biblio b
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN items i USING(biblionumber)

WHERE itemcallnumber REGEXP '^([0-2]\\d\\/\\d{2}\\/(MES|\\d*$))|^MES ?(\\d*|([0-2]\\d\\/\\d{2}\\/\\d*$))$'

ORDER BY bi.itemtype asc

/* ID base de test : 1337
ID base de prod : 

Renvoie tous les exemplaires de MES basé sur leur cote

Regex : ^[0-2]\d\/\d{2}\/(MES|\d*$)|^MES ?(\d*|([0-2]\d\/\d{2}\/\d*))$
Regex Koha : ^([0-2]\\d\\/\\d{2}\\/(MES|\\d*$))|^MES ?(\\d*|([0-2]\\d\\/\\d{2}\\/\\d*$))$
↑ il faut doubler les backslashs

Cote originelle : 
code site numérique/année sur 2 chiffres/ (numéro d'entrée OU MES)
→ ^[0-2]\d\/\d{2}\/(MES|\d*$)
→ = commence par 0 à 2 puis 1 chiffre, suivi de / et de 2 chiffres suivi de (MES OU uniquement des chiffres jusqu'à la fin)

Commence par MES
→ ^MES ?(\d*|([0-2]\d\/\d{2}\/\d*$))$
→ = commence par MES, peut avoir un espace, puis est suivi (uniquement de chiffres jusq'à la fin
→ OU de 0 à 2 puis 1 chiffre, suivi de / et de 2 chiffres suivi de uniquement des chiffres jusqu'à la fin)
*/