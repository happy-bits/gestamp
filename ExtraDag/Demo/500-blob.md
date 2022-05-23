# Datatypes for storing files

To store files like images and PNG's in a table use varbinary or varbinary(MAX)

## varbinary(8000)

1 to 8000 bytes

## varbinary(8001)

Doesn't work

## varbinary(max)

Stores up to 2Gb

## image

This datatype in going to be obsolete, so don't use it

## Manual inserting a binary 

It's not so common to manual insertering a binary, but here is how you do it:

    INSERT INTO Customer(Name, Created, ImageData) 
    VALUES ('Maria', '2022-01-01', 0x12345)

# Demo

Teacher shows Blob-project in C#