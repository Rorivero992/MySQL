-- LAB  | Stored procedures

USE SAKILA;
-- In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query:

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  
-- STORED PROCEDURE  
DROP PROCEDURE IF EXISTS customers_by_category;
DELIMITER //
CREATE PROCEDURE customers_by_category (OUT param1 INT)
BEGIN 
  SELECT COUNT(*) INTO param1
  FROM (
    SELECT first_name
    FROM SAKILA.customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE category.name = "Action"
    GROUP BY first_name, last_name, email
  ) AS SUB1;
END;

CALL customers_by_category(@X);
sELECT @X AS customers;

/* Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers 
that rented movie of that category/genre.
For eg., it could be action, animation, children, classics, etc.*/

DROP PROCEDURE IF EXISTS customers_by_category3;
DELIMITER //
CREATE PROCEDURE customers_by_category3 (IN param0 text)
BEGIN 
    DECLARE param1 FLOAT;
    
    SELECT COUNT(*) INTO param1
    FROM (
        SELECT first_name
        FROM SAKILA.customer
        JOIN rental ON customer.customer_id = rental.customer_id
        JOIN inventory ON rental.inventory_id = inventory.inventory_id
        JOIN film ON film.film_id = inventory.film_id
        JOIN film_category ON film_category.film_id = film.film_id
        JOIN category ON category.category_id = film_category.category_id
        WHERE BINARY category.name = BINARY param0
        GROUP BY first_name, last_name, email
    ) AS SUB1;
    
    SELECT param1 AS CUSTOMER_CATEGORY;
END;
//
DELIMITER ;

CALL customers_by_category3 ("ACTION");

/* Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
Pass that number as an argument in the stored procedure. */

DELIMITER //
CREATE PROCEDURE filter_categories_by_movie_count(IN min_movies INT)
BEGIN 
    SELECT c.name AS category, COUNT(*) AS num_movies
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    GROUP BY c.name
    HAVING num_movies > min_movies;
END;
//
DELIMITER ;

CALL filter_categories_by_movie_count(50); 