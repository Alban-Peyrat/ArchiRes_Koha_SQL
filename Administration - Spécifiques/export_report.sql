SELECT id,
    report_name,
    notes,
    last_run,
    borrowernumber,
    replace(replace(savedsql,'\r',' '),'\n',' ') AS query

FROM saved_sql

WHERE id = <<ID>>

/* Rapport ID (test) : 
Rapport ID (prod) : 1347


Exporte un rapport */