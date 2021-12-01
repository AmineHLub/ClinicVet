/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species varchar(100) NOT NULL ,
    PRIMARY KEY (id)
);

/*CAN USE:
 ALTER TABLE animals
ADD species varchar(100); */