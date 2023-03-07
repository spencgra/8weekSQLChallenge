CREATE TABLE CaseStudy2.pizza_recipes (
	[pizza_id] INT NULL
   ,[toppings] TEXT NULL
);
GO

INSERT INTO
	CaseStudy2.pizza_recipes ("pizza_id", "toppings")
	VALUES (1, '1, 2, 3, 4, 5, 6, 8, 10')
		  ,(2, '4, 6, 7, 9, 11, 12');