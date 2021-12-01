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

/* FAKE DELETE */
BEGIN;
DELETE from animals *;
SELECT * from animals; /* WOULD SHOW EMPTY DATABASE */
ROLLBACK;
END;

SELECT * from animals; /* ALL THE DATA IS THERE */

/* ABNORMALITY FIXING (negative weight/ future born) */
BEGIN;
DELETE from animals where date_of_birth >= '2022-01-01';
COMMIT;
UPDATE animals
SET weight_kg = weight_kg*-1;
/* SELECT * from animals; ===> ALL weights are opposit to what they were */
ROLLBACK;
UPDATE animals
SET weight_kg = weight_kg*-1 where weight_kg<0;
COMMIT;
/* SELECT * from animals; ===> ALL weights positive */
END;