SELECT * FROM pizza_order_analysis.order_details;

-- Counting the total number of orders placed.

SELECT COUNT(DISTINCT(order_details_id)) AS Total_orders
 from order_details;
 
 -- Calculate the total revenue generated from pizza sales
 
 SELECT 
 ROUND(SUM(od.quantity * pizzas.price)) AS Total_revenue_generated
 FROM order_details od
JOIN pizzas ON od.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.

SELECT pt.name, p.price
From pizza_types pt
JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
ORDER BY P.price DESC LIMIT 1;

-- Identify the most common pizza size ordered in descending order.

select pizzas.size, 
COUNT(DISTINCT (order_details_id)) AS Number_of_pizza
From order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size;

-- List the top 5 most ordered pizza types along with their quantities.


select pt.name,p.pizza_type_id, 
COUNT(DISTINCT (order_details.order_details_id)) Orders,
 SUM(order_details.quantity) AS quantity 
from pizzas p
JOIN pizza_types pt on p.pizza_type_id = pt.pizza_type_id
JOIN order_details on order_details.pizza_id = p.pizza_id
GROUP BY 1,2
ORDER BY 4 DESC LIMIT 5;

-- determining the distribution of orders by hour of the day


select time AS `hours`, order_details.order_id AS "orders"
from orders 
join order_details ON orders.order_id = order_details.order_id
GROUP BY 1,2
ORDER BY 2 desc;

-- group the orders by date and determine the average number of pizzas ordered in a day.

WITH P AS(
select o.date, SUM(od.quantity) AS sum_of_pizza
from orders o
JOIN order_details od on o.order_id = od.order_id
GROUP BY o.date
)
SELECT AVG(p.sum_of_pizza) as average_number,
MAX(p.sum_of_pizza) AS "maximum number"
from P;

-- show the top categories of most pizza ordered.

select pt.category,COUNT(DISTINCT od.order_details_id) AS Pizza_orders
from pizzas p
join order_details od on od.pizza_id = p.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
group by 1;

-- Determine the top 3 most ordered pizza types based on revenue.


select pt.name, pt.pizza_type_id, 
ROUND(SUM(od.quantity * p.price)) AS REVENUE
from pizzas p
join order_details od on od.pizza_id = p.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
group by 1,2
order by 3 DESC LIMIT 3;



