USE sakila;
-- 1) Get number of monthly active customers.

-- SEPARO DATE
create or replace view customer_activity as
select customer_id, payment_id, convert(payment_date, date) as Activity_date,
date_format(convert(payment_date, date), '%M') as activity_month,
date_format(convert(payment_date, date), '%m') as activity_month_number,
date_format(convert(payment_date, date), '%Y') as activity_year
from payment;

-- CONTROL
select * from customer_activity;

-- BUSCO LA CANTIDAD DE CUSTOMERS MENSUALES 

create or replace view monthly_active_customer as
select activity_year, activity_month_number, COUNT(DISTINCT(customer_id)) as active_customer
FROM customer_activity GROUP BY  activity_year, activity_month_number;

-- CONTROL
select * from monthly_active_customer;

-- 2) Active users in the previous month.
with cte_activity as (
  select active_customer, lag(active_customer,1) over (ORDER BY Activity_year, activity_month_number) as last_month, Activity_year, Activity_month_number
  from monthly_active_customer
)
SELECT * FROM cte_activity;


-- 3) Percentage change in the number of active customers.

with cte_activity_percentage as (
  select active_customer, lag(active_customer,1) over (ORDER BY Activity_year, activity_month_number) as last_month, Activity_year, Activity_month_number
  from monthly_active_customer
)
select *, ((active_customer - last_month)/active_customer) * 100 AS percentage
FROM cte_activity_percentage
WHERE last_month IS NOT NULL;

-- 4 Retained customers every month.

drop view if exists customer_retained;
create view customer_retained as 
select 
   CA1.Activity_year,
   CA1.Activity_month_number,
   count(distinct CA1.customer_id) as Retained_customers
   from customer_activity as CA1
join customer_activity as CA2
on CA1.customer_id = CA2.customer_id 
and CA1.Activity_month_number = CA2.Activity_month_number + 1 
group by CA1.Activity_year, CA1.Activity_month_number
order by CA1.Activity_year, CA1.Activity_month_number;

select * from customer_retained;
