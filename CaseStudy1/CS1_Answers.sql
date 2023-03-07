/* 
   --------------------
   Case Study Questions
   --------------------
*/

    -- 1. What is the total amount each customer spent at the restaurant?
    -- 2. How many days has each customer visited the restaurant?
    -- 3. What was the first item from the menu purchased by each customer?
    -- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
    -- 5. Which item was the most popular for each customer?
    -- 6. Which item was purchased first by the customer after they became a member?
    -- 7. Which item was purchased just before the customer became a member?
    -- 8. What is the total items and amount spent for each member before they became a member?
    -- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
    -- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


-- 1. What is the total amount each customer spent at the restaurant?
SELECT
	s.customer_id
   ,SUM(m.price) AS TotalCost
FROM CaseStudy1.sales s
LEFT OUTER JOIN CaseStudy1.menu m
	ON s.product_id = m.product_id
GROUP BY s.customer_id;


-- 2. How many days has each customer visited the restaurant?
SELECT
	dsales.customer_id
   ,COUNT(dsales.order_date) AS VisitCount
FROM (SELECT DISTINCT
		s.customer_id
	   ,s.order_date
	FROM CaseStudy1.sales s) dsales
GROUP BY dsales.customer_id;

-- Write query using CTE
WITH dsales (cid, od)
AS (SELECT DISTINCT
        s.customer_id
       ,s.order_date
    FROM CaseStudy1.sales s)
SELECT
    dsales.cid
   ,COUNT(dsales.od) AS VisitCount
FROM dsales
GROUP BY dsales.cid;


-- 3. What was the first item from the menu purchased by each customer?
SELECT
	fsales.customer_id
   ,m.product_name
FROM (SELECT
		s.customer_id
	   ,MIN(s.order_date) AS minOrderDate
	   ,MIN(s.product_id) AS pid
	FROM CaseStudy1.sales s
	GROUP BY s.customer_id) fsales
JOIN CaseStudy1.menu m
	ON fsales.pid = m.product_id


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT
	m.product_name
   ,COUNT(s.customer_id) AS PurchaseCount
FROM CaseStudy1.menu AS m
INNER JOIN CaseStudy1.sales AS s
	ON m.product_id = s.product_id
GROUP BY m.product_name


-- 5. Which item was the most popular for each customer?
SELECT TOP (100) PERCENT
	s.customer_id
   ,m.product_name
   ,s.ProdCount
FROM (SELECT TOP (100) PERCENT
		customer_id
	   ,product_id
	   ,COUNT(product_id) AS ProdCount
	FROM CaseStudy1.sales
	GROUP BY customer_id
			,product_id) AS s
INNER JOIN (SELECT
		customer_id
	   ,MAX(ProdCount) AS MaxCount
	FROM (SELECT TOP (100) PERCENT
			customer_id
		   ,product_id
		   ,COUNT(product_id) AS ProdCount
		FROM CaseStudy1.sales AS sales_1
		GROUP BY customer_id
				,product_id) AS PC
	GROUP BY customer_id) AS t
	ON s.customer_id = t.customer_id
		AND s.ProdCount = t.MaxCount
INNER JOIN CaseStudy1.menu AS m
	ON s.product_id = m.product_id
ORDER BY s.customer_id



-- 6. Which item was purchased first by the customer after they became a member?
SELECT
	s.customer_id
   ,s.order_date
   ,m1.product_name
FROM CaseStudy1.sales AS s
INNER JOIN (SELECT TOP (100) PERCENT
		s1.customer_id
	   ,MIN(s1.order_date) AS OrderDate
	FROM CaseStudy1.sales AS s1
	INNER JOIN CaseStudy1.members AS m
		ON s1.customer_id = m.customer_id
		AND s1.order_date > m.join_date
	GROUP BY s1.customer_id) AS t
	ON s.customer_id = t.customer_id
		AND s.order_date = t.OrderDate
INNER JOIN CaseStudy1.menu AS m1
	ON s.product_id = m1.product_id


-- 7. Which item was purchased just before the customer became a member?
SELECT
	s.customer_id
   ,s.order_date
   ,m1.product_name
