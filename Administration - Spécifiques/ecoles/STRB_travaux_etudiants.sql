SELECT biblionumber AS "Numéro de notice",
    CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'">',biblionumber,'</a>') as "Lien notice Koha",
    IF(ExtractValue(bm.metadata, '//datafield[@tag="099"]/subfield[@code="x"]')=1, "OUI", "NON") AS 'Export Omeka ?',
	COALESCE(CONCAT(b.title, " : ", bi.volume), b.title) AS 'Titre / Sous-titre',
    b.author AS 'Auteur',
    bi.publicationyear AS "Date de publication",
	CONCAT ("[" , bi.itemtype, "] ", av.lib) AS "Type de document",
    i.itemcallnumber AS "Cote du document"

FROM biblio b
LEFT JOIN biblio_metadata bm USING(biblionumber)
LEFT JOIN biblioitems bi USING(biblionumber)
LEFT JOIN authorised_values av ON bi.itemtype = av.authorised_value AND av.category = "TYPEDOC"
LEFT JOIN items i USING(biblionumber)


WHERE (
        (i.homebranch = "STRB")
    AND 
        (
            (bi.itemtype = "MES")
            OR (bi.itemtype = "PFE")
            OR (bi.itemtype = "TPFE")
            OR (bi.itemtype = "TE")
            OR (bi.itemtype = "MEME")
            OR (bi.itemtype = "MHMONP")
            OR (bi.itemtype = "MEMU")
            OR (bi.itemtype = "THES")
        )
    )



/* Rapport ID (test) : 1310
Rapport ID (prod) : 1301

Affiche le numéro de notice, le lien vers la notice, l'exprt vres Omeka,
le titre, l'auteur, l'année de publication, le type de document (libellé),
et la cote des travaux étudiants de Strasbourg (MES, PFE, TPFE,
Travaux d'étudiants, Mémoire ENSA, Mémoire HMONP, Mémoire universitaire, thèse).*/