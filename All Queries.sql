CREATE TABLE PIZZA_SALES (
	   pizza_id INT PRIMARY KEY,
	   order_id INT,
	   pizza_name_id TEXT,
	   quantity INT,
	   order_date DATE,
	   order_time TIME,
	   unit_price NUMERIC(10,2),
	   total_price NUMERIC(10,2),
	   pizza_size VARCHAR(20),
	   pizza_category VARCHAR(20),
	   pizza_ingredients TEXT,
	   pizza_name TEXT
);

SELECT * FROM PIZZA_SALES;

-- KPI
-- 1. TOTAL REVENUE

SELECT SUM(Total_price) AS Total_Revenue
FROM PIZZA_SALES;

-- 2. Total Pizzas Sold

SELECT SUM(quantity) AS Total_pizzas_sold
FROM PIZZA_SALES;

-- 3. Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM PIZZA_SALES;

-- 4. Average Order Value

SELECT Round(Round(SUM(Total_price),2) / Round(COUNT(DISTINCT Order_id),2),2) AS Avg_order_value
FROM PIZZA_SALES;

-- 5. Average Pizzas Per_Order

SELECT Round(Round(SUM(quantity),2) / Round(COUNT(DISTINCT Order_id),2),2) AS Average_pizzas_per_order
FROM PIZZA_SALES;

-- VISUALS 
-- 1. Daily Trend for Total Order

SELECT TO_CHAR( Order_date, 'DAY') AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY TO_CHAR( Order_date, 'DAY');

-- 2. Monthly Trend for Orders

SELECT TO_CHAR( Order_date, 'MONTH') AS order_day, 
COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY TO_CHAR( Order_date, 'MONTH');

-- 3. Sales % by Pizza Category

SELECT pizza_category, 
Round(SUM(total_price),2) as total_revenue,
Round(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;


-- 4. Sales % by Pizza Size

SELECT pizza_size, 
Round(SUM(total_price),2) AS Total_revenue,
Round(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales),2) AS PCT 
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- 5. Total Pizza sold by Pizza Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- 6. Top 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 7. Bottom 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- 8. Top 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- 9. Bottom 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

-- 10. Top 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

-- 11. Bottom 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

