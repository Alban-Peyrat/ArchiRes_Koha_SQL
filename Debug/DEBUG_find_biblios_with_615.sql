SELECT biblionumber,
    ExtractValue(bm.metadata, '//datafield[@tag="615"]/subfield[@code="a"]') AS subfield,
    ExtractValue(bm.metadata, 'count(//datafield[@tag="615"]/subfield[@code="a"])') AS nb_subfield

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata, '//datafield[@tag="615"]/subfield[@code="2"]') = TRIM(<<dollar 2 (exact match)>>)

/* Ce rapport sert à lister les notices contenant un 615 avec le code voulu */