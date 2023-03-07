CaseStudy1CREATE TABLE CaseStudy1.sales (
	[customer_id] VARCHAR(1) NULL
   ,[order_date] DATE NULL
   ,[product_id] INT NULL
);
GO

INSERT INTO
	CaseStudy1.sales ("customer_id", "order_date", "product_id")
	VALUES ('A', '2021-01-01', '1')
		  ,('A', '2021-01-01', '2')
		  ,('A', '2021-01-07', '2')
		  ,('A', '2021-01-10', '3')
		  ,('A', '2021-01-11', '3')
		  ,('A', '2021-01-11', '3')
		  ,('B', '2021-01-01', '2')
		  ,('B', '2021-01-02', '2')
		  ,('B', '2021-01-04', '1')
		  ,('B', '2021-01-11', '1')
		  ,('B', '2021-01-16', '3')
		  ,('B', '2021-02-01', '3')
		  ,('C', '2021-01-01', '3')
		  ,('C', '2021-01-01', '3')
		  ,('C', '2021-01-07', '3');