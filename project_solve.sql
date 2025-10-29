CREATE DATABASE PIZZA;
use pizza;

SELECT * FROM PIZZAS;
SELECT * FROM PIZZA_TYPES;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_DETAILS;
  -- Basic:
-- 1. Retrieve the total number of orders placed.
SELECT COUNT(ORDER_ID) AS TOTAL_ORDERS FROM ORDERS;

-- 2. Calculate the total revenue generated from pizza sales
SELECT (COUNT(DISTINCT ORDER_ID)) AS TOTAL_ORDERS FROM ORDER_DETAILS;

-- 3. Identify the highest-priced pizza.
SELECT SUM(OD.QUANTITY * P.PRICE) AS TOTAL_REVENUE 
FROM ORDER_DETAILS OD
JOIN PIZZAS P ON OD.PIZZA_ID = P.PIZZA_ID;

-- 4. Identify the most common pizza size ordered.
SELECT p.size, COUNT(*) AS order_count
FROM orders o
JOIN pizzas p ON o.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;


SELECT p.size, COUNT(*) AS order_count
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;



-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name AS pizza_type, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;



-- Intermediate:
-- 6. Join the necessary tables to find the total quantity of each pizza category ordered
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 7. Determine the distribution of orders by hour of the day.
SELECT HOUR(o.date) AS order_hour, COUNT(*) AS order_count
FROM orders o
GROUP BY order_hour
ORDER BY order_hour;


-- 8. Join relevant tables to find the category-wise distribution of pizzas.
SELECT pt.category, COUNT(*) AS pizza_count
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;


-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT DATE(o.date) AS order_date, AVG(od.quantity) AS avg_pizzas_ordered
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
GROUP BY order_date
ORDER BY order_date;

-- 10. Determine the top 3 most ordered pizza types based on revenue.
SELECT pt.name AS pizza_type, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


-- Advanced:
-- 11. Calculate the percentage contribution of each pizza type to total revenue.
-- 12. Analyze the cumulative revenue generated over time.
-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT 
    pt.category,
    pt.name AS pizza_type,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, pt.name
ORDER BY pt.category, total_revenue DESC;

