/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES  ('Agumon','2020-02-03',0,true,10.23),
        ('Gabumon','2018-09-15',2,true,8.00),
        ('Pikachu','2021-01-07',1,false,15.04),
        ('Devimon','2017-05-12',5,true,11.00),
        ('Charmander','2022-02-02',0,false,-11.00),
        ('Plantmon','2022-09-15',2,true,-5.70),
        ('Squirtle','1993-04-02',3,false,-12.13),
        ('Angemon','2005-06-12',1,true,-45.00),
        ('Boarmon','2005-06-07',7,true,20.40),
        ('Blossom','1998-10-13',3,true,17.00);

/* populating owner table*/

INSERT INTO owners (full_name,age)
VALUES  ('Sam Smith',34),
        ('Jennifer Orwell',19),
        ('Bob',45),
        ('Melody Pond',77),
        ('Dean Winchester',14),
        ('Jodie Whittaker',38);

/* populating species table*/

INSERT INTO species (name)
VALUES  ('Pokemon'),
        ('Digimon');

/* Set species_id */

/* SET ANIMALS WITH MON TO DIGIMON */
BEGIN;
UPDATE animals
SET species_id = 2 WHERE name LIKE '%mon';
COMMIT;
END;

/* SET POKEMON FOR THE REST */
BEGIN;
UPDATE animals
SET species_id = 1 WHERE species_id is NULL;
COMMIT;
END;

/* Set owners_id */

BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')  WHERE name='Agumon';
COMMIT;
END;

BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')  WHERE name='Gabumon' OR name='Pikachu';
COMMIT;
END;

BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob')  WHERE name='Devimon' OR name='Plantmon';
COMMIT;
END;

BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')  WHERE name='Charmander' OR name='Squirtle' OR name='Blossom';
COMMIT;
END;

BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')  WHERE name='Angemon' OR name='Boarmon';
COMMIT;
END;

/* animals that belong to melody pond  */

SELECT name FROM animals JOIN owners ON owners.id=animals.owners_id
WHERE full_name = 'Melody Pond';

/* animals of type pokemon */

select animals.name from animals
JOIN species on animals.species_id = species.id
WHERE species.name = 'Pokemon';

/* animals and their owners  */

SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;

/* species count */

SELECT species.name, count( animals.species_id ) FROM species
join animals on animals.species_id = species.id
GROUP BY species.name;

/* all pokemons jennifer has */

SELECT animals.name FROM species
join animals on animals.species_id = species.id
JOIN owners ON owners.id = animals.owners_id
where owners.full_name='Jennifer Orwell' AND species.name='Pokemon';

/* Animals that belongs to deaen and haven't tried to escape */

SELECT name FROM animals
JOIN owners ON owners.id = animals.owners_id
WHERE owners.full_name='Dean Winchester' AND  animals.escape_attempts=0;

/* who has most animals */

SELECT owners.full_name FROM animals
JOIN owners ON owners.id = animals.owners_id
GROUP BY owners.full_name
ORDER BY count(name) desc
limit 1;
