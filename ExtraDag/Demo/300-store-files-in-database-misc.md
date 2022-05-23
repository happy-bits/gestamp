
# Which Is Superior: Saving Files In A Database Or In A File System?

https://habiletechnologies.com/blog/better-saving-files-database-file-system/

Ungefär samma innehåll som "Why store in FileSystem"

## Filestream

If you are using SQL server **2008** or higher version, make use of FILESTREAM.

Filestream enables storing BLOB data in NTFS while at the same time it ensures **transactional consistency** between the unstructured Blob data with a structured data in db.

# Store Files in a File System, Not a Relational Database.

https://www.brentozar.com/archive/2021/07/store-files-in-a-file-system-not-a-relational-database/

2021-06

I korthet
- Att spara filer i databasen gör att den blir väldigt stor
- (Användare har en tendens att ladda upp många filer och skapa versioner av samma fil)
- Nackdel med det: tar längre tid att göra backup, svårare om du har replikor av databasen, databasservern är ofta dyr

## There’s a better way: store files in a file system.

File systems have been around for a really long time, and they have tools to help address these challenges. Best of all, they’re insanely, insanely inexpensive, especially compared to relational databases.

Because if you’re not doing a relational join with it,
it doesn’t belong in a relational database.