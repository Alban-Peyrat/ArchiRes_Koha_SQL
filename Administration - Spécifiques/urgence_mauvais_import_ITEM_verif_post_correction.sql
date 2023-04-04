SELECT b.abstract AS "ppn",
    ExtractValue(bm.metadata, '//datafield[@tag="098"]/subfield[@code="e"]') AS "date_premier_import_sudoc"

FROM biblio b 
LEFT JOIN biblio_metadata bm USING(biblionumber)

WHERE ExtractValue(bm.metadata, '//datafield[@tag="098"]/subfield[@code="e"]') BETWEEN <<Jour du mauvais import (JJ/MM/AAAA)|date>> AND <<Jour avec import suivant de la correction des mauvais exemplaires (JJ/MM/AAAA)|date>>

/* Rapport ID (test) : 1362
Rapport ID (prod) : 1364

Lié à la procédure d'urgence en cas de mauvais import via ITEM

Liste les ntoices qui ont été importées pour la première fois par le Sudoc entre le jour de l'erreur+1 et le premier jour d'import après l'erreur (pour prendre en compte les réoslutions le vendredi) */