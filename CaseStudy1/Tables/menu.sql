CREATE TABLE CaseStudy1.menu (
	[product_id] INT NULL
   ,[product_name] VARCHAR(5) NULL
   ,[price] INT NULL
);
GO

INSERT INTO
	CaseStudy1.menu ("product_id", "product_name", "price")
	VALUES ('1', 'sushi', '10')
		  ,('2', 'curry', '15')
		  ,('3', 'ramen', '12');