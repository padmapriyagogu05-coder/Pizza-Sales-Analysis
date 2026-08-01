use my_practice;
select sum(total_price) as Total_Revenue
from pizzasales12;
2.select count(*)  from  pizzasales12;
3. Average order value 
select(sum(total_price)/count(distinct  order_id))as Avg_order_Value from pizzasales12;
4.Total pizzas sold
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizzasales12;

5.Total orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
6. Average pizzas per order
SELECT CAST(SUM(quantity) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order 
FROM pizzasales12;
B.Trends queries
1.daily trend queries 
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizzasales12
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;
describe pizzasales12;
2.
set sql_safe_updates = 0;
UPDATE pizzasales12 SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
UPDATE pizzasales12 SET order_time = STR_TO_DATE(order_time, '%H:%i:%s');
ALTER TABLE pizzasales12 MODIFY order_date DATE;
ALTER TABLE pizzasales12 MODIFY order_time TIME;
set  sql_safe_updates = 1;

ALTER TABLE pizzasales12 MODIFY pizza_name_id VARCHAR(50);
select order_date from pizzasales12 limit 20;
ALTER TABLE pizzasales12 MODIFY pizza_size VARCHAR(10);
ALTER TABLE pizzasales12 MODIFY pizza_category VARCHAR(50);
ALTER TABLE pizzasales12 MODIFY pizza_name VARCHAR(100);
# hourly trend
SELECT 
    HOUR(order_time) AS order_hours, 
    COUNT(distinct  order_id) AS total_orders
FROM pizzasales12
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);
# % of sales by pizza category
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizzasales12) AS DECIMAL(10,2)) AS PCT
FROM pizzasales12
GROUP BY pizza_category;
# % of sales by pizza size

SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizzasales12) AS DECIMAL(10,2)) AS PCT
FROM pizzasales12
GROUP BY pizza_size
ORDER BY pizza_size;

-- F. Total Pizzas Sold by Pizza Category
SELECT 
    pizza_category, 
    SUM(quantity) AS Total_Quantity_Sold
FROM pizzasales12
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;
-- G. Top 5 Best Sellers by Total Pizzas Sold
SELECT 
    pizza_name, 
    SUM(quantity) AS Total_Pizza_Sold
FROM pizzasales12
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- H. Bottom 5 Best Sellers by Total Pizzas Sold
SELECT 
    pizza_name, 
    SUM(quantity) AS Total_Pizza_Sold
FROM pizzasales12
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;









