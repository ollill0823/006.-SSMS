/*

You'll use your design from the previous question to create the DDL for the 
database.
 

Use the following additional information when creating the DDL for a database 
called MyWebDb.
	* Include a statement to drop the database if it already exists.
	* Include statements to create and select the database.
	* Create the Downloads, User and Product tables.
	* In the Downloads table, the UserID and ProductID columns are the foreign keys.
	* Include any indexes that you think are necessary.
 

Once the structures are created, add statements to populate the database tables.
	* Add two rows to the Users and Products tables.
	* Add three rows to the Downloads table: one row for user 1 and product 2; 
	one for user 2 and product 1; and one for user 2 and product 2 and when 
	inserting, specify the GETDATE function to insert the current date and time 
	into the DownloadDate column.

Note: You should be able to run the entire response as a single script, 
over and over without any errors.

*/


-------------------------Answer from me ------------------------------


USE master
GO

/****** Object:  Database AP     ******/
IF DB_ID('MyWebDb') IS NOT NULL
	DROP DATABASE MyWebDb
GO

--- 1. Create a database named MyWebDb ---
CREATE DATABASE MyWebDb
GO 

USE MyWebDb
GO

--- 1.1 Create a table named Users ---
CREATE TABLE Users
(
UserID INT NOT NULL PRIMARY KEY, /* In this table, each UserID can only has one row*/
Email varchar(50) NOT NULL,
UserFirstName varchar(50) NOT NULL,
UserLastName varchar(50) NOT NULL

)

--- 1.2 Create a table named Downloads ---
CREATE TABLE Downloads
(
UserID INT NOT NULL,
ProductID INT NOT NULL,
FileName varchar(50) NOT NULL,
DownloadDate Datetime NOT NULL
)

--- 1.3 Create a table named Products ---
CREATE TABLE Products
(
ProductID INT NOT NULL PRIMARY KEY, /* In this table, each UserID can only has one row*/
ProductName varchar(50) NOT NULL)
GO




--- 2.1 Insert rows of data into Users ---
INSERT Users
(UserID, Email, UserFirstName, UserLastName) VALUES 
(1, '1234@gmail.com', 'Rachel', 'Green'),
(2, '5678@gmail.com', 'Monica', 'Geller'),
(3, '1234566@gmail.com', 'Phoebe', 'Buffay'),
(4, '5678999@gmail.com', 'Joey', 'Tribbiani'),
(5, '9876@gmail.com', 'Chandler', 'Bing'),
(6, '54321@gmail.com', 'Ross', 'Geller')
GO

--- 2.2 Insert rows of data into Downloads ---
INSERT Downloads
(UserID, ProductID, FileName, DownloadDate) VALUES
(1, 1, 'Knife.csv', GETDATE()),
(2, 1, 'Hand_Sanitizer.csv', GETDATE()),
(2, 2, 'Hand_Aroma.csv', GETDATE()),
(3, 3, 'Drums.csv', '2016-04-02 11:26:38.000'),
(4, 4, 'Guitars.csv', '2016-04-04 06:24:44.000'),
(5, 5, 'Keyboards.csv', '2016-04-06 07:53:42.000'),
(6, 6, 'Baseball.csv', '2016-04-17 17:40:22.000')
GO



--- 2.3 Insert rows of data into Products ---
INSERT Products
(ProductID, ProductName) VALUES
(1, 'Screwdriver'),
(2, 'Deodorant'),
(3, 'Purse/bag'),
(4, 'Incense holder'),
(5, 'Shark'),
(6, 'Marble')
GO



--- 3.1 Create an index From the table Users ---
CREATE NONCLUSTERED INDEX IX_Users ON Users(
	UserID ASC)
GO




--- 4 Create check constrain (key line, arrows are toward the Primary key) ---
--- 4.1 Create a constraint link between Downloads(Foreign key) and Users(Primary key) ---
ALTER TABLE Downloads
WITH NOCHECK ADD CONSTRAINT FK_Downloads_Users
FOREIGN KEY(UserID)   /* Foreign key */
REFERENCES Users (UserID) /* Primary key */
GO

--- 4.1.1 Rollback to check constrain ---
ALTER TABLE Downloads CHECK CONSTRAINT FK_Downloads_Users
GO


--- 4.2 Create a constraint link between Downloads(Foreign key) and Products(Primary key) ---
ALTER TABLE Downloads
WITH NOCHECK ADD CONSTRAINT FK_Downloads_Products 
FOREIGN KEY(ProductID)   /* Foreign key */
REFERENCES Products (ProductID)  /* Primary key */
GO


--- 4.2.1 Rollback to check constrain ---
ALTER TABLE Downloads CHECK CONSTRAINT FK_Downloads_Products
GO



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


-- setup
DROP DATABASE IF EXISTS MyWebDb
GO

CREATE DATABASE MyWebDb;
GO
-- Create structures

USE MyWebDb;

CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  EmailAddress VARCHAR(100) UNIQUE,
  FirstName VARCHAR(45) NOT NULL,
  LastName VARCHAR(45) NOT NULL
);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(45) UNIQUE
);

CREATE TABLE Downloads (
  DownloadID INT PRIMARY KEY,
  UserID INT NOT NULL,
  DownloadDate DATETIME NOT NULL,
  Filename VARCHAR(50) NOT NULL,
  ProductID INT NOT NULL,
  CONSTRAINT FK_DownloadsUsers
  FOREIGN KEY (UserID ) REFERENCES Users (UserID),
  CONSTRAINT FK_DownloadsProducts
  FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
-- indices
CREATE INDEX IX_UserID
    ON Users (UserID);

CREATE INDEX IX_ProductID
  ON Products (ProductID);

CREATE INDEX IX_EmailAddress
  ON Users (EmailAddress);

CREATE INDEX IX_DownloadDate
  ON Downloads (DownloadDate);

-- Populate 
INSERT INTO Users VALUES
(1, 'johnsmith@gmail.com', 'John', 'Smith'),
(2, 'janedoe@yahoo.com', 'Jane', 'Doe');

INSERT INTO Products VALUES
(1, 'Local Music Vol 1'),
(2, 'Local Music Vol 2');

INSERT INTO Downloads VALUES
(1, 1, GETDATE(), 'petals_are_falling.mp3', 1),
(2, 2, GETDATE(), 'turn_signal.mp3', 1),
(3, 2, GETDATE(), 'one_horse_town.mp3', 2);
 