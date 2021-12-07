/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species varchar(100)
);

/*CAN USE:
 ALTER TABLE animals
ADD species varchar(100); */

CREATE TABLE owners (
    id SERIAL PRIMARY KEY NOT NULL,
    full_name varchar(100) NOT NULL,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL
);

/* MODIFYING animals table*/

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
    ADD species_id INT,
    ADD CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals
    ADD owners_id INT,
    ADD CONSTRAINT owners_id FOREIGN KEY(owners_id) REFERENCES owners(id);

CREATE TABLE vets (
    id SERIAL PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL,
    age INT,
    date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
    vets_id INT,
    species_id INT,
    CONSTRAINT vets_id FOREIGN KEY(vets_id) REFERENCES vets(id),
    CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    vets_id INT,
    animals_id INT,
    CONSTRAINT vets_id FOREIGN KEY(vets_id) REFERENCES vets(id),
    CONSTRAINT animals_id FOREIGN KEY(animals_id) REFERENCES animals(id)
);

ALTER TABLE visits 
ADD visit_date DATE;

ALTER TABLE owners 
ADD email varchar(120);
