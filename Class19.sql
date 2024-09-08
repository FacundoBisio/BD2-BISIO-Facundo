-- Ejercicio 1 
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'password';
-- Se crea el usuario con permisos limitados.

-- Ejercicio 2 
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';
-- Otorgamos solo los permisos solicitados (SELECT, UPDATE, DELETE) para todas las tablas de la base de datos 'sakila'.

-- Ejercicio 3
CREATE TABLE test_table (id INT);
-- Error esperado: "ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost'"
-- Los permisos CREATE no fueron otorgados, por lo que no puede crear nuevas tablas.

-- Ejercicio 4 
UPDATE sakila.film SET title = 'New Title' WHERE film_id = 1;
-- El usuario tiene permisos UPDATE, por lo que esta operación debería ser exitosa.

-- Ejercicio 5
REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';
-- Se revocan los permisos de UPDATE como se solicitó.

-- Ejercicio 6 -- Esta operación fallará ahora, ya que el usuario ya no tiene permisos UPDATE:
UPDATE sakila.film SET title = 'New Title' WHERE film_id = 1;
-- Error esperado: "ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost'"
-- El permiso UPDATE fue revocado, por lo tanto, el usuario ya no puede realizar esta operación.
