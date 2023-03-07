CREATE TABLE CaseStudy2.pizza_toppings (
	[topping_id] INT NULL
   ,[topping_name] TEXT NULL
);
GO

INSERT INTO
	CaseStudy2.pizza_toppings ("topping_id", "topping_name")
	VALUES (1, 'Bacon')
		  ,(2, 'BBQ Sauce')
		  ,(3, 'Beef')
		  ,(4, 'Cheese')
		  ,(5, 'Chicken')
		  ,(6, 'Mushrooms')
		  ,(7, 'Onions')
		  ,(8, 'Pepperoni')
		  ,(9, 'Peppers')
		  ,(10, 'Salami')
		  ,(11, 'Tomatoes')
		  ,(12, 'Tomato Sauce');