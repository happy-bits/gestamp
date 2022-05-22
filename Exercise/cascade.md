# Cascade

*Purpose: shows different ways to handle the removing of a row in a "parent"-table*

Delete cascade or update cascade in related to a foreign key

Different types of response:
- Give error message
- Set "null" to child rows
- Delete the child rows

References:
- https://www.sqlservertutorial.net/sql-server-basics/sql-server-foreign-key/

## Exercise

Create a database

	use master
	exec Happybits.Recreate 'Demo'
	go
	use Demo

Create these two tables:

	create table Author(
		Id int primary key,
		Name varchar(50),
	)

	create table Book(
		Id int primary key,
		Title varchar(50),
		AuthorId int foreign key references Author(Id)
	)

Insert two authors and three books:

	insert into Author values 
		(5, 'Herman Melville'),
		(6, 'Leo Tolstoy')

	insert into Book values 
		(1000, 'Moby-Dick', 5),
		(1001, 'War and Peace', 6),
		(1002, 'Anna Karenina', 6)


In the example above "Leo Tolstoy" has written two books: "War and Peace" and "Anna Karenina".

## Exercise

What happens with the books when you try to remove "Leo Tolstoy"?	

## Exercise

Recreate the database but change how the author column in created:

	AuthorId int foreign key references Author(Id) on delete set null

What happens with the books when you try to remove "Leo Tolstoy"?

## Exercise

Recreate the database but change how the author column in created:

	AuthorId int foreign key references Author(Id) on delete cascade

What happens with the books when you try to remove "Leo Tolstoy"?


## Update cascade

Recreate the database but change how the author column in created:

	AuthorId int foreign key references Author(Id) on update cascade

Change Id for Leo Tolstoy:

	update Author set Id=777 where Id=6

Now the AuthorId in the Book table is also changed to 777

	select * from Author
	select * from Book
	
## Details

Cascade don't work on primary key