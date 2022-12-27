/*

You have some time to go back and optimize some of your previous 
reporting queries. Looking at some past work, you decide to create a 
function fnDiscountPrice which calculates the discount price of an item in 
the OrderItems table (discount amount subtracted from item price). The function 
has one parameter, @itemID (of type INT) and returns the value (of type MONEY) 
of the discount price for that item (itemID). 

 

Your answer should have the following (3) sections (Use the -- to delineate 
each section in your response)

--- Answer Sections ---
-- Prep [any specific statements that prepare the subsequent steps 
(e.g. DROP TABLES that may exist]
-- Build ((The core part of the answer (CREATE FUNCTION,etc..))
-- Validate (A simple SQL statement to view the results, so you can validate if 
the Build statement is correct. This is where you'd use a SELECT statement that 
references the above FUNCTION created where you can validate it's executing 
correctly.

 

Here's a template you can use for the script. You'll fill in the build section

-- ******* Template for Script *****
-- Prep
DROP FUNCTION IF EXISTS fnDiscountPrice;
GO

 
-- Build  (this is where you CREATE the function dbo.fnDiscountPrice

-- Validate

SELECT ItemID, ItemPrice, DiscountAmount,
dbo.fnDiscountPrice(ItemID) AS DiscountPrice
FROM OrderItems;

-- Clean up (optional)

-- ******* Template for Script *****

*/


-------------------------Answer from me ------------------------------


USE MyGuitarShop;

-- Prep
IF OBJECT_ID('fnDiscountPrice') IS NOT NULL
    DROP FUNCTION fnDiscountPrice;
GO

-- Build
CREATE FUNCTION fnDiscountPrice
	(@itemID int = 0)
    RETURNS money
BEGIN
	RETURN (SELECT ItemID
		FROM OrderItems WHERE ItemID = @itemID);
END;
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

-- Prep
DROP FUNCTION IF EXISTS fnDiscountPrice;
GO

-- Build
CREATE FUNCTION fnDiscountPrice
(
@ItemID INT
)
RETURNS MONEY
BEGIN
DECLARE @DiscountPrice MONEY;
SELECT @DiscountPrice = ItemPrice - DiscountAmount
FROM OrderItems
WHERE ItemID = @ItemID;
RETURN @DiscountPrice;
END;
GO


-- Validate
SELECT ItemID, ItemPrice, DiscountAmount,
dbo.fnDiscountPrice(ItemID) AS DiscountPrice
FROM OrderItems;

-- Clean up (optional)