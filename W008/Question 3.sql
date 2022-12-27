/*

You are working with the product team on a new category interface, 
and decide the best way to implement a solution requires you to deconstruct 
the Categories table into unique tables using the naming convention 
<CategoryName>_Category (e.g. Basses_Category)

 

Each table will have a single column ProductID of type int. Additionally, 
each of the new tables will be populated with the corresponding ProductID 
that can be derived from joining the Products and Categories tables.  

For example: The Basses_Category table would only have product rows where 
the category was Basses.

 

While it's possible to do this with 4  CREATE / INSERT statements 
(e.g. CREATE Basses_Category...then INSERT into...), you'd like to generalize 
and automate the process of creating and populating the new tables based on the 
data in the existing tables.

The purpose of the script is to allow it to work with any number of categories 
and products in the database.

 

HINTS:

 #1 - Approach the solution by using a loop and Dynamic SQL to create the table 
 and insert statements. There are a number of techniques to do this. Here's a good 
 link on different 
 ways : https://stackoverflow.com/questions/61967/is-there-a-way-to-loop-through-a-table-variable-in-tsql-without-using-a-cursor (Links to an external site.)

 

#2 - If you find the need in your algorithm to escape a single quote, MSSQL 
recognizes 2 single quotes as an escape

(e.g. this string : 'Being escaped '' End') would yield the string --  
Being escaped ' End -

 

#3 - When the script completes it has created  4 tables and populated as:

Basses_Category containing ProductID (7,8)

Drums_Category containing ProductID (9,10)

Guitars_Category containing (1,2,3,4,5,6)

Keyboards_Category containing ()

 

Write a single script that dynamically generates and executes the SQL to create 
the 4 new tables, and populate each new category tables with the appropriate 
productID relationship.

 

Here's a rough sketch of the version of the script. Note this is not valid SQL

-- Reset and drop and tables that were left over from a previous run
-- DECLARE variables
-- CREATE any temporary tables needed
--
-- WHILE EXISTS (select from a list)
-- BEGIN
-- SET Variables to build CREATE TABLE string of the statement
-- EXEC Variable version of the statement
-- END
--
-- Now the tables are created, add some rows of data, using Dynamic  SQL
-- WHILE EXISTS (select from a list)
-- BEGIN
-- SET variable to build INSERT string of the statements
-- EXEC variable version of the statement
-- END
-- 
-- Do some select statements to verify the tables were created and populated
-- DO some test drop statements to get rid of the test tables created.

*/


-------------------------Answer from me ------------------------------


USE MyGuitarShop

-- Dropp Bassess_Category if not exist
IF OBJECT_ID('Basses_Category') IS NOT NULL
DROP TABLE Basses_Category;
GO

-- Dropp Drums_Category if not exist
IF OBJECT_ID('Drums_Category') IS NOT NULL
DROP TABLE Drums_Category;
GO

-- Dropp Guitars_Category if not exist
IF OBJECT_ID('Guitars_Category') IS NOT NULL
DROP TABLE Guitars_Category;
GO

-- Dropp Keyboards_Category if not exist
IF OBJECT_ID('Keyboards_Category') IS NOT NULL
DROP TABLE Keyboards_Category;
GO

-- Defining variables
DECLARE @Basses varchar(10) = 'Basses', @Drums varchar(10)= 'Drums', 
	@Guitars varchar(10) = 'Guitars', @Keyboards varchar(10) = 'Keyboards';
DECLARE @BassesWord varchar(1000), @DrumsWord varchar(1000), 
	@GuitarsWord varchar(1000), @KeyboardsWord varchar(1000);
	
-- Creating four tables
SET @BassesWord = 'CREATE TABLE ' +  @Basses + '_Category ( ProductID int);';
SET @DrumsWord = 'CREATE TABLE ' +  @Drums + '_Category ( ProductID int);';
SET @GuitarsWord = 'CREATE TABLE ' +  @Guitars + '_Category ( ProductID int);';
SET @KeyboardsWord = 'CREATE TABLE ' +  @Keyboards + '_Category ( ProductID int);';

