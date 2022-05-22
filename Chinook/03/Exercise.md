# Chinook 03

## Intro

Exercises related to the slides and demos:

- Group by
- Stored procedures
- Views
- Indexes
- Triggers

## 3.1 (Group by)

Query with two columns:
- ArtistName
- NrOfAlbums: the amount of albums this artist has released

## 3.2 (Group by)

List the invoiceid(s) that contains the most invoicelines

Hint: google on "with ties"

## 3.3 (Group by)

List the 10 artists (or more) who released the most albums (ArtistName, NrOfAlbums)

Hint: google on "with ties"

## 3.4 (Stored procedures)

Create a stored procedure **CreateTrack** with parameters
- name
- unit price
- media type id
- milliseconds
- playlist id

When the procedure is called it should add a new track and add it to an existing playlist

Hint: read about **SCOPE_IDENTITY()**

## 3.5 (Views)

Create a view **AlbumInfo** that contains two column: album title and artist name. Like this:

    Let There Be Rock	                    AC/DC
    For Those About To Rock We Salute You	AC/DC
    Balls to the Wall	                    Accept
    Restless and Wild	                    Accept

Then use the view to list info about albums that have 4 or fewer letters

## 3.6 (Index)

Measure the time it takes to add 10.000 customers (you can add the same customer over and over again)

Remove the inserted customers

Insert indexes on ALL columns (15 indexes)

Measure the time again and compare the result.

When you measure, try five times and pick the median value.

Extra: see if you get a different result if the inserted customers has random names, birthdate, country etc.

## 3.7 (Trigger)

Create a table that is similar to Artist. It should be namned **DeletedArtist** and have three columns:
- ArtistId
- Name
- DeletedDate

Then create a trigger **LogDeletedArtists**. When an artist is removed from the Artist-table, then a row should be added to DeletedArtist with ArtistId, Name and DeletedDate.

