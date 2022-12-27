/*

In thinking about optimization, you decide to build some auditing systems when 
changes occur to the database. 

You decide to create an audit table ProductsAudit to track changes to the 
Products table.

 

The ProductAudit table ~
	* should have all columns of the Products table, except the Description column.
	* should have an AuditID column for its primary key,
	* should have the DateAdded column changed to DateUpdated. 
	* will be updated via a trigger, "Products_UPDATE".  When the trigger fires, 
	it should  insert the original product data (the data that is being overwritten
	by the update) into the ProductsAudit table after the row is updated.

 

Your answer should have the following (4 sections use comment -- labels)

-- Prep (any specific statements that prepare the subsequent steps 
e.g. DROP TABLES that may exist
-- Build (the core part of the answer (CREATE FUNCTION,etc..)
-- Test (one or more statements to verify your response has the desired 
outcome(s) - All test cases should be covered
-- Clean (optional) - If running the tests, creates an invalid state, you 
can use this section to  delete, or update rows or other adjustments.

Here's an example of a script template. your answer should fill in the -- 
Build section


-- *************************** Script Template **************************
-- Prep
-- After you create the products Audit table, you can comment out the code that creates it
DROP Table IF EXISTS ProductsAudit;
DROP TRIGGER IF EXISTS Products_UPDATE_AUDIT;


-- Build
-- Should have a CREATE TABLE ProductAudit, and CREATE TRIGGER Product_UPDATE_AUDIT statements.
GO
-- Test
UPDATE Products
SET ListPrice = 749.00
WHERE ProductID = 1;
SELECT * FROM ProductsAudit;


-- Clean DROPS any temporary structures, or runs any queries to reset data.
DROP TRIGGER IF EXISTS Products_UPDATE_AUDIT
-- Now revert Products before Test was fired UPDATE Products
SET ListPrice = 699.00
WHERE ProductID = 1;
-- *************************** Script Template **************************

*/


-------------------------Answer from me ------------------------------


USE MyGuitarShop;
GO
-- Prep
IF OBJECT_ID('Products_UPDATE_AUDIT') IS NOT NULL
    DROP TRIGGER Products_UPDATE_AUDIT;
GO

IF OBJECT_ID('ProductsAudit') IS NOT NULL
    DROP TABLE ProductsAudit;
GO

-- Build
CREATE TABLE ProductsAudit(
    [AuditID] [int] IDENTITY(1,1)  NOT NULL, 
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[ProductName] [varchar](255) NOT NULL,
	[ListPrice] [money] NOT NULL,
	[DiscountPercent] [money] NOT NULL,
	[DateAdded] [datetime] NULL);
GO

CREATE TRIGGER Products_UPDATE_AUDIT
	ON Products
    AFTER INSERT,UPDATE
AS
	INSERT INTO ProductsAudit
	SELECT ProductID, CategoryID, ProductCode, ProductName, 
	ListPrice, DiscountPercent, DateAdded FROM inserted
	UPDATE ProductsAudit
	SET DateAdded = GETDATE();
	

-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

-- Prep
-- After you create the products Audit table, you can comment out the code that creates it
DROP Table IF EXISTS ProductsAudit;
DROP TRIGGER IF EXISTS Products_UPDATE_AUDIT;


-- Build
CREATE TABLE ProductsAudit (
AuditID INT PRIMARY KEY IDENTITY,
ProductID INT NOT NULL,
CategoryID INT NOT NULL,
ProductCode VARCHAR(10) NOT NULL,
ProductName VARCHAR(255) NOT NULL,
ListPrice MONEY NOT NULL,
DiscountPercent MONEY NOT NULL DEFAULT 0.00,
DateUpdated DATETIME DEFAULT NULL
);
GO

CREATE TRIGGER Products_UPDATE_AUDIT
ON Products
FOR UPDATE
AS
INSERT INTO ProductsAudit
(ProductID, CategoryID,
ProductCode, ProductName, ListPrice, DiscountPercent, DateUpdated)
VALUES(
(SELECT ProductID FROM deleted),
(SELECT CategoryID FROM deleted),
(SELECT ProductCode FROM deleted),
(SELECT ProductName FROM deleted),
(SELECT ListPrice FROM deleted),
(SELECT DiscountPercent FROM deleted),
GETDATE());

GO

-- Test
UPDATE Products
SET ListPrice = 749.00
WHERE ProductID = 1;

SELECT * FROM ProductsAudit;

-- Clean
DROP TRIGGER IF EXISTS Products_UPDATE_AUDIT
-- Now revert without firing another Trigger
UPDATE Products
SET ListPrice = 699.00
WHERE ProductID = 1;