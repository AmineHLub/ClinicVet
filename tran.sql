/* change species to unspecified and rollback */
BEGIN;
COMMIT;
UPDATE animals
SET species = 'unspecified';
/* SELECT * FROM animals;  ===> would show unspecified data */
ROLLBACK;
END;

/* SET ANIMALS WITH MON TO DIGIMON */
BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';
COMMIT;
END;

/* SET POKEMON FOR THE REST */
BEGIN;
UPDATE animals
SET species = 'pokemon' WHERE species is NULL;
COMMIT;
END;

/* SELECT * FROM animals;  ===> would show all new updated data */
