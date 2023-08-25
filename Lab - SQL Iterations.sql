/* Lab | SQL Iterations */


-- Write a query to find what is the total business done by each store.
USE sakila;
SELECT i.store_id AS STORE, SUM(p.amount) AS Amount
FROM inventory i
JOIN rental r
USING (inventory_id)
JOIN payment p
USING (rental_id)
GROUP BY i.store_id;

-- Convert the previous query into a stored procedure.
DELIMITER //
CREATE PROCEDURE calculate_store_revenue()
BEGIN
    SELECT i.store_id AS STORE, SUM(p.amount) AS Amount
    FROM inventory i
    JOIN rental r
    USING (inventory_id)
    JOIN payment p
    USING (rental_id)
    GROUP BY i.store_id;
END;
//
DELIMITER ;

CALL calculate_store_revenue();

-- Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

DELIMITER //
CREATE PROCEDURE calculate_store_revenue_by_id(IN input_store_id INT)
BEGIN
    SELECT SUM(p.amount) AS TotalSales
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    WHERE i.store_id = input_store_id;
END;
//
DELIMITER ;

CALL calculate_store_revenue_by_id(1); 


-- Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). 
-- Call the stored procedure and print the results.
DELIMITER //
CREATE PROCEDURE calculate_store_revenue_by_id(IN input_store_id INT)
BEGIN
    DECLARE total_sales_value FLOAT;
    
    SELECT SUM(p.amount) INTO total_sales_value
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    WHERE i.store_id = input_store_id;
    
    SELECT total_sales_value AS TotalSales;
END;
//
DELIMITER ;

CALL calculate_store_revenue_by_id(1);

-- In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag.
-- Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.

DELIMITER //
CREATE PROCEDURE calculate_store_revenue_and_flag(IN input_store_id INT)
BEGIN
    DECLARE total_sales_value FLOAT;
    DECLARE flag VARCHAR(10);
    
    SELECT SUM(p.amount) INTO total_sales_value
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    WHERE i.store_id = input_store_id;
    
    IF total_sales_value > 30000 THEN
        SET flag = 'green_flag';
    ELSE
        SET flag = 'red_flag';
    END IF;
    
    SELECT total_sales_value AS TotalSales, flag AS Flag;
END;
//
DELIMITER ;

CALL calculate_store_revenue_and_flag(2); 

