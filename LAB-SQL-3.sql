USE sakila;
-- 1
SELECT count(distinct(last_name)) 
FROM actor;

-- 2
SELECT distinct(original_language_id) 
FROM FILM;
SELECT * FROM FILM;

-- 3
SELECT count(rating) 
FROM film 
WHERE rating = 'PG-13'; 

-- 4
SELECT * 
FROM FILM
WHERE release_year='2006'
ORDER BY length DESC
LIMIT 10;

-- 5
SELECT * FROM payment;
SELECT DATEDIFF(MAX(payment_date), MIN(payment_date)) AS days_operating
FROM PAYMENT;

-- 6
SELECT * FROM rental;
SELECT *, MONTH(rental_date) AS month, WEEKDAY(rental_date) AS weekday
FROM rental
LIMIT 20;

-- 7
SELECT *, 
  CASE 
    WHEN WEEKDAY(rental.rental_date) IN (5, 6) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental
LIMIT 20;

-- 8
SELECT * FROM rental
ORDER BY rental_date DESC;

SELECT COUNT(rental_date) FROM rentaL
WHERE rental_date LIKE '2006-02-%';	
