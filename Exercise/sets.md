# Sets

*Purpose: learn about set operators like UNION, INTERSECT and EXCEPT*

Details:

- Set operators gives unique values (no duplicates)
- The datatypes must be comparable (e.g "text" is not comparable)

https://docs.microsoft.com/en-us/sql/t-sql/language-elements/set-operators-except-and-intersect-transact-sql?view=sql-server-ver15

Execute

	use master
	exec Happybits.Recreate 'Demo'
	use Demo

	CREATE TABLE BicycleParts (
		Produktnamn varchar(50),
		Kod INTEGER
	);

	CREATE TABLE Pieces (
		Code INTEGER,
		Name varchar(50) 
	);
	
	INSERT INTO BicycleParts(Produktnamn, Kod) VALUES('Sprocket', 5);      -- kugghjul
	INSERT INTO BicycleParts(Produktnamn, Kod) VALUES('Wheel', 6);         -- hjul
	INSERT INTO BicycleParts(Produktnamn, Kod) VALUES('Saddle', 7);        -- sadel
	INSERT INTO BicycleParts(Produktnamn, Kod) VALUES('Bike spokes', 8);   -- ekrar

	INSERT INTO Pieces(Code, Name) VALUES(100,'Apple'); 
	INSERT INTO Pieces(Code, Name) VALUES(6,'Wheel'); 
	INSERT INTO Pieces(Code, Name) VALUES(7,'Saddle'); 
	INSERT INTO Pieces(Code, Name) VALUES(200,'Banana'); 


List the content of the tables:

	SELECT * FROM BicycleParts
	SELECT * FROM Pieces

## Exercise: union error

Why do you think the following won't work?

	SELECT * FROM BicycleParts
	UNION
	SELECT * FROM Pieces

## Union

Combine the two tables with "UNION"

	SELECT Produktnamn from BicycleParts
	UNION
	SELECT Name from Pieces

You'll get:

	Apple
	Banan
	Bike spokes
	Saddle
	Sprocket
	Wheel



## Exercise: get codes

Get the codes from the both tables

Expected

	5
	6
	7
	8
	100
	200

## Exercise: EXCEPT 

Get the productnames that are in BicycleParts but not in Piecese 

Hint, use this pattern:

	SELECT ... 
	EXCEPT 
	SELECT ...

Expected:

	Bike spokes
	Sprocket

## Exercise: INTERSECT

Exercise: Get the names that are in the both tables (use INTERSECT)

Result:

	Saddle
	Wheel


## Exercise: Products (hard)

Create a new table **Products** with all products:

	Code Name
	5	 Sprocket
	6	 Wheel
	7	 Saddle
	8	 Bike spokes
	100	 Apple
	200	 Banana

Hint, use this pattern

	SELECT ...
	INTO Products
	FROM (
		...
	) P

	(note the "P" at the end)
