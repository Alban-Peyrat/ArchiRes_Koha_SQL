SELECT biblionumber,
    ExtractValue(bm.metadata, CONCAT('//datafield[@tag="',  TRIM(<<Field Tag>>), '"]/subfield[@code="', TRIM(<<Subfield Code>>), '"]')) AS subfield,
    ExtractValue(bm.metadata, CONCAT('count(//datafield[@tag="',  TRIM(<<Field Tag>>), '"]/subfield[@code="', TRIM(<<Subfield Code>>), '"])')) AS nb_subfields

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata, CONCAT('//datafield[@tag="',  TRIM(<<Field Tag>>), '"]/subfield[@code="', TRIM(<<Subfield Code>>), '"]')) != ""

/* Ce rapport sert à lister les notices contenant le sous-champ voulu en MARC */