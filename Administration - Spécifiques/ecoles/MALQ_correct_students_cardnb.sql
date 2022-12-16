SELECT borrowernumber,
	cardnumber,
	firstname,
    surname,
    categorycode,
    branchcode,
    dateexpiry
    
FROM borrowers

WHERE (
    branchcode = "MALQ"
    AND dateexpiry = "2023-10-31"
    AND cardnumber REGEXP "^MALQMALQ"
)

/* Rapport ID (test) : ????
Rapport ID (prod) : 1324

#AR92 + #MT39105 */