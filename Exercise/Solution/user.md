# Users

*Purpose: see difference between "login" and "user".  Create "login", "user" and give access to a "user"*

https://docs.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver15

Create a database "Demo1"

	use master
	exec Happybits.Recreate 'Demo1'
	go
	use Demo1

Create a SQL Server login (global, this is not connected to the current database)

	create login Orre with password='fghTRHY4%/&2346%&eRTYyrt'

Now you will see this under Security\Logins (at the top, global for that databaseserver)

Create a database user "OrreUser1" that is connected to the login above

	create user OrreUser1 for login Orre

Now you will see the user under "Security\Users"  (on that database)

Create a database "Demo2"

	use master
	exec Happybits.Recreate 'Demo2'
	go
	use Demo2

## Note

LOGIN is connected to the SERVER

USER is connected to a specific DATABASE

## Database user

Create a database user "OrreUser2" that is connected to the login "Orre"

Detail: we could name this OrreUser1 if we wanted (no collission since they are in different databases)

	create user OrreUser2 for login Orre 

## Detail

One SERVER can have many LOGINS

One SERVER can have many DATABASES

One DATABASE can have many USERS

One USER is always connected to (only) one LOGIN

One LOGIN is connected to one or more USERS (in different databases)

A user with name kalle is not the same as the user kalle in another database 

If someone logs in, that person is connected to serveral users in different databases.

## Exercise: try adding one more user for the same login

Try the following

	create user OrreUser3 for login Orre

..what happens?

Solution

	It is not possible since two users in the same database can't be connected to the same login

	This will give

		The login already has an account under a different user name.

## Roomsize table

Create a table RoomSize and fill with content:

	CREATE TABLE RoomSize(
		[Id] [int] NOT NULL,
		[RoomType] [nvarchar](50) NOT NULL,
		[NumberOfBeds] [int] NOT NULL,
		[ExtraBeds] [int] NULL
	)

	INSERT [RoomSize] VALUES (1, 'Single room', 1, 0)
	INSERT [RoomSize] VALUES (2, 'Single room + 1', 1, 1)
	INSERT [RoomSize] VALUES (3, 'Double room', 2, 0)
	INSERT [RoomSize] VALUES (4, 'Double room + 1', 2, 1)
	INSERT [RoomSize] VALUES (5, 'Double room + 2', 2, 2)
	INSERT [RoomSize] VALUES (6, 'Suite', 4, 0)
	INSERT [RoomSize] VALUES (7, 'Precidential suite', 2, 4)
	INSERT [RoomSize] VALUES (8, 'Bridal suite', 2, 0)

	SELECT * FROM RoomSize


Change to the user OrreUser2

	EXECUTE AS USER = 'OrreUser2' ;  
	GO 

Check who you are

	SELECT CURRENT_USER; --OrreUser2

## Exercise: try selecting

What happens if you do the following?

	select * from RoomSize

Solution

	It won't work because the user don't have any right.

	Error message

		The SELECT permission was denied on the object 'RoomSize', database 'Demo2', schema 'dbo'.


## Change access for user

Go back to your previous login (as admin)

	REVERT ;  
	GO 

	SELECT CURRENT_USER; --dbo (database owner)


Let's give access for OrreUser2 so she/he can show all RoomSize's

Detail: we can only give access to a user, not a a "login" (not to "Orre")

	grant select on RoomSize to OrreUser2

## Try again to read RoomSize table

Let's try again to login as OrreUser2 and select all Room's

	EXECUTE AS USER = 'OrreUser2' ;
	GO 

	SELECT CURRENT_USER; --OrreUser2

	select * from RoomSize

## Add read access to user

Give OrreUser2 read access to all tables:

	REVERT ;  
	GO 
	
	ALTER ROLE [db_datareader] ADD MEMBER [OrreUser2]	

Remove that membership:	

	ALTER ROLE [db_datareader] DROP MEMBER [OrreUser2]

About db_datareader
- Members of the db_datareader fixed database role can read all data from all user tables.
- db_datareader is an example of a **fixed-database role**. These roles exist in all databases. The permissions of the roles can't change

You can create roles yourself as well and give a role a special permission

https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver15

