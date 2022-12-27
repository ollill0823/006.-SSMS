
/*


Hi Class,

Topic: Procedure

Question: Please create and use a procedure that selects the product 
name and uses the parameter of product id



*/



USE MyGuitarShop;

IF OBJECT_ID(' spProductName') IS NOT NULL
    DROP PROC  spProductName;
GO

-- Build
CREATE PROC  spProductName
    @ProductID INT

AS 
SELECT ProductName FROM Products
WHERE ProductID = @ProductID;
GO


-- Test
EXEC spProductName @ProductID = '10';