EXEC(@BassesWord);
EXEC(@DrumsWord);
EXEC(@GuitarsWord);
EXEC(@KeyboardsWord);

-- Defining dynamic variables
DECLARE @DynamicSQL_B varchar(8000), @DynamicSQL_D varchar(8000),
	@DynamicSQL_G varchar(8000), @DynamicSQL_K varchar(8000);

SET @DynamicSQL_B = 'INSERT INTO ' + @Basses + '_Category ';
SET @DynamicSQL_B = @DynamicSQL_B + 'SELECT ProductID FROM Products JOIN Categories ON '
SET @DynamicSQL_B = @DynamicSQL_B + 'Categories.CategoryID = Products.CategoryID '
SET @DynamicSQL_B = @DynamicSQL_B + 'WHERE CategoryName = ''' +  @Basses + ''';';

SET @DynamicSQL_D = 'INSERT INTO ' + @Drums + '_Category ';
SET @DynamicSQL_D = @DynamicSQL_D + 'SELECT ProductID FROM Products JOIN Categories ON '
SET @DynamicSQL_D = @DynamicSQL_D + 'Categories.CategoryID = Products.CategoryID '
SET @DynamicSQL_D = @DynamicSQL_D + 'WHERE CategoryName = ''' +  @Drums + ''';';

SET @DynamicSQL_G = 'INSERT INTO ' + @Guitars + '_Category ';
SET @DynamicSQL_G = @DynamicSQL_G + 'SELECT ProductID FROM Products JOIN Categories ON '
SET @DynamicSQL_G = @DynamicSQL_G + 'Categories.CategoryID = Products.CategoryID '
SET @DynamicSQL_G = @DynamicSQL_G + 'WHERE CategoryName = ''' +  @Guitars + ''';';

SET @DynamicSQL_K = 'INSERT INTO ' + @Keyboards + '_Category ';
SET @DynamicSQL_K = @DynamicSQL_K + 'SELECT ProductID FROM Products JOIN Categories ON '
SET @DynamicSQL_K = @DynamicSQL_K + 'Categories.CategoryID = Products.CategoryID '
SET @DynamicSQL_K = @DynamicSQL_K + 'WHERE CategoryName = ''' +  @Keyboards + ''';';

-- Inserting data into four tables
EXEC (@DynamicSQL_B);
EXEC (@DynamicSQL_D);
EXEC (@DynamicSQL_G);
EXEC (@DynamicSQL_K);
GO

-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


-- Drop tables
DROP TABLE IF EXISTS #CategoryList;
GO
DECLARE @DynSQL varchar(5000);
DECLARE @TableName varchar(256);
SELECT TABLE_NAME INTO #CategoryList FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
AND TABLE_NAME Like '%_Category'



WHILE EXISTS(select * from #CategoryList)
  BEGIN
    SET @TableName = (SELECT TOP 1 TABLE_NAME FROM #CategoryList);
    SET @DynSQL = 'DROP TABLE IF EXISTS '+@TableName+';'
    EXEC (@DynSQL);
    DELETE FROM #CategoryList WHERE TABLE_NAME = @TableName
END
-- Create tables
DROP TABLE IF EXISTS #CategoryList;
GO
-- Create a temp table to track the categories
SELECT CategoryName INTO #CategoryList FROM Categories;
 

DECLARE @DynSQL varchar(5000);
DECLARE @TableName varchar(256);
 

-- Main loop
WHILE EXISTS(select * from #CategoryList)
  BEGIN
-- Get the first item
    SET @TableName = (SELECT TOP 1 CategoryName FROM #CategoryList);
    SET @DynSQL = 'CREATE TABLE '+ @TableName+ '_Category(ProductID int);INSERT       INTO '+@TableName+ '_Category SELECT ProductID FROM Products p INNER JOIN Categories c ON p.CategoryID = c.CategoryID '+ 'AND c.CategoryName='+' '''+@TableName+'''';
EXEC (@DynSQL);
 

-- Remove it from the list
DELETE FROM #CategoryList WHERE CategoryName = @TableName
END
 

-- Verify they were created
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME Like '%_Category'
