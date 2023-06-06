USE sakila; 

-- 1,2 --
CREATE TABLE rentals_may AS
SELECT *
FROM rental
WHERE MONTH(rental_date) = 5;

-- 3, 4 --
CREATE TABLE rentals_jun AS
SELECT *
FROM rental
WHERE MONTH(rental_date) = 6;

-- 5 -- 
SELECT customer_id, COUNT(rental_id) AS num_rentals
FROM rentals_may
GROUP BY customer_id
ORDER BY num_rentals DESC;

-- 6 --
SELECT customer_id, COUNT(rental_id) AS num_rentals
FROM rentals_jun
GROUP BY customer_id
ORDER BY num_rentals DESC;

-- 7 -- CODIGO DE PYTHON 
/*
 from sqlalchemy import create_engine 
import pandas as pd
import getpass  
password = getpass.getpass
 */
 -- 8 --
 /*
 connection_string = 'mysql+pymysql://root:' + password + '@localhost/sakila' 
engine = create_engine(connection_string) 
data_may = pd.read_sql_query('SELECT customer_id, COUNT(rental_id) AS num_rentals FROM rentals_may GROUP BY customer_id ORDER BY num_rentals DESC', engine) 
data_may
*/

-- 9 --
/* 
engine.execute("USE sakila")
query = 'SELECT customer_id, COUNT(rental_id) AS num_rentals \
FROM rentals_jun \
GROUP BY customer_id \
ORDER BY num_rentals DESC;'
data_jun = pd.read_sql_query(query, engine)
data_jun.head()
*/

-- 10 -- 
SELECT m.customer_id, COUNT(m.rental_id) AS num_rentals_may, COUNT(j.rental_id) AS num_rentals_jun
FROM rentals_may m
INNER JOIN rentals_jun j
ON m.customer_id = j.customer_id
GROUP BY m.customer_id, j.customer_id
ORDER BY num_rentals_may DESC, num_rentals_jun DESC;


-- OTRA FORMA DE RESOLVERLO -- 
SELECT customer_id,
    CASE
        WHEN num_rentals_jun > num_rentals_may THEN 'More'
        WHEN num_rentals_jun < num_rentals_may THEN 'Less'
        ELSE 'Equal'
    END AS comparison_result
FROM (
    SELECT m.customer_id, COUNT(m.rental_id) AS num_rentals_may, COUNT(j.rental_id) AS num_rentals_jun
    FROM rentals_may m
    INNER JOIN rentals_jun j ON m.customer_id = j.customer_id
    GROUP BY m.customer_id
) AS rental_counts;

