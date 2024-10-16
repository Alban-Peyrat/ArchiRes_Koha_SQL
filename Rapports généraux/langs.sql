SELECT bm.biblionumber,
	ExtractValue(bm.metadata, 'count(//datafield[@tag="101"]/subfield[@code="a"])') as "nb_lang",
    av.authorised_value as "first_lang_code",
    av.lib as "first_lang_label",
    CASE ExtractValue(bm.metadata, 'count(//datafield[@tag="101"]/subfield[@code="a"])')
    	WHEN 1 THEN av.lib
        WHEN 2 THEN "bilingue"
        WHEN 3 THEN "trilingue"
        WHEN 0 THEN null
        ELSE "multilingue"
    END as "lang_label",
    CASE ExtractValue(bm.metadata, 'count(//datafield[@tag="101"]/subfield[@code="a"])')
    	WHEN 1 THEN IF(av.authorised_value != "mul", "monolingue", "multilingue")
        WHEN 0 THEN null
        ELSE "multilingue"
    END as "multilingue"
FROM biblio_metadata bm
LEFT JOIN authorised_values av ON ExtractValue(bm.metadata, '//datafield[@tag="101"]/subfield[@code="a"][1]') = av.authorised_value AND av.category='LANG'
