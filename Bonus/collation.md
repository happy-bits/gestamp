
# Sortera olika med olika collation

	/*
		Collation talar om hur sortering görs. 

		Finns på databasnivå, tabellnivå och kolumnnivå (kan sättas olika)
	*/

	-- Setup av databas

	CREATE TABLE Locations (Place varchar(15) NOT NULL);
	GO

	INSERT Locations(Place) VALUES ('Chiapas'),('Colima'), ('Cinco Rios'), ('California'),('Ååå'),('Äää'),('Ööö')
	GO

	-- Visa serverns collation
	SELECT SERVERPROPERTY('collation')

	--Ingen collation
	SELECT Place FROM Locations
	ORDER BY Place ASC;
	GO
	
	--Finsk och svensk collation
	SELECT Place FROM Locations
	ORDER BY Place 
	COLLATE Finnish_Swedish_CI_AS ASC;
	GO
	
	-- En normal collation
	SELECT Place FROM Locations
	ORDER BY Place
	COLLATE SQL_Latin1_General_CP1_CI_AS ASC;
	GO
	
	-- Spansk collation
	SELECT Place FROM Locations
	ORDER BY Place
	COLLATE Traditional_Spanish_ci_ai ASC;
	GO

# Filtrera case sensitive

    --- Genom att ange COLLATE: (CS == Case Sensitive)

	select * from Artist 
	where Name COLLATE SQL_Latin1_General_CP1_CS_AS  like 'Yo%'

	-- Inga träffar

	select * from Artist 
	where Name COLLATE SQL_Latin1_General_CP1_CS_AS  like 'YO%'