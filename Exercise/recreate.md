# Recreate

*Purpose: the following script will make it easy to remove and recreate a database*

Add the following stored procedure "Recreate". It will make it easy to create a fresh database.

	use master
	go
	
	create schema Happybits
	go
	
	create or alter proc Happybits.Recreate @databasename varchar(50)
	as
	begin

		if DB_ID(@databasename) is not null
		begin
			exec ('alter database ' + @databasename + ' set single_user with rollback immediate')
			exec ('drop database ' + @databasename)
		end

		exec('create database '+ @databasename)

	end
	go

