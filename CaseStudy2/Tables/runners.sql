CREATE TABLE CaseStudy2.runners (
	[runner_id] INT NULL
   ,[registration_date] DATE NULL
);
GO

INSERT INTO
	CaseStudy2.runners ("runner_id", "registration_date")
	VALUES (1, '2021-01-01')
		  ,(2, '2021-01-03')
		  ,(3, '2021-01-08')
		  ,(4, '2021-01-15');

