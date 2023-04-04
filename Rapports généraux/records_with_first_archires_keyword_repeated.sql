SELECT REGEXP_SUBSTR(ExtractValue(metadata, '//datafield[@tag="610"]/subfield[@code="9"]'), "\\d+") AS first_keyword,
	ExtractValue(metadata, '//datafield[@tag="610"]/subfield[@code="9"]') AS all_keywords,
	biblionumber

FROM biblio_metadata

WHERE ExtractValue(metadata, '//datafield[@tag="610"]/subfield[@code="9"]') REGEXP "\\d+\\s\\d+"

HAVING SUBSTR(all_keywords FROM (INSTR(all_keywords, " ") + 1)) REGEXP first_keyword

/* Rapport ID (test) : 1334
Rapport ID (prod) : 1365

#AR108 : liste les notices avec le premier mot-clef ArchiRès répétés plusieurs fois */