USE BANK;
-- Query 1

SELECT client_id FROM client
WHERE district_id = 1
ORDER BY client_id 
LIMIT 5;

-- Query 2

SELECT client_id FROM client
WHERE district_id = 72
ORDER BY client_id desc
LIMIT 1;

-- Query 3

SELECT amount FROM loan
ORDER BY amount 
LIMIT 3;

-- Query 4

SELECT distinct(status) FROM loan
ORDER BY status;

-- Query 5
-- What is the loan_id of the highest payment received in the loan table?

SELECT loan_id FROM loan
ORDER BY PAYMENTS 
LIMIT 1;

-- Query 6

SELECT account_id, amount FROM loan
ORDER BY account_id
LIMIT 5;

-- Query 7

SELECT account_id FROM loan
WHERE duration = 60
ORDER BY amount
LIMIT 5;

-- Query 8

SELECT distinct(k_symbol) FROM bank.order
WHERE k_symbol IS NOT NULL AND trim(k_symbol) <> ' '
ORDER BY k_symbol; 

-- Query 9

SELECT order_id FROM bank.order
WHERE account_id = 34;

-- Query 10

SELECT distinct (account_id) FROM bank.order
WHERE order_id BETWEEN 29540 and 29560;

-- Query 11

SELECT amount FROM bank.order
WHERE account_to = 30067122;

-- Query 12

SELECT trans_id, date, type, amount FROM trans
WHERE account_id = 793
ORDER BY DATE DESC
LIMIT 10;

-- Query 13

SELECT district_id, COUNT(*) AS number_of_clients
FROM client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id ASC;

-- Query 14

SELECT type, count(*) as number_of_cards
FROM CARD
GROUP BY type;

-- Query 15

SELECT account_id, SUM(amount) FROM loan
GROUP BY account_id
ORDER BY SUM(amount) DESC
LIMIT 10;

-- Query 16

SELECT DATE, COUNT(*) 
FROM loan
WHERE DATE < 930907
GROUP BY date
ORDER BY DATE DESC; 

-- Query 17

SELECT distinct(date) as fecha , duration, count(*) AS number_of_loans FROM loan
WHERE date LIKE '9712%'
GROUP BY fecha, duration
ORDER BY fecha, duration; 
-- LIMIT 14; si le agrego este limit al codigo la respuesta me queda igual que el resultado esperado en el lab. pero la consigna no lo pide. 

-- Query 18

SELECT account_id, type, SUM(AMOUNT) AS total_amount
FROM trans
WHERE account_id = 396
GROUP BY account_id , type;

-- Query 19

SELECT account_id, 
CASE WHEN type = 'PRIJEM' THEN 'INCOMING'
     WHEN type = 'VYDAJ' THEN 'OUTGOING'
     END AS type_modified,
FLOOR(SUM(AMOUNT)) AS total_amount
FROM trans
WHERE account_id = 396
GROUP BY account_id , type;

-- Query 20
SELECT account_id,
    round(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END)) AS total_incoming,
    round(SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END)) AS total_outgoing,
    round(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) - SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END)) AS difference
FROM 
    bank.trans
WHERE 
    account_id = 396;

-- Query 21
SELECT account_id,
    round(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) - SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END)) AS difference
FROM 
    bank.trans
GROUP BY account_id
ORDER BY difference DESC
LIMIT 10