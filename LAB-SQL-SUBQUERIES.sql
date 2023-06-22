USE sakila;
-- 1) How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT F.title, S.store_id AS STORE, COUNT(*) AS FILM_STOCK 
FROM film F
JOIN inventory I
ON F.film_id=i.film_id
JOIN store S 
ON I.store_id = S.store_id
WHERE F.title = "Hunchback Impossible"
GROUP BY STORE; 

-- 2) List all films whose length is longer than the average of all the films.
SELECT film_id, title, ROUND(AVG(length),00) AS Avg_length
FROM film 
GROUP BY film_id, title
HAVING AVG(length)> ( 
	SELECT AVG(length) AS Avg_length 
    FROM FILM
    )
ORDER BY Avg_length DESC;

-- 3) Use subqueries to display all actors who appear in the film Alone Trip.
SELECT A.actor_id, A.first_name, A.last_name, FA.film_id
FROM actor A
JOIN film_actor FA
USING (actor_id)
GROUP BY A.actor_id, A.first_name, A.last_name, FA.film_id
HAVING FA.film_id IN (
	SELECT film_id 
    FROM film 
    WHERE title="Alone Trip"
    );

-- 4) Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT film_id, title 
FROM film
WHERE film_id IN (
	SELECT FC.film_id 
	FROM film_category FC
    JOIN category C
    USING (category_id)
    WHERE C.name="family"
    );
  
-- 5) Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct 
-- tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT CONCAT(first_name, ' ', last_name) AS Name, email 
FROM customer
WHERE address_id IN (
	SELECT address_id 
    FROM address 
    WHERE city_id IN (
		SELECT city_id 
        FROM city 
        JOIN country
        USING (country_id)
        WHERE country = "Canada")
        );
        
  -- USING JOINS      
SELECT CONCAT(C.first_name, ' ', C.last_name)AS Name, C.email, CO.country
FROM customer C
JOIN address A
USING (address_id)
JOIN city CI
USING (city_id)
JOIN country CO
USING (country_id)
WHERE CO.country = "Canada";

-- 6) Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT FA.actor_id, FA.film_id
FROM film_actor FA
JOIN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
) AS prolific_actor ON FA.actor_id = prolific_actor.actor_id;


-- 7) Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT C.customer_id, CONCAT(C.first_name, ' ', C.last_name) AS Name
FROM customer C
JOIN (
    SELECT customer_id, COUNT(payment_id) AS total_payments
    FROM payment 
    GROUP BY customer_id
    ORDER BY total_payments DESC
    LIMIT 1
) AS most_profitable_customer ON C.customer_id = most_profitable_customer.customer_id;

-- 8) Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_amount_spent)
    FROM (
        SELECT customer_id, SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS subquery
)
ORDER BY total_amount_spent DESC;
