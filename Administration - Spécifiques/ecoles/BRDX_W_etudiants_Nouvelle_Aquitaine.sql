SELECT COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS "title",
    b.author as "author",
    bi.publicationyear AS "date_raw",
    IF(REGEXP_SUBSTR(bi.publicationyear, "\\d{4}") != "", REGEXP_SUBSTR(bi.publicationyear, "\\d{4}"), bi.publicationyear) AS "date_mod",
    av.lib AS "typedoc_name",
    CONCAT(
        ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="a"][1]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="a"][2]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="a"][3]')
    ) AS "localisation",
    ExtractValue(bm.metadata, 'count(//datafield[@tag="609"]/subfield[@code="a"])') AS "localisation_count",
    /* ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"]') AS "keywords",*/
    CONCAT(
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][1]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][2]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][3]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][4]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][5]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][6]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][7]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][8]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][9]'),
        '|_',
        ExtractValue(bm.metadata, '//datafield[@tag="610"]/subfield[@code="a"][10]')
    ) AS "keywords",
    ExtractValue(bm.metadata, 'count(//datafield[@tag="610"]/subfield[@code="a"])') AS "keywords_count",
    ExtractValue(bm.metadata, '//datafield[@tag="330"]/subfield[@code="a"]') AS "abstract",
    CONCAT("http://www.archires.archi.fr/recherche/viewnotice/id_sigb/", biblionumber, "/id_site/*/id_profil/61") AS "archires_link",
    IF(
        ExtractValue(bm.metadata, '//datafield[@tag="099"]/subfield[@code="x"]')=1,
        CONCAT("https://omeka.archires.archi.fr/cas/login?gateway=true&redirect_url=https://omeka.archires.archi.fr/s/ensa/get-biblio/", biblionumber),
        "DOCUMENT_IMPRIME"
    ) AS "consulter_le_fichier",
    biblionumber

FROM biblio b
JOIN biblioitems bi USING (biblionumber)
JOIN biblio_metadata bm USING(biblionumber)
JOIN items i USING(biblionumber)
JOIN authorised_values av ON bi.itemtype = av.authorised_value AND av.category = "TYPEDOC"

WHERE 
    (
        bi.itemtype IN ("MEME", "MHMONP", "MEMU", "MES", "PFE", "THES", "TPFE", "TE")
        AND
            (
                i.homebranch = "BRDX"
                OR i.holdingbranch = "BRDX"
            )
        AND biblionumber IN (
            SELECT biblionumber
            FROM biblio_metadata
            WHERE ExtractValue(bm.metadata, '//datafield[@tag="609"]/subfield[@code="a"]') REGEXP "Charente|Charente-Maritime|Corrèze|Creuse|Dordogne|Gironde|Landes|Lot-et-Garonne|Pyrénées-Atlantique|Deux-Sèvres|Vienne|Haute-Vienne"
        )
    )

/* Rapport ID (test) : 1374
Rapport ID (prod) : 

NE PAS MODIFIER - UTILISÉ PAR UN SERVICE EXTÉRIEUR
#AR244 : liste les travaus étudiants de l'ENSAP Bordeaux ayant comme sujet la Nouvelle Aquitaine */