USE sakila;
-- 1
ALTER TABLE staff
DROP picture;

-- 2 
INSERT INTO staff
VALUES (3 , 'Tammy', 'Sanders', 79 , 'TAMMY.SANDERS@sakilacustomer.org', 2 ,1, 'Tammy', NULL , NOW());

-- 3
INSERT INTO rental 
VALUES (16050 , NOW(), 2 , 130 ,  NULL , 1 , NOW());
SELECT * FROM RENTAL
ORDER BY RENTAL_ID DESC;

-- 4
SELECT * FROM customer
WHERE ACTIVE=0;

-- Creación de la nueva tabla. 
CREATE TABLE deleted_users
SELECT customer_id, email, create_date
FROM customer 
WHERE active = 0;

-- Borro los usuarios inactivos ( no puedo borrarlos ya que tengo activado un modo seguro en Mysql).
DELETE FROM customer
WHERE active = 0;
