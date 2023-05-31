
USE sakila;

-- 1 --
-- Conteo sin primer nombre
SELECT last_name, COUNT(*) as count
FROM actor
GROUP BY last_name
HAVING count = 1;

-- conteo agregando primer nombre en la query. 
SELECT first_name, last_name
FROM actor
WHERE last_name IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(first_name) = 1)
    ORDER BY first_name;


-- 2 --
-- contador de veces que se repite cada apellido.
SELECT last_name, COUNT(*) as count
FROM actor
GROUP BY last_name
HAVING count > 1;

-- lista con nombre y apellido.
SELECT first_name, last_name
FROM actor
WHERE last_name IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(first_name) > 1)
    ORDER BY last_name;
    
-- 3 --
SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id;

-- 4 --
SELECT release_year, count(film_id)
FROM film
GROUP BY release_year;

-- 5 -- 
SELECT rating, COUNT(film_id) AS count_films
FROM film 
GROUP BY rating;

-- 6 --
SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating;

-- 7 -- 
SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120;