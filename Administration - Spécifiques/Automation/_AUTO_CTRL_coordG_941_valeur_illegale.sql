SELECT data.biblionumber,
    data.d AS "941$d_no1",
    data.f AS "941$f_no1"

FROM (
    SELECT biblionumber,
        ExtractValue(metadata, '//datafield[@tag="941"]/subfield[@code="d"][1]') AS "d",
        ExtractValue(metadata, '//datafield[@tag="941"]/subfield[@code="f"][1]') AS "f"
    FROM biblio_metadata
    WHERE ExtractValue(metadata, 'count(//datafield[@tag="941"]/subfield[@code="d"])') > 0
        AND ExtractValue(metadata, 'count(//datafield[@tag="941"]/subfield[@code="f"])') > 0
) data

WHERE (
        data.d REGEXP "^-?\\d+(\\.\\d+)?$"
        AND (data.d > 90
            OR data.d < -90
        )
    )
    OR (
        data.f REGEXP "^-?\\d+(\\.\\d+)?$"
        AND (
            data.f > 180
            OR data.f < -180
        )
    )
/* UTILISÉ DANS DES AUTOMATIONS : signale les notices dont la première 941$d ou 941$f ne contient pas une valeur légale.
Ne vérifie que les notices qui ont strictement le bon format dans la première 941 */