FROM CaseStudy1.sales AS s
INNER JOIN (SELECT TOP (100) PERCENT
		s1.customer_id
	   ,MAX(s1.order_date) AS OrderDate
	FROM CaseStudy1.sales AS s1
	INNER JOIN CaseStudy1.members AS M
		ON s1.customer_id = M.customer_id
		AND s1.order_date < M.join_date
	GROUP BY s1.customer_id) AS t
	ON s.customer_id = t.customer_id
		AND s.order_date = t.OrderDate
INNER JOIN CaseStudy1.menu AS m1
	ON s.product_id = m1.product_id


-- 8. What is the total items and amount spent for each member before they became a member?
SELECT
	s.customer_id
   ,COUNT(me.product_id) AS TotalOrders
   ,SUM(me.price) AS TotalCost
FROM CaseStudy1.menu AS me
INNER JOIN CaseStudy1.sales AS s
	ON me.product_id = s.product_id
LEFT OUTER JOIN CaseStudy1.members AS mb
	ON s.customer_id = mb.customer_id
WHERE (mb.join_date > s.order_date)
OR (mb.join_date IS NULL)
GROUP BY s.customer_id


-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT
	s.customer_id
   ,SUM(CASE
		WHEN m.product_name = 'sushi' THEN m.price * 20
		ELSE m.price * 10
	END) AS Points
FROM CaseStudy1.sales AS s
INNER JOIN CaseStudy1.menu AS m
	ON s.product_id = m.product_id
GROUP BY s.customer_id


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT
	s.customer_id
   ,SUM(CASE
		WHEN m.product_name = 'sushi' THEN m.price * 20
		ELSE CASE
				WHEN s.order_date >= mb.join_date THEN m.price * 20
				ELSE m.price * 10
			END
	END) AS Points
FROM CaseStudy1.sales AS s
INNER JOIN CaseStudy1.menu AS m
	ON s.product_id = m.product_id
INNER JOIN CaseStudy1.members AS mb
	ON s.customer_id = mb.customer_id
WHERE (s.order_date < CONVERT(DATETIME, '2021-02-01 00:00:00', 102))
GROUP BY s.customer_id


/*
The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.
Recreate the following table output using the available data:
customer_id 	order_date 	product_name 	price 	member
*/
SELECT
	s.customer_id
   ,s.order_date
   ,m.product_name
   ,m.price
   ,CASE
		WHEN s.order_date < mb.join_date OR
			mb.join_date IS NULL THEN 'N'
		ELSE 'Y'
	END AS member
FROM CaseStudy1.sales AS s
INNER JOIN CaseStudy1.menu AS m
	ON s.product_id = m.product_id
LEFT OUTER JOIN CaseStudy1.members AS mb
	ON s.customer_id = mb.customer_id



/*
Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.
customer_id 	order_date 	product_name 	price 	member 	ranking
A 	2021-01-01 	curry 	15 	N 	null
A 	2021-01-01 	sushi 	10 	N 	null
A 	2021-01-07 	curry 	15 	Y 	1
*/

-- *********************************   Needs some work to remove duplicates ***********************************
SELECT
	s.customer_id
   ,s.order_date
   ,m.product_name
   ,m.price
   ,CASE
		WHEN s.order_date < mb.join_date OR
			mb.join_date IS NULL THEN 'N'
		ELSE 'Y'
	END AS member
   ,t.ranking
FROM CaseStudy1.sales AS s
INNER JOIN CaseStudy1.menu AS m
	ON s.product_id = m.product_id
LEFT OUTER JOIN CaseStudy1.members AS mb
	ON s.customer_id = mb.customer_id
LEFT OUTER JOIN (SELECT
		s.customer_id
	   ,s.order_date
	   ,s.product_id
	   ,RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS ranking
	FROM CaseStudy1.sales AS s
	INNER JOIN CaseStudy1.members AS mb
		ON s.customer_id = mb.customer_id
		AND s.order_date >= mb.join_date) AS t
	ON s.customer_id = t.customer_id
		AND s.order_date = t.order_date
		AND s.product_id = t.product_id