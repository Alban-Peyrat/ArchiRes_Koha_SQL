SELECT biblionumber,
    ExtractValue(metadata, CONCAT('//datafield[@tag="',  TRIM(<<Field Tag>>), '"]/subfield[@code="', TRIM(<<Subfield Code>>), '"]')) AS subfield,
    ExtractValue(metadata, CONCAT('count(//datafield[@tag="',  TRIM(<<Field Tag>>), '"]/subfield[@code="', TRIM(<<Subfield Code>>), '"])')) AS nb_subfields

FROM biblio_metadata

/* Ce rapport exporte le contenu du sous-champs voulus pour toutes les notices de la base */