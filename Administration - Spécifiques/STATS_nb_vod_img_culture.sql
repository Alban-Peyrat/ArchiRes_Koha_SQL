SELECT count(biblionumber)
FROM biblio_metadata bm
WHERE ExtractValue(bm.metadata, '//datafield[@tag="035"]/subfield[@code="a"]') LIKE "ArteCampusIDC%"