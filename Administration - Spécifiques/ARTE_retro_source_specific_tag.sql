SELECT biblionumber,
    b.title as title,
    bi.publishercode as publisher,
    TRIM(TRAILING '|' FROM ExtractValue(bm.metadata, "concat(//datafield[@tag='610']/subfield[@code='a'][1], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][2], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][3], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][4], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][5], concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][6],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][7],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][8],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][9],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][10],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][11],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][12],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][13],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][14],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][15],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][16],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][17],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][18],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][19],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][20],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][21],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][22],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][23],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][24],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][25],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][26],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][27],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][28],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][29],concat('|', concat(//datafield[@tag='610']/subfield[@code='a'][30], '|')))))))))))))))))))))))))))))))))))))))))))))))))))))))))))")) as sourceSpecificTags

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)

WHERE ExtractValue(bm.metadata, "//datafield[@tag='099']/subfield[@code='y']") = "1"

GROUP BY biblionumber

/* #AR440 : epxporte toutes les VODS Arte Campus avec les mots-clefs thésaurus */