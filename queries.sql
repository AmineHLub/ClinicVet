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

/* last seen animal by william */

SELECT animals.name FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='William Tatcher'
ORDER BY visit_date DESC
LIMIT 1;

/* How many animals did stephanie see */

SELECT count(animals.name) FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='Stephanie Mendez';

/* list vets and their speciality (including ones who hasn't) */

SELECT vets.name AS vet_name , species.name AS speciality FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON species.id=specializations.species_id;

/* animals that visisted stephanie between 01/04/2020 and 30/08/2002 */

SELECT animals.name FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

/* animal who had the most vists to vets */

SELECT animals.name FROM animals
JOIN visits ON animals.id=visits.animals_id
GROUP BY animals.name
ORDER BY count( animals.name ) DESC
LIMIT 1;

/* first vist to maisy */

SELECT animals.name /*,visits.visit_date*/ FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='Maisy Smith'
ORDER BY visit_date
LIMIT 1;

/* details on latest visit */ 

SELECT visits.visit_date AS latest_visit_date,
animals.*,
vets.name, vets.age, vets.date_of_graduation FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
ORDER BY visit_date DESC
LIMIT 1;

/* visists with vet that has no speciality */

SELECT count(animals.name) as no_spec_visit_count /* , vets.name*/ FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
LEFT JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id IS NULL
GROUP BY vets.name;

/* Speciality that Maisy should take considering the amount of vists she had*/

SELECT species.name FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
JOIN species ON animals.species_id=species.id
WHERE vets.name='Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;