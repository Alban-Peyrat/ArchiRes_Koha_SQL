SELECT biblionumber,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="099"]/subfield[@code="x"]') AS "omeka"

FROM biblioitems bi
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN items i USING(biblionumber)

WHERE (
    bi.itemtype != "EDOCA"
    AND i.homebranch = "STET"
)

/* Rapport ID (test) : 1470
Rapport ID (prod) : 1474

Liste tous les bibnbs autres que de VOD pour les exemplaires de STET */