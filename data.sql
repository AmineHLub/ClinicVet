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


/* insert into vets table vets data */
INSERT INTO vets (name,age,date_of_graduation)
VALUES  ('William Tatcher',45,'2000-04-23'),
        ('Maisy Smith',26,'2019-01-17'),
        ('Stephanie Mendez',64,'1981-05-04'),
        ('Jack Harkness',38,'2008-06-08');

/* insert data into specialization convinient with the other tables */

INSERT INTO specializations (vets_id,species_id)
VALUES  (1,1), /* Can use SELECT vets_id from vets where name='William tatcher'* and same for specie*/
        (2,2),
        (2,1),
        (3,2);


/* insert visit table data*/
INSERT INTO visits (vets_id,animals_id,visit_date)
VALUES 
    (1,(SELECT id from animals where name = 'Agumon'),'2020-05-24'),
    (3,(SELECT id from animals where name = 'Agumon'),'2020-07-22'),
    (4,(SELECT id from animals where name = 'Gabumon'),'2021-02-02'),
    (2,(SELECT id from animals where name = 'Pikachu'),'2020-01-05'),
    (2,(SELECT id from animals where name = 'Pikachu'),'2020-03-08'),
    (2,(SELECT id from animals where name = 'Pikachu'),'2020-05-14'),
    (3,(SELECT id from animals where name = 'Devimon'),'2021-05-04'),
    (4,(SELECT id from animals where name = 'Charmander'),'2021-02-24'),
    (2,(SELECT id from animals where name = 'Plantmon'),'2019-12-21'),
    (1,(SELECT id from animals where name = 'Plantmon'),'2020-08-10'),
    (2,(SELECT id from animals where name = 'Plantmon'),'2021-04-07'),
    (3,(SELECT id from animals where name = 'Squirtle'),'2019-09-29'),
    (4,(SELECT id from animals where name = 'Angemon'),'2020-10-03'),
    (4,(SELECT id from animals where name = 'Angemon'),'2020-11-04'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2019-01-24'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2019-05-15'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2020-02-27'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2020-08-03'),
    (3,(SELECT id from animals where name = 'Blossom'),'2020-05-24'),
    (1,(SELECT id from animals where name = 'Blossom'),'2021-01-11');

 /* in order to get a huge data base we used the given script
 multiple(around 5times) times do not run these commands unless you know
 what are they for*/

INSERT INTO visits (animals_id, vets_id, visit_date)
 SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets)
  vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' ||
 generate_series(1,2500000) || '@mail.com';

/* BEFORE CHANGES (indices) */
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4; /* 1787 ms */
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2; /* 600ms */
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com'; /* 3000+ms */

/* AFTER CHANGES (indices) */

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4; /* 786ms */
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2; 
/* 843ms */
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com'; /* 0.076 ms */