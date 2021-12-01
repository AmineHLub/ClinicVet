/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name from animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg>10.5;
SELECT name from animals where neutered=TRUE;
SELECT name from animals where weight_kg BETWEEN 10.4 AND 17.3;

/* HOW MANY IN TOTAL ? */
SELECT COUNT(name) from animals;

/* HOW MANY TRIED TO ESCAPE */
SELECT COUNT(name) from animals where escape_attempts > 0;

/* AVERAGE WEIGHT */
SELECT AVG(weight_kg) from animals;

/* CONDITIONAL SELECTION OF MAX ATTEMPTS ANIMAL NAME*/
SELECT name from animals
WHERE escape_attempts = (select MAX(escape_attempts) from animals);

/* WHICH IS MAX/MIN WEIGHT FOR EACH SPECIE */
SELECT species, MAX(weight_kg), MIN(weight_kg)
from animals GROUP BY species;

/* AVG ESCAPE ATTEMPT BETWEEN 1990 AND 2000 */
SELECT species,AVG(escape_attempts) from animals
where date_of_birth BETWEEN '1990-1-1' AND '2000-1-1' GROUP BY species;