SELECT itemnumber

FROM items i
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE i.homebranch = "MLVL"
    AND ExtractValue(bm.metadata, '//datafield[@tag="856"]/subfield[@code="u"]') REGEXP "^http://fr.calameo.com/"
    AND ExtractValue(bm.metadata, '//datafield[@tag="300"]/subfield[@code="a"]') REGEXP "^Cahiers du"
    AND ExtractValue(bm.metadata, '//datafield[@tag="710"]/subfield[@code="9"]') REGEXP "342907" /* ENSA Paris-Est*/
    AND NOT ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="9"]') REGEXP "397420" /* Bib num Archires */