USE sakila;

-- 1 --  Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, RANK () OVER (ORDER BY length DESC) AS 'rank_length' 
FROM film
WHERE length IS NOT NULL AND length <> 0;

-- 2 -- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS 'rank_length'
FROM film
WHERE length IS NOT NULL AND length <> 0;

-- 3 -- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT * FROM category;

SELECT C.name AS name_category, COUNT(f.film_id) 
FROM film_category f
JOIN  category c
ON c.category_id = f.category_id
GROUP BY C.name;

-- 4 -- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT a.first_name , a.last_name, count(f.film_id) AS count_films
FROM actor a
JOIN film_actor f 
ON a.actor_id = f.actor_id
GROUP BY a.first_name , a.last_name
ORDER BY count(f.film_id) DESC
LIMIT 1;

-- 5 -- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS count_Rental
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY COUNT(r.rental_id) DESC
LIMIT 1;

-- BONUS -- -- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

SELECT f.title, COUNT(r.rental_id) AS count_rental
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title 
ORDER BY COUNT(r.rental_id) DESC
LIMIT 1;
