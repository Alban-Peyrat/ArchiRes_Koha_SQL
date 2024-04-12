SELECT "Biblio" as source,
    biblionumber,
    b.title,
    b.author,
    bi.publicationyear,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') AS "merge",
    b.timestamp
FROM biblio b
LEFT JOIN biblioitems bi USING (biblionumber)
LEFT JOIN biblio_metadata bm USING (biblionumber)
WHERE biblionumber = TRIM(<<Biblionumber>>)

UNION ALL

SELECT "Deleted biblio" as source,
    biblionumber,
    db.title,
    db.author,
    dbi.publicationyear,
    dbi.itemtype,
    ExtractValue(dbm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') AS "merge",
    db.timestamp
FROM deletedbiblio db
LEFT JOIN deletedbiblioitems dbi USING (biblionumber)
LEFT JOIN deletedbiblio_metadata dbm USING (biblionumber)
WHERE biblionumber = TRIM(<<Biblionumber>>)

UNION ALL

SELECT "Merged biblio" as source,
    biblionumber,
    b.title,
    b.author,
    bi.publicationyear,
    bi.itemtype,
    ExtractValue(bm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') AS "merge",
    b.timestamp
FROM biblio b
LEFT JOIN biblioitems bi USING (biblionumber)
LEFT JOIN biblio_metadata bm USING (biblionumber)
WHERE ExtractValue(metadata, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP CONCAT("Archires_FUS_BIB", TRIM(<<Biblionumber>>))

UNION ALL

SELECT "Deleted by merge biblio" as source,
    biblionumber,
    db.title,
    db.author,
    dbi.publicationyear,
    dbi.itemtype,
    ExtractValue(dbm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') AS "merge",
    db.timestamp
FROM deletedbiblio db
LEFT JOIN deletedbiblioitems dbi USING (biblionumber)
LEFT JOIN deletedbiblio_metadata dbm USING (biblionumber)
WHERE ExtractValue(dbm.metadata, '//datafield[@tag="035"]/subfield[@code="z"]') REGEXP CONCAT("Archires_FUS_BIB", TRIM(<<Biblionumber>>))

/* Ce rapprot permet de retrouver une notice dans al table biblio ou deleted_biblios, indiquant la notice qui a été fusionné si nécessaire. */