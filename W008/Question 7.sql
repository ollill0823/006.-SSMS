/*

Now, you decide another optimization is to create a trigger Products_UPDATE 
that's fired when a UPDATE is made to the DiscountPercent column on the 
Products table.
 

The logic is as follows:

#1  IF the discount percent is greater than 100 or less than 0.  this trigger 
should raise an appropriate error (via THROW)
#2 IF the new discount percent is between 0 and 1, the trigger should UPDATE  
the  discount percent by multiplying it by 100.  For example, a discount 
percent of .2 becomes 20.

HINT: Triggers have access to special tables (inserted, or deleted) rows. 
No other variables are passed to triggers like a function. SELECT DiscountPercent 
FROM inserted) - returns the DiscountPercent of the row that originally fired the trigger.  


Your answer should have the following (4 sections)
-- Prep (any specific statements that prepare the subsequent steps (e.g. DROP TABLES that may exist
-- Build (the core part of the answer (CREATE FUNCTION,etc..)
-- Test (one or more statements to verify your response(s) has the desired outcome(s))- All test cases should be covered
-- Clean (optional) - If running the tests, creates an invalid state, you can use this section to  delete, or update rows or other adjustments.
Note: You'll write each of the sections on your own.

*/


-------------------------Answer from me ------------------------------


USE MyGuitarShop;
GO
-- Prep
IF OBJECT_ID('Products_UPDATE_AUDIT') IS NOT NULL
    DROP TRIGGER Products_UPDATE_AUDIT;
GO


-- Build
CREATE TRIGGER Products_UPDATE_AUDIT
	ON Products
    AFTER INSERT,UPDATE

AS

DECLARE @DiscountPercent money;
SELECT @DiscountPercent = DiscountPercent FROM inserted
IF @DiscountPercent > 100 OR @DiscountPercent < 0
		THROW 50001, 'DiscountPercent can not be larger than 100 or smaller than 0.', 1;
UPDATE Products
SET DiscountPercent = DiscountPercent*100
WHERE DiscountPercent >=0 AND DiscountPercent <=1;
GO



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

-- Prep
DROP TRIGGER IF EXISTS Products_UPDATE;
GO


-- Build
CREATE TRIGGER Products_UPDATE
ON Products
AFTER UPDATE
AS

IF (SELECT DiscountPercent FROM inserted) >= 1
THROW 50001, 'The discount percent must be less than 1.', 1;

IF (SELECT DiscountPercent FROM inserted) < 0
THROW 50001, 'The discount percent must be a positive number.', 1;

IF (SELECT DiscountPercent FROM inserted) >=0 AND
(SELECT DiscountPercent FROM inserted) < 1
UPDATE Products
SET DiscountPercent = (SELECT DiscountPercent FROM inserted) * 100
WHERE ProductID = (SELECT ProductID FROM inserted);

GO

-- Test

-- Failed Test #1
PRINT 'Fail <0'
UPDATE Products
SET DiscountPercent = -.25
WHERE ProductID = 1;
GO

-- Failed Test #2
PRINT 'Fail >1'
UPDATE Products
SET DiscountPercent = 4
WHERE ProductID = 1;
GO

-- Success Test #3
PRINT 'Success'

UPDATE Products
SET DiscountPercent = .30
WHERE ProductID = 1;
GO

-- check results
SELECT ProductID, ProductCode, ProductName, DiscountPercent FROM Products;
GO


-- Clean
-- Reset Test #3
UPDATE Products
SET DiscountPercent = .25
WHERE ProductID = 1;
GO

DROP TRIGGER IF EXISTS Products_UPDATE;
GO




