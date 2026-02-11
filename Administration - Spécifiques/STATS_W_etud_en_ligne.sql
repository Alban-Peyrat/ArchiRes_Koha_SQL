SELECT count(biblionumber) as nb
FROM biblioitems bi
LEFT JOIN biblio_metadata bm USING(biblionumber)
WHERE bi.itemtype = "TE"
    AND (
        ExtractValue(bm.metadata, '//datafield[@tag="099"]/subfield[@code="x"]') = "1"
        OR ExtractValue(bm.metadata, '//datafield[@tag="856"]/subfield[@code="u"]') != ""
    )