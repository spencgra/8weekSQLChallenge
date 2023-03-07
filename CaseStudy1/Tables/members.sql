CREATE TABLE CaseStudy1.members (
	[customer_id] VARCHAR(1) NULL
   ,[join_date] DATE NULL
);
GO

INSERT INTO
	CaseStudy1.members ("customer_id", "join_date")
	VALUES ('A', '2021-01-07')
		  ,('B', '2021-01-09');