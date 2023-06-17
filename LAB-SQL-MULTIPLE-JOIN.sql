USE sakila;
-- 1) Write a query to display for each store its store ID, city, and country.
SELECT S.store_id, C.city, CO.country
FROM store S 
JOIN address A 
ON S.address_id=A.address_id
JOIN city C 
ON A.city_id=C.city_id
JOIN country CO 
ON C.country_id=CO.country_id;

-- 2) Write a query to display how much business, in dollars, each store brought in.
SELECT S.store_id, ROUND(SUM(P.amount * 1.09),2) AS AMOUNT_DOLLAR
FROM store S 
JOIN staff ST 
ON S.store_id=ST.store_id
JOIN payment P
ON ST.staff_id=P.staff_id
GROUP BY S.store_id;

-- 3)What is the average running time of films by category?
SELECT CA.name AS CATEGORY, ROUND(AVG(F.length),2) AS AVERAGE_TIME
FROM category CA 
JOIN film_category FC
ON CA.category_id= FC.category_id
JOIN film F 
ON FC.film_id=F.film_id
GROUP BY CATEGORY;

-- 4) Which film categories are longest? (MAL INTERPRETADA LA CONSIGNA)
SELECT CA.name AS CATEGORY, ROUND(AVG(F.length),2) AS AVERAGE_TIME
FROM category CA 
JOIN film_category FC
ON CA.category_id= FC.category_id
JOIN film F 
ON FC.film_id=F.film_id
GROUP BY CATEGORY
ORDER BY AVERAGE_TIME DESC;

-- 4) Which film categories are longest? (BIEN)
SELECT CA.name AS CATEGORY, COUNT(f.film_id) AS Count_films
FROM category CA 
JOIN film_category FC
ON CA.category_id= FC.category_id
JOIN film F 
ON FC.film_id=F.film_id
GROUP BY CATEGORY
ORDER BY Count_films DESC;

-- 5) Display the most frequently rented movies in descending order.
SELECT F.film_id, F.title, COUNT(R.rental_id) AS COUNT_RENTALS
FROM film F
JOIN inventory I 
ON F.film_id=I.film_id
JOIN rental R 
ON I.inventory_id=R.inventory_id
GROUP BY F. film_id, F.title
ORDER BY COUNT_RENTALS DESC;

-- 6) List the top five genres in gross revenue in descending order.
SELECT C.name AS Name, SUM(P.amount) AS Total_amount
FROM category C 
JOIN film_category FC 
ON C.category_id=FC.category_id
JOIN inventory I
ON FC.film_id = I.film_id
JOIN rental R 
ON I.inventory_id=R.inventory_id
JOIN payment P 
ON R.rental_id=P.rental_id
GROUP BY Name 
ORDER BY Total_amount DESC;

-- 7) Is "Academy Dinosaur" available for rent from Store 1?
SELECT F.title, S.store_id AS STORE, COUNT(*) AS FILM_STOCK 
FROM film F
JOIN inventory I
ON F.film_id=i.film_id
JOIN store S 
ON I.store_id = S.store_id
WHERE F.title = "Academy Dinosaur"
GROUP BY STORE;
