USE SAKILA;
-- 1
SELECT first_name FROM actor WHERE first_name = "Scarlett" ;

-- 2
SELECT last_name FROM actor WHERE last_name = "Johansson";

-- 3
SELECT * FROM rental;
SELECT COUNT(inventory_id) FROM rental;
SELECT COUNT(inventory_id) FROM rental
WHERE rental_date <= return_date;

-- 4
SELECT COUNT(rental_date) FROM rental;

-- 5
SELECT * FROM rental
WHERE return_date = (SELECT MIN(return_date) FROM rental);
SELECT * FROM rental
WHERE return_date = (SELECT MAX(return_date) FROM rental);

-- 6
SELECT length as min_duration FROM film 
WHERE length = (SELECT MIN(length) FROM film);
SELECT length as max_duration FROM film 
WHERE length = (SELECT MAX(length) FROM film);

-- 7
SELECT AVG(length) as Avg_length FROM film;

-- 8
SELECT (AVG(length)/60) AS average_duration
FROM film;
SELECT SEC_TO_TIME(1.9212 * 3600) AS average_duration
FROM film limit 1;

-- 9
SELECT * FROM FILM WHERE length>= 180;

-- 10
SELECT first_name,last_name, email  FROM staff;

-- 11
SELECT MAX(LENGTH(title)) AS longest_title_length
FROM film;
SELECT title
FROM film
WHERE LENGTH(title) = (SELECT MAX(LENGTH(title)) FROM film);