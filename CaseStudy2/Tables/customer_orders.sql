CREATE TABLE CaseStudy2.customer_orders (
	[order_id] INT NULL
   ,[customer_id] INT NULL
   ,[pizza_id] INT NULL
   ,[exclusions] VARCHAR(4) NULL
   ,[extras] VARCHAR(4) NULL
   ,[order_time] DATETIME DEFAULT (GETDATE()) NULL
);
GO

INSERT INTO
	CaseStudy2.customer_orders ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
	VALUES ('1', '101', '1', '', '', '2020-01-01 18:05:02')
		  ,('2', '101', '1', '', '', '2020-01-01 19:00:52')
		  ,('3', '102', '1', '', '', '2020-01-02 23:51:23')
		  ,('3', '102', '2', '', NULL, '2020-01-02 23:51:23')
		  ,('4', '103', '1', '4', '', '2020-01-04 13:23:46')
		  ,('4', '103', '1', '4', '', '2020-01-04 13:23:46')
		  ,('4', '103', '2', '4', '', '2020-01-04 13:23:46')
		  ,('5', '104', '1', 'null', '1', '2020-01-08 21:00:29')
		  ,('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13')
		  ,('7', '105', '2', 'null', '1', '2020-01-08 21:20:29')
		  ,('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33')
		  ,('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59')
		  ,('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49')
		  ,('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');

