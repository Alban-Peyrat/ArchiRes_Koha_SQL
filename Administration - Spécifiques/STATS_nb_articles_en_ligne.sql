SELECT count(biblionumber) as nb
FROM biblioitems bi
LEFT JOIN biblio_metadata bm USING(biblionumber)
WHERE (
        bi.itemtype IN ("ART", "CHA")
        AND ExtractValue(bm.metadata, '//datafield[@tag="856"]/subfield[@code="u"]') != ""
    ) OR (
        bi.itemtype = "RESELEC"
        AND ExtractValue(bm.metadata, '//datafield[@tag="463"]/subfield[@code="t"]') != ""
    )