/* 
   --------------------
   Case Study Questions
   --------------------
*/

-- Get topping names for each recipe
SELECT
	tl.pizza_id
   ,tl.topping_id
   ,pt.topping_name
FROM (SELECT
		t.pizza_id
	   ,TRIM(value) AS topping_id
	FROM (SELECT
			p.[pizza_id]
		   ,CAST(p.toppings AS VARCHAR(50)) AS vtoppings
		FROM [CaseStudy2].[pizza_recipes] p) t
	CROSS APPLY STRING_SPLIT(t.vtoppings, ',')) tl
INNER JOIN CaseStudy2.pizza_toppings pt
	ON tl.topping_id = pt.topping_id

/*
A. Pizza Metrics
    1. How many pizzas were ordered? 
    2. How many unique customer orders were made? 
    3. How many successful orders were delivered by each runner? 
    4. How many of each type of pizza was delivered? 
    5. How many Vegetarian and Meatlovers were ordered by each customer? 
    6. What was the maximum number of pizzas delivered in a single order? 
    7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes? 
    8. How many pizzas were delivered that had both exclusions and extras? 
    9. What was the total volume of pizzas ordered for each hour of the day? 
    10. What was the volume of orders for each day of the week? 
*/

-- 1. How many pizzas were ordered? 
SELECT
	COUNT(order_id) AS order_count
FROM CaseStudy2.customer_orders


-- 2. How many unique customer orders were made? 
SELECT
	COUNT(DISTINCT order_id) AS order_count
FROM CaseStudy2.customer_orders


-- 3. How many successful orders were delivered by each runner?
SELECT
	runner_id
   ,COUNT(order_id) AS delivered_orders
FROM CaseStudy2.runner_orders
WHERE (cancellation IS NULL)
GROUP BY runner_id

