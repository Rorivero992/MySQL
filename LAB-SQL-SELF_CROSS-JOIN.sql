USE SAKILA;

-- 1 Get all pairs of actors that worked together.

SELECT CONCAT(a.first_name, " ", a.last_name) AS Name, CONCAT(a2.first_name, " ", a2.last_name)  AS Name_2 
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2
ON fa1.actor_id <> fa2.actor_id AND fa1.film_id = fa2.film_id
JOIN sakila.actor a
ON fa1.actor_id = a.actor_id
JOIN sakila.actor a2
ON fa2.actor_id = a2.actor_id;

-- 2 Get all pairs of customers that have rented the same film more than 3 times.

SELECT c.customer_id AS Customer_1, c2.customer_id AS Customer_2, COUNT() AS Films
FROM sakila.customer c
JOIN sakila.customer c2 ON c.customer_id <> c2.customer_id
JOIN sakila.rental r1 ON c.customer_id = r1.customer_id
JOIN sakila.rental r2 ON c2.customer_id = r2.customer_id
JOIN sakila.inventory i1 ON r1.inventory_id = i1.inventory_id
JOIN sakila.inventory i2 ON r2.inventory_id = i2.inventory_id
WHERE i1.film_id = i2.film_id
GROUP BY c.customer_id, c2.customer_id
HAVING COUNT() > 3
ORDER BY films DESC;

-- 3 Get all possible pairs of actors and films.
SELECT concat(a.first_name, " ", a.last_name) as Name, F.title as Film 
FROM actor A
CROSS JOIN film F;

-- PLUS 
SELECT DISTINCT concat(a.first_name, " ", a.last_name) as Name, F.title as Film 
FROM actor A
CROSS JOIN film F
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film_actor fa2 ON f.film_id=fa2.film_id
WHERE fa.film_id=fa2.film_id;
