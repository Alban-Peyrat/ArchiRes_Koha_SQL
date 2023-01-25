SELECT biblionumber AS "bibnb",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "link",
    ExtractValue(bm.metadata, '//datafield[@tag="710"]/subfield[@code="9"]') as "710_9",
    ExtractValue(bm.metadata, '//datafield[@tag="711"]/subfield[@code="9"]') as "711_9",
    ExtractValue(bm.metadata, '//datafield[@tag="712"]/subfield[@code="9"]') as "712_9",
    ExtractValue(bm.metadata, '//datafield[@tag="601"]/subfield[@code="9"]') as "601_9",
    ExtractValue(bm.metadata, '//datafield[@tag="607"]/subfield[@code="9"]') as "607_9",
    ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="9"]') as "609_9"

FROM biblio_metadata bm

WHERE (
        (ExtractValue(bm.metadata, '//datafield[@tag="710"]/subfield[@code="9"]') REGEXP '(205984)|(404111)|(335479)|(301737)')
        OR (ExtractValue(bm.metadata, '//datafield[@tag="711"]/subfield[@code="9"]') REGEXP '(205984)|(404111)|(335479)|(301737)')
        OR (ExtractValue(bm.metadata, '//datafield[@tag="712"]/subfield[@code="9"]') REGEXP '(205984)|(404111)|(335479)|(301737)')
        OR (ExtractValue(bm.metadata, '//datafield[@tag="601"]/subfield[@code="9"]') REGEXP '(205984)|(404111)|(335479)|(301737)')
        OR (ExtractValue(bm.metadata, '//datafield[@tag="607"]/subfield[@code="9"]') REGEXP '(275878)')
        OR (ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="9"]') REGEXP '(275878)')
    )

/* Rapport ID (test) : 1354
Rapport ID (prod) : 1337

AR227 : vérifiez si les notices 205984 404111 335479 301737 (COL) et 275878 (GEO) sont encore présentes dans les notices de base */