#class18

# EJERCICIOS

# 1. Write a function that returns the amount of copies of a film in a store in sakila-db. Pass either the film id or the film name and the store id.
DELIMITER //
CREATE PROCEDURE get_film_copies(
	IN p_film_id int,
    IN p_film_name varchar(100),
    IN p_store_id int)
BEGIN
	DECLARE filmID int;
    
    if p_film_id is null then
		select film_id from film
		where title = p_film_name;
	else
		set filmID = p_film_id;
	end if;
    
	SELECT COUNT(*) AS copies_in_store
    FROM inventory
    WHERE film_id = filmID
      AND store_id = p_store_id;
    
END //
DELIMITER ;

call get_film_copies(1,null,2)


# 2. acepta un país como entrada y devuelve una lista de nombres de clientes que viven en ese país, concatenados y separados por punto y coma (;)
DELIMITER $$

CREATE PROCEDURE GetCustomersByCountry(
    IN inputCountry VARCHAR(100),   -- Parámetro de entrada: el país
    OUT customerList VARCHAR(1000)  -- Parámetro de salida: la lista concatenada de clientes
)
BEGIN
    -- Variables necesarias
    DECLARE done INT DEFAULT FALSE;  -- Controla cuándo hemos terminado de recorrer el cursor
    DECLARE firstName VARCHAR(50);   -- Almacena el nombre del cliente
    DECLARE lastName VARCHAR(50);    -- Almacena el apellido del cliente
    DECLARE tempList VARCHAR(1000) DEFAULT '';  -- Almacena la lista concatenada de nombres

    -- Declarar el cursor
    DECLARE customerCursor CURSOR FOR
        SELECT c.first_name, c.last_name
        FROM customer c
        JOIN address a ON c.address_id = a.address_id
        JOIN city ci ON a.city_id = ci.city_id
        JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = inputCountry;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN customerCursor;

    -- Loop para recorrer los datos del cursor
    read_loop: LOOP
        -- Extraer la fila actual (nombre y apellido) y guardarlos en las variables
        FETCH customerCursor INTO firstName, lastName;
        
        IF done THEN
            LEAVE read_loop;  -- Salir del loop si no hay más filas
        END IF;
        
        SET tempList = CONCAT(tempList, firstName, ' ', lastName, ';');
    END LOOP;

    CLOSE customerCursor;

    -- Asignar el resultado final a la variable de salida
    SET customerList = tempList;
END$$

DELIMITER ;
 

DROP procedure GetCustomersByCountry;

CALL GetCustomersByCountry('Argentina', @customerList);
SELECT @customerList;


# 3. función inventory_in_stock y el procedimiento film_in_stock explique el código
SHOW procedure status;

# inventory_in_stock() FUNCTION
SELECT inventory_in_stock(10) AS in_stock;

-- Esto devolverá:
-- 1(VERDADERO) si el artículo está disponible.
-- 0(FALSO) si el artículo no está en stock (es decir, alquilado).


# film_in_stock() PROCEDURE
CALL film_in_stock(100, 1, @film_count);
SELECT @film_count AS available_copies;

-- Esto devolverá:
-- un valor en available_copies, que representa la cantidad de copias de la película que están actualmente disponibles para alquiler.



## Diferencias entre inventory_in_stocky film_in_stock:

# inventory_in_stock: Comprueba la disponibilidad de un artículo específico del inventario (copia de una película). 
-- Devuelve un valor booleano (VERDADERO/FALSO) que indica si el artículo específico del inventario está en stock.

# film_in_stock: Comprueba el número total de copias de una película disponibles en una tienda determinada y devuelve 
-- un recuento entero que representa el número de copias en stock.


