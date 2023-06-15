USE sakila;
-- 1) List the number of films per category.
SELECT c.category_id AS Category , COUNT(f.film_id) AS number_films
FROM film_category c 
JOIN film f
ON c.film_id=f.film_id
GROUP BY c.category_id
ORDER BY number_films;

-- 2) Display the first and the last names, as well as the address, of each staff member.
SELECT  s.first_name, s.last_name, a.address 
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

-- 3) Display the total amount rung up by each staff member in August 2005.
SELECT  s.staff_id, s.first_name, s.last_name, SUM(p.amount) as Total_amount
FROM staff s
JOIN payment p
ON s.staff_id=p.staff_id
WHERE p.payment_date like '2005-08-%'
GROUP BY s.staff_id, s.first_name, s.last_name;

-- 4) List all films and the number of actors who are listed for each film.
SELECT f.title as TITLE, COUNT(a.actor_id) AS NUMBER_ACTORS
FROM actor a
JOIN film_actor fa
ON a.actor_id=fa.actor_id
JOIN film f
ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY f.title;

-- 5) Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
SELECT c.last_name , c.first_name,  SUM(p.amount) AS total_amount
FROM customer c 
JOIN  payment p
ON c.customer_id=p.customer_id
GROUP BY  c.first_name, c.last_name
ORDER BY c.last_name;
