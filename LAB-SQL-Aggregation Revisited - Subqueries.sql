USE sakila; 

-- Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT C.First_name, C.last_name, c.email 
FROM customer C
JOIN rental R
USING (customer_id)
GROUP BY C.First_name, C.last_name, c.email;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT C.customer_id, CONCAT(C.First_name, ' ', C.last_name) AS full_name, ROUND(AVG(P.amount), 2) AS average_amount
FROM customer C
JOIN payment P
ON C.customer_id = P.customer_id
GROUP BY C.customer_id, full_name;

-- Select the name and email address of all the customers who have rented the "Action" movies.
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email, cat.name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';

/*Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of 
payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is
more than 4, then it should be high.*/

SELECT 
    *,
    CASE 
        WHEN amount BETWEEN 0 AND 2 THEN 'Low'
        WHEN amount BETWEEN 2 AND 4 THEN 'Medium'
        WHEN amount > 4 THEN 'High'
    END AS label
FROM payment;
