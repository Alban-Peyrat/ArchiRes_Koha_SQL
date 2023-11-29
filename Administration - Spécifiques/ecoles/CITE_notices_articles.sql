SELECT biblionumber AS 'biblionumber',
    ExtractValue(bm.metadata, '//datafield[@tag="463"]/subfield[@code="x"]') AS "ISSN"

FROM biblio b
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN biblio_metadata bm  USING(biblionumber)

WHERE
    bi.itemtype='ART'
    AND b.datecreated between <<Between (yyyy-mm-dd)|date>> and <<and (yyyy-mm-dd)|date>>
    AND (
        ExtractValue(bm.metadata, '//datafield[@tag="463"]/subfield[@code="x"]') in (
            "0768-5785", /* Archiscopie */
            "2109-2389", /* Exé */
            "0330-3292", /* Archibat */
            "2279-7610", /* Topscape Paysage */
            "2179-748X", /* Monolito */
            "2504-1274", /* AS Architecture suisse */
            "2553-3495",  /* Garden_Lab */
            "0003-8695" /* L'Architecture d'aujourd'hui */
            )
    )