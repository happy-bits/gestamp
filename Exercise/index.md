# Index

*Purpose: speed test. Use index to speedup queries.*

Indexes are used to retrieve data from the database more quickly than otherwise. The users cannot see the indexes, they are just used to speed up searches/queries.

Simply put, an index is a pointer to data in a table. An index in a database is very similar to an index in the back of a book.

For example, if you want to reference all pages in a book that discusses a certain topic, you first refer to the index, which lists all the topics alphabetically and are then referred to one or more specific page numbers.

An index helps to speed up SELECT queries and WHERE clauses, but it slows down data input, with the UPDATE and the INSERT statements. Indexes can be created or dropped with no effect on the data.

Indexes can also be unique, like the UNIQUE constraint, in that the index prevents duplicate entries in the column or combination of columns on which there is an index.

You should avoid using index if the table is updated a lot or if the column contains a lot of NULL values.

https://www.w3schools.com/sql/sql_create_index.asp
https://www.tutorialspoint.com/sql/sql-indexes.htm

## Setup database

Create the following database with a Order table containing 100.000 rows

	-- Create new database

	USE MASTER
	EXEC HAPPYBITS.RECREATE 'Demo'
	GO
	USE Demo
	GO

	-- Helpfunction to create e random date

	CREATE OR ALTER PROCEDURE RandomDate
	@Result SMALLDATETIME OUTPUT
	as
	BEGIN
		DECLARE @FromDate DATETIME2(0)
		DECLARE @ToDate   DATETIME2(0)

		SET @FromDate = '2021-01-01' 
		SET @ToDate = '2022-01-01'

		DECLARE @Seconds INT = DATEDIFF(SECOND, @FromDate, @ToDate)
		DECLARE @Random INT = ROUND(((@Seconds-1) * RAND()), 0)

		SET @Result = (SELECT DATEADD(SECOND, @Random, @FromDate))

	END
	GO

	-- Create the table Order

	CREATE TABLE Orders(Id INT NOT NULL, CreatedDate DATETIME, Status TINYINT, CampaignCode VARCHAR(10), TotalAmount DECIMAL)
	GO

	-- Fill the table with 100.000 rows

	DECLARE @i int = 0

	DECLARE @CreatedDate SMALLDATETIME

	WHILE @i < 100000 BEGIN

		EXEC RandomDate @CreatedDate OUTPUT

		INSERT INTO Orders
		VALUES (
			@i, 
			@CreatedDate, 
			FLOOR(RAND()*5), 
			CASE(SELECT FLOOR(RAND()*10))
				WHEN 0 THEN 'ABC-123'
				WHEN 1 THEN 'WER-456'
				WHEN 2 THEN 'BBB-777'
			END,
			FLOOR(RAND()*1000)+50
			) 

		SET @i = @i + 1
	END
	GO

	-- Show the content of the table

	SELECT * FROM Orders

## Exercise: measure with GROUP BY

Run this script three times and note the difference. Calculate the median value of "elapsed time".

	SET STATISTICS TIME ON
		SELECT COUNT(*) 
		FROM Orders
		GROUP BY CampaignCode
	SET STATISTICS TIME OFF

## Exercise: measure with WHERE

Do the same with this script

	SET STATISTICS TIME ON
		SELECT COUNT(*) 
		FROM Orders
		WHERE CampaignCode='ABC-123' OR CampaignCode='WER-456'
	SET STATISTICS TIME OFF

## Exercise: measure with ORDER BY

Do the same with this script

	SET STATISTICS TIME ON
		SELECT TOP 10 *
		FROM Orders
		ORDER BY CampaignCode
	SET STATISTICS TIME OFF

## Hint

To run a script five times, end the script with

	GO 5

## Exercise: add index and measure again 

Add an index to increase performance

	CREATE INDEX IX_TEST ON Orders(CampaignCode) 

Run the scripts again and notice the difference in speed. How many times faster will the query be using an index?

## Exercise: measure adding rows

Measure the time to add 100.000, 200.000 and 300.000 rows with or without index

Compare and see if it takes longer time with an index.
