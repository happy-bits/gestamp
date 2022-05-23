# Options for files

https://docs.microsoft.com/en-us/sql/relational-databases/blob/binary-large-object-blob-data-sql-server?view=sql-server-ver15

## Simple

Store your file within your table using
- Save path to filename - varchar         
- Save the binary of the file - varbinary(MAX)   

## FILESTREAM (SQL Server)

FILESTREAM enables SQL Server-based applications to store unstructured data, such as **documents and images**, on the file system. Applications can leverage the rich streaming APIs and **performance of the file system** and at the same time maintain **transactional consistency** between the unstructured data and corresponding structured data.

## FileTables (SQL Server)

The FileTable feature brings support for the **Windows file** namespace and compatibility with Windows applications to the file data stored in SQL Server. FileTable lets an application integrate its storage and data management components, and provides integrated SQL Server services - including **full-text search** and semantic search - over unstructured data and metadata.

In other words, you can store files and documents in special tables in SQL Server called FileTables, but access them from Windows applications **as if they were stored in the file system**, without making any changes to your client applications.

## Remote Blob Store (RBS) (SQL Server)

Remote BLOB store (RBS) for SQL Server lets database administrators store binary large objects (BLOBs) in **commodity storage** solutions instead of directly on the server. This saves a significant amount of **space** and avoids wasting **expensive server hardware** resources. RBS provides a set of API libraries that define a standardized model for applications to access BLOB data. RBS also includes maintenance tools, such as garbage collection, to help manage remote BLOB data.

RBS is **included on the SQL Server installation media**, but is not installed by the SQL Server Setup program.

## FileStream vs FileTables

https://stackoverflow.com/questions/32334084/filestream-vs-filetable

**filestream** was introduced in sql-server-2008 and handles the varbinary column by not storing the data in the database files (only a **pointer**), but in a different file on the filesystem, dramatically improving the performance.

**filetable** was introduced with sql-server-2012 and is an enhancement over filestream, because it provides metadata directly to SQL and it allows **access** to the files outside of SQL (**you can browse to the files**).

https://iwconnect.com/working-filetable-microsoft-sql-server/

FileStream and FileTable are features of SQL Server for storing unstructured data in SQL Server alongside other data. The FileStream feature stores unstructured data in the file system and keeps a pointer of the data in the database, whereas FileTable extends this feature even further allowing non-transactional access. One of the features of the non-transactional access is the ability to access files without prior authorization from the Database Engine from the shared location. In other words, the **FileTable** feature gives us the notion of **managing files in the file system** rather than in an SQL Server and in the same time the data can be accessed in a transactional way in the SQL Server as well.

Additionally, FileStream and FileTable features are also not available on SQL Azure Database. However, Azure cloud platform has a separate service, **Azure Blob storage** for storing unstructured data as objects/blobs.