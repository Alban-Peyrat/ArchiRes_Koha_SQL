SELECT 
   surname,
   firstname,
   categorycode,
   cardnumber,
   dateexpiry,
   REPLACE (left(password, 1),"$","oui") as "inscription portail"

FROM borrowers

WHERE branchcode=<<Choisir un site|branches>>

ORDER BY dateexpiry desc

/* Rapport ID (test) : 1316
Rapport ID (prod) : 1306

Original de LP (Grenoble)

Liste les inscrits sur le portail (sélection par site) */