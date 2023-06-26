USE sakila;
-- 1) List each pair of actors that have worked together.
SELECT CONCAT(a.first_name, " ", a.last_name) AS Name, CONCAT(a2.first_name, " ", a2.last_name)  AS Name_2 
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2
ON fa1.actor_id <> fa2.actor_id AND fa1.film_id = fa2.film_id
JOIN sakila.actor a
ON fa1.actor_id = a.actor_id
JOIN sakila.actor a2
ON fa2.actor_id = a2.actor_id;

-- 2) For each film, list actor that has acted in more films.

SELECT FA.film_id, FA.actor_id
FROM (
    SELECT film_id, actor_id, 
           ROW_NUMBER() OVER (PARTITION BY film_id ORDER BY COUNT(*) DESC) AS actor_rank
    FROM film_actor
    GROUP BY film_id, actor_id
) AS FA
WHERE FA.actor_rank = 1;