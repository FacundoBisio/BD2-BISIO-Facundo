CREATE DATABASE IF NOT EXISTS imdb;

USE imdb;

CREATE TABLE IF NOT EXISTS film (
    film_id INT AUTO_INCREMENT,
    title VARCHAR(255),
    description TEXT,
    release_year INT,
    CONSTRAINT PK_film_id PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS actor (
    actor_id INT AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    CONSTRAINT PK_actor_id PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS film_actor (
	film_actor_id INT,
    actor_id INT,
    film_id INT,
    CONSTRAINT PK_film_actor_id PRIMARY KEY (film_actor_id)
);

-- Agregar columna last_update a la tabla film
ALTER TABLE film
ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Agregar columna last_update a la tabla actor
ALTER TABLE actor
ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Agregar foreign keys film_actor
ALTER TABLE film_actor
ADD CONSTRAINT FK_actor_id FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
ADD CONSTRAINT FK_film_id FOREIGN KEY (film_id) REFERENCES film(film_id);

-- Inserts para la tabla film
INSERT INTO film (title, description, release_year, last_update) VALUES ('Film 1', 'Description for Film 1', 2020, NOW());
INSERT INTO film (title, description, release_year, last_update) VALUES ('Film 2', 'Description for Film 2', 2018, NOW());
INSERT INTO film (title, description, release_year, last_update) VALUES ('Film 3', 'Description for Film 3', 2015, NOW());

-- Inserts para la tabla actor
INSERT INTO actor (first_name, last_name, last_update) VALUES ('John', 'Doe', NOW());
INSERT INTO actor (first_name, last_name, last_update) VALUES ('Jane', 'Doe', NOW());
INSERT INTO actor (first_name, last_name, last_update) VALUES ('Alice', 'Smith', NOW());

-- Inserts para la tabla film_actor
INSERT INTO film_actor (film_actor_id, actor_id, film_id) VALUES (1, 1, 1);
INSERT INTO film_actor (film_actor_id, actor_id, film_id) VALUES (2, 2, 1);
INSERT INTO film_actor (film_actor_id, actor_id, film_id) VALUES (3, 3, 2);
