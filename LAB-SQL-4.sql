USE sakila;
select * from film;
-- 1
SELECT DISTINCT(rating) FROM film;

-- 2
SELECT DISTINCT(release_year) FROM film;

-- 3
SELECT title FROM film
WHERE title LIKE '%armageddon%';

-- 4
SELECT title FROM film
WHERE title LIKE '%APOLLO%';

-- 5
SELECT title FROM film
WHERE title LIKE '%APOLLO';

-- 6 
SELECT title FROM film
WHERE title LIKE '%DATE%';

-- 7 
SELECT title, LENGTH(title) AS LARGO FROM film
ORDER BY largo DESC 
LIMIT 10;

-- 8
SELECT title, length FROM film
ORDER BY length DESC 
LIMIT 10;

-- 9
SELECT COUNT(special_features) AS Behind_the_scenes FROM FILM 
WHERE special_features = "Behind the Scenes";

-- 10
SELECT * FROM film 
ORDER BY  release_year, title;

