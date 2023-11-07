SELECT "Biblio" as source,
    biblionumber,
    b.title,
    b.author,
    bi.publicationyear,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="035"]/subfield[@code="a"]'),
    b.timestamp
FROM biblio b
LEFT JOIN biblioitems bi USING (biblionumber)
LEFT JOIN biblio_metadata bm USING (biblionumber)
WHERE biblionumber = <<Biblionumber>>

UNION ALL

SELECT "Deleted biblio" as source,
    biblionumber,
    db.title,
    db.author,
    dbi.publicationyear,
    dbi.itemtype,
    ExtractValue(dbm.metadata, '//datafield[@tag="035"]/subfield[@code="a"]'),
    db.timestamp
FROM deletedbiblio db
LEFT JOIN deletedbiblioitems dbi USING (biblionumber)
LEFT JOIN deletedbiblio_metadata dbm USING (biblionumber)
WHERE biblionumber = <<Biblionumber>>

/* Ce rapprot permet de retrouver une notice dans al table biblio ou deleted_biblios. */