#class17

#1 Crear 3 querys 
-- 1ra
SELECT * 
FROM address 
WHERE postal_code IN ('12345', '54321');

-- 2da
explain SELECT * 
FROM address 
WHERE postal_code NOT IN ('12345', '54321');

-- 3ra
explain SELECT a.*, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code = '12345';

SHOW PROFILES;

CREATE INDEX idx_postal_code ON address(postal_code);

#2
explain select * from actor where first_name = "GRACE";
explain select * from actor where last_name = "SWANK";

/* Si no hay índices creados en las columnas first_name o last_name, las consultas harán un escaneo completo de la tabla. 
Si existe un índice en first_name o last_name, las búsquedas serán mucho más rápidas en esas columnas porque MySQL puede acceder 
rápidamente a los registros.
*/

#3
SELECT * 
FROM film 
WHERE description LIKE '%action%';

create fulltext index idx_film_description on film(description);

explain SELECT * 
FROM film_text 
WHERE MATCH(description) AGAINST('action' IN NATURAL LANGUAGE MODE);

# En resumen, MATCH ... AGAINST es más rápido y eficiente para búsquedas de texto en campos largos o con mucho contenido, 
# mientras que LIKE es útil para búsquedas más simples o en bases de datos pequeñas.

