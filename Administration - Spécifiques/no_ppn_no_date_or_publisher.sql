SELECT biblionumber,
    GROUP_CONCAT(i.homebranch, ",") AS homebranch

FROM items i
LEFT JOIN biblio b USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE (
    bi.itemtype NOT IN ("ART", "TE")
    AND (
        b.abstract IS NULL
        AND NOT ExtractValue(bm.metadata, '//controlfield[@tag="003"]') LIKE '%www.sudoc.fr%'
    )
    AND (
        bi.publishercode IS NULL
        OR (
            bi.publicationyear IS NULL
            AND (
                ExtractValue(bm.metadata, '//datafield[@tag="100"]/subfield[@code="a"]') = ""
                OR TRIM(SUBSTRING(ExtractValue(bm.metadata, '//datafield[@tag="100"]/subfield[@code="a"]'), 10, 8)) = ""
            )
        )
    )
)

GROUP BY biblionumber

/* Identifie les notices sans PPN ni (dates ou éditeurs) */