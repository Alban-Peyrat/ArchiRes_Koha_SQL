SELECT data.biblionumber,
    data.d AS "941$d",
    data.f AS "941$f"

FROM (
    SELECT biblionumber,
        ExtractValue(metadata, 'count(//datafield[@tag="941"]/subfield[@code="d"])') AS "nb_d",
        ExtractValue(metadata, '//datafield[@tag="941"]/subfield[@code="d"]') AS "d",
        ExtractValue(metadata, 'count(//datafield[@tag="941"]/subfield[@code="f"])') AS "nb_f",
        ExtractValue(metadata, '//datafield[@tag="941"]/subfield[@code="f"]') AS "f"
    FROM biblio_metadata
    WHERE ExtractValue(metadata, 'count(//datafield[@tag="941"]/subfield[@code="d"])') > 0
        AND ExtractValue(metadata, 'count(//datafield[@tag="941"]/subfield[@code="f"])') > 0
) data

WHERE NOT data.d REGEXP CONCAT("^-?\\b\\d+(\\.\\d+)?\\b(\\s-?\\b\\d+(\\.\\d+)?\\b){",data.nb_d-1,"}$")
    OR NOT data.f REGEXP CONCAT("^-?\\b\\d+(\\.\\d+)?\\b(\\s-?\\b\\d+(\\.\\d+)?\\b){",data.nb_f-1,"}$")

/* UTILISÉ DANS DES AUTOMATIONS : signale els notices dont la 941$d ou 941$f ne correspondent pas strictement au format attendu par Bokeh */
