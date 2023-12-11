SELECT biblionumber,
    ExtractValue(bm.metadata, CONCAT('//datafield[@tag="',  <<Field Tag>>, '"]/subfield[@code="', <<Subfield Code>>, '"]')) AS subfield,
    ExtractValue(bm.metadata, CONCAT('count(//datafield[@tag="',  <<Field Tag>>, '"]/subfield[@code="', <<Subfield Code>>, '"])')) AS nb_subfields

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata, CONCAT('//datafield[@tag="',  <<Field Tag>>, '"]/subfield[@code="', <<Subfield Code>>, '"]')) != ""

/* Ce rapport sert à lister les notices contenant le sous-champ voulu en MARC */