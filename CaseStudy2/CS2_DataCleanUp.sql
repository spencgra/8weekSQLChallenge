-- Cleanup data tables for Case Study 2


-- CaseStudy2.customer_orders

-- exclusions : 
--              Update blanks and change to NULL
--              Update 'null' and change to NULL
--

UPDATE CaseStudy2.customer_orders
SET exclusions = NULL
WHERE exclusions = ''

UPDATE CaseStudy2.customer_orders
SET exclusions = NULL
WHERE exclusions = 'null'


-- extras : 
--              Update blanks and change to NULL
--              Update 'null' and change to NULL

UPDATE CaseStudy2.customer_orders
SET extras = NULL
WHERE extras = ''

UPDATE CaseStudy2.customer_orders
SET extras = NULL
WHERE extras = 'null'

-- *********************************************************************************

-- CaseStudy2.runner_orders

-- pickup_time : 
--               Update 'null' and change to NULL
--               Change datatype to DATETIME

UPDATE CaseStudy2.runner_orders
SET pickup_time = NULL
WHERE pickup_time = 'null';

ALTER TABLE CaseStudy2.runner_orders
ADD tempCol DATETIME;

UPDATE CaseStudy2.runner_orders
SET tempCol = CAST(CaseStudy2.runner_orders.pickup_time AS DATETIME)

ALTER TABLE CaseStudy2.runner_orders
DROP COLUMN pickup_time;

ALTER TABLE CaseStudy2.runner_orders
ADD pickup_time DATETIME;

UPDATE CaseStudy2.runner_orders
SET pickup_time = tempCol;

ALTER TABLE CaseStudy2.runner_orders
DROP COLUMN tempCol;


-- distance : 
--               Update 'null' and change to NULL

UPDATE CaseStudy2.runner_orders
SET distance = NULL
WHERE distance = 'null'


-- duration : 
--               Update 'null' and change to NULL

UPDATE CaseStudy2.runner_orders
SET duration = NULL
WHERE duration = 'null'


-- cancellation : 
--               Update 'null' and change to NULL
--               Update blanks and change to NULL

UPDATE CaseStudy2.runner_orders
SET cancellation = NULL
WHERE cancellation = 'null'

UPDATE CaseStudy2.runner_orders
SET cancellation = NULL
WHERE cancellation = ''

-- *********************************************************************************

-- CaseStudy2.pizza_recipes
--
--               Create new table to normalize the data

SELECT
	* INTO CaseStudy2.pizza_recipes_new
FROM (SELECT
		t.pizza_id
	   ,TRIM(value) AS topping_id
	FROM (SELECT
			p.[pizza_id]
		   ,CAST(p.toppings AS VARCHAR(50)) AS vtoppings
		FROM [CaseStudy2].[pizza_recipes] p) t
	CROSS APPLY STRING_SPLIT(t.vtoppings, ',')) nr

-- *********************************************************************************

-- CaseStudy2.order_exclusions
--
--               Create new exclusions table to normalize the data

SELECT
	* INTO CaseStudy2.c_order_exclusions
FROM (SELECT DISTINCT
		t.order_id
	   ,t.pizza_id
	   ,TRIM(value) AS topping_id
	FROM (SELECT
			o.order_id
		   ,o.pizza_id
		   ,CAST(o.exclusions AS VARCHAR(50)) AS vtoppings
		FROM CaseStudy2.customer_orders o) t
	CROSS APPLY STRING_SPLIT(t.vtoppings, ',')) nr

-- *********************************************************************************

-- CaseStudy2.order_extras
--
--               Create new extras table to normalize the data

SELECT
	* INTO CaseStudy2.c_order_extras
FROM (SELECT DISTINCT
		t.order_id
	   ,t.pizza_id
	   ,TRIM(value) AS topping_id
	FROM (SELECT
			o.order_id
		   ,o.pizza_id
		   ,CAST(o.extras AS VARCHAR(50)) AS vtoppings
		FROM CaseStudy2.customer_orders o) t
	CROSS APPLY STRING_SPLIT(t.vtoppings, ',')) nr