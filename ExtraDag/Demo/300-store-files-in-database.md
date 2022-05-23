# Should I use DB to store file ?

https://medium.com/@vaibhav0109/should-i-use-db-to-store-file-410ee22268c7

2019-06

## Why store in FileSystem ?

**Read/write** to a DB is always **slower** than a file system.

Your DB backups become huge, which makes **restoration & replication slower**.(Its a problem where daily size is in TB’s)

Access to the files now requires going through your Application and Database layers.(It increases the **application memory** requirements)

**Cost effective**, file servers are much cheaper compared to database. (CDN/Amazon S3)

Easier in cases where files (video, audio etc) are to be **shared with third party** providers.

## Then why store files in DB ?

DB provides ACID compliance (Atomicity, Consistency, Isolation, Durability) for each row.

DB provides **data integrity** between the file and its metadata.

Database **Security** is available by default.

**Backups automatically include files**, no extra management of file system necessary.

File deletion/updation is **always in sync** with row operations, no extra maintenance needed.

## Read more

https://habiletechnologies.com/blog/better-saving-files-database-file-system/

https://www.brentozar.com/archive/2021/07/store-files-in-a-file-system-not-a-relational-database/

## Exercise 

Discuss in groups for 10 minutes what pros and cons you see in your projects
- When to store files in file system (local or in the cloud)
- When to store files in a database

Share (10min)






