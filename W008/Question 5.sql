/*

You are working with the development team and have been asked to create a 
Stored Procedure (spInsertProduct) that inserts a row into the Products table.

The stored procedure should accept five parameters: CategoryID, ProductCode, 
ProductName, ListPrice, and DiscountPercent.
This stored procedure should set the Description column to an empty string, 
and  it should set the DateAdded column to the current date.
If the value for the ListPrice column is a negative number, the stored procedure 
should  raise an error (using THROW) that indicates that this column doesn’t 
accept negative numbers. 
Similarly, the procedure should raise an error if the value for the DiscountPercent 
column is a negative number.
 

Your answer should have the following (4 sections)

-- Prep (any specific statements that prepare the subsequent steps 
(e.g. DROP TABLES that may exist
-- Build (the core part of the answer (CREATE FUNCTION,etc..)
-- Test (one or more statements to verify your response has the desired 
outcome(s)) - All test cases should be covered
-- Clean (optional) - If running the tests, creates an invalid state, you 
can use this section to  delete, or update rows or other adjustments.

 

Note: You'll write each of the sections on your own.

*/


-------------------------Answer from me ------------------------------

USE MyGuitarShop;
-- Prep
IF OBJECT_ID('spInsertProduct') IS NOT NULL
  DROP PROC spInsertProduct;
GO
-- Build
CREATE PROC spInsertProduct
	@CategoryID INT = NULL,
	@ProductCode varchar(10) = NULL,
	@ProductName varchar(255) = NULL,
	@Description text = NULL,
	@ListPrice money = NULL,
	@DiscountPercent money = NULL,
	@DateAdded datetime = NULL

AS

SET @DateAdded = GETDATE()
IF @CategoryID IS NULL
    THROW 50001, 'Invalid CategoryID.', 1;
IF @ProductCode IS NULL
    THROW 50001, 'Invalid ProductCode.', 1;
IF @ProductName IS NULL
    THROW 50001, 'Invalid ProductName.', 1;
IF @ListPrice IS NULL
    THROW 50001, 'Invalid ListPrice.', 1;
IF @DiscountPercent IS NULL
    THROW 50001, 'Invalid DiscountPercent.', 1;
IF @ListPrice < 0
	THROW 50001, 'This column doesn''t accept negative numbers.', 1;
IF @DiscountPercent < 0
	THROW 50001, 'This column doesn''t accept negative numbers.', 1;



INSERT Products
VALUES (@CategoryID, @ProductCode, @ProductName, @Description,
        @ListPrice, @DiscountPercent, @DateAdded);
RETURN @@IDENTITY;
GO

-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


-- Prep
DROP PROCEDURE IF EXISTS spInsertProduct;
GO
 

--Build
CREATE PROC spInsertProduct
@CategoryID INT,
@ProductCode VARCHAR(10),
@ProductName VARCHAR(255),
@ListPrice MONEY,
@DiscountPercent MONEY
AS
 
--Testing the entered parameters

IF NOT EXISTS (SELECT * FROM Categories WHERE CategoryID = @CategoryID)

THROW 50001, 'Invalid CategoryID.', 1;

IF @ProductCode IS NULL

THROW 50001, 'Invalid ProductCode.', 1;

IF @ProductName IS NULL

THROW 50001, 'Invalid ProductName.', 1;

IF @ListPrice < 0

THROW 50001, 'ListPrice cannot be a negative number.', 1;

IF @DiscountPercent < 0

THROW 50001, 'DiscountPercent cannot be a negative number.', 1;

INSERT Products

VALUES (@CategoryID, @ProductCode, @ProductName, '', @ListPrice, @DiscountPercent, GETDATE());

RETURN @@IDENTITY;

INSERT INTO Products
(CategoryID, ProductCode, ProductName, Description,
ListPrice, DiscountPercent, DateAdded)
VALUES
(@CategoryID, @ProductCode, @ProductName, '',
@ListPrice, @DiscountPercent, GETDATE());
 

GO

-- Test fail:
PRINT 'Fail'
EXEC spInsertProduct 1, 'G5122', 'Gretsch G5122 Double Cutaway Hollowbody', 999.99, -32;
GO

-- Test success:
PRINT 'Success'
EXEC spInsertProduct 1, 'G5122', 'Gretsch G5122 Double Cutaway Hollowbody', 999.99, 32;
GO



-- Clean up:
DELETE FROM products WHERE ProductID > 10;
GO