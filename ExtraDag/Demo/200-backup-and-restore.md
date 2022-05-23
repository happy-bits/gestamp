# Backup and Restore

*Purpose: Learn to backup a database and restore it to a previous version + see when LOG-file and MDF-file updates*

References:
- https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/view-the-contents-of-a-backup-tape-or-file-sql-server?view=sql-server-ver15
- https://www.mssqltips.com/sqlservertip/4407/rename-logical-database-file-name-for-a-sql-server-database/

## Backup and Restore a database

	create database Demo
	
	create table Product(Id int, Name varchar(50), Price decimal) 
	 
	insert into Product values
	(1, 'DeLonghi Magnifica S ECAM', 2990),
	(2, 'Nespresso Essenza Mini C30', 759), 
	(3, 'Jura E8', 12487)

	select * from Product

    -- Backup database

    backup database Demo to disk = 'C:\TMP\demo.bak'

    -- Remove a column and some rows

	delete from Product where Id=2
	
	alter table Product drop column Price

	select * from Product

    -- Restore database

	use master

	restore database Demo from disk = 'C:\TMP\demo.bak' with replace

	use Demo
	select * from Product

Note: the removed product and the price-column is now back

## Exercise

Investigate when the LOG-file and MDF-file updates when running the script above. Commands to look at:
- create
- insert
- select
- backup
- delete
- alter table
- use
- restore

It can be helpful to use the powershell script at *000-Powershell.md*

## Solution

Both files updates:
- create database
- backup database

The log file updates:
- create table
- insert into
- delete
- alter table

Nothing happens
- select

## Restore previous point in time

Create a new database as last example with three products

    -- Backup database (Position 1)

    backup database Demo to disk = 'C:\TMP\demo.bak' with init --- <== this will remove previous backups

    -- Remove a product + take backup (Position 2)

	delete from Product where Id=2
	select * from Product
    backup database Demo to disk = 'C:\TMP\demo.bak' 

    -- Remove a column + take backup (Position 3)

	alter table Product drop column Price
	select * from Product
    backup database Demo to disk = 'C:\TMP\demo.bak' 


    -- View content of backup
	-- Look for Position, BackupStartDate, BackupFinishDate

    RESTORE HEADERONLY FROM DISK =  'C:\TMP\demo.bak' 
	
    -- Restore to the first backup

	use master
	restore database Demo from disk = 'C:\TMP\demo.bak' with file=1, replace

	use Demo
	select * from Product

## Exercise

Try the same command but change "file" to 2 and 3

Verify that the Product table contains what you expect

## Clone a database (exercise)

    -- Do backup to any place on disk (init = overwrite, stats = gives statistics)

	BACKUP DATABASE DEMO TO DISK = 'C:\TMP\demo.bak' WITH INIT, STATS = 10   

    -- List logical names (MDF and LOG)
	-- Look for: PhysicalName, Type, Size

	RESTORE FILELISTONLY FROM disk = 'C:\TMP\demo.bak'

    -- Restore to a new database 
	-- This creates a new database "Cloned" which points to new MDF and LDF files

	RESTORE DATABASE Cloned FROM DISK = 'C:\TMP\demo.bak'
	WITH STATS =10, RECOVERY,
	move 'Demo' to 'C:\TMP\Cloned.mdf',
	move 'Demo_log' to 'C:\TMP\Cloned_log.ldf'

    -- List logical names (MDF and LOG)

	SELECT d.name DatabaseName, f.name LogicalName, f.physical_name AS PhysicalName, f.type_desc TypeofFile
	FROM sys.master_files f
	INNER JOIN sys.databases d ON d.database_id = f.database_id
	WHERE d.name = 'Cloned'

    -- Change logical names

	USE [master];
	ALTER DATABASE Cloned MODIFY FILE ( NAME = Demo, NEWNAME = Cloned );
	ALTER DATABASE Cloned MODIFY FILE ( NAME = Demo_log, NEWNAME = Cloned_log );

    -- View cloned database

	USE Cloned
	SELECT * FROM Product

	use Demo
	SELECT * FROM Product

## Misc: View content of backupfile

To see which databases is backed up in the file, the start time for backup, end time

    RESTORE HEADERONLY FROM DISK =  'C:\TMP\demo.bak'

One database backup can contain a mix of completely different databases

## Misc: Logical names

SQL Server database files have two names: one is the logical file name and the other is the physical file name. The logical file name is used with some T-SQL commands, such as DBCC SHRINKFILE. 

It is not mandatory to keep logical file names unique on a SQL Server instance, but ideally we should keep them unique to avoid any confusion

## Misc: Database files

A Microsoft SQL Database consists of a primary data file (MDF) a secondary data file (NDF) and a transaction log file (LDF). 

MDF stands for **Master Database File** and contains all the information in a database. 

LDF stands for **Log Database File** and records all the transactions and changes to the database. The ldf is critical for disaster recovery.

The files can be moved to other places

MDF
- Main Database File
- All info
- Points to other files

LDF
- Record all transactions and changes to the database
- Critical for recovery (e.g during transactions or when server starts)
- Can be very big

NDF
- Secondary 
- Can have 0 or more

Misc: I set a database offline. Then I could remove the LDF-file. Set it online and it works. (But if I remove the MDF file then it doesn't work of course)