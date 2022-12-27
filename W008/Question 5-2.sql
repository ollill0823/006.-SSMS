
-- Test 
USE MyGuitarShop;
GO

BEGIN TRY
    DECLARE @ProductID INT;
    EXEC @ProductID = spInsertProduct
		 @CategoryID = 2,
         @ProductCode = '786',
		 @ProductName = '47',
		 @Description = '',
		 @ListPrice = 1238.00,
		 @DiscountPercent = 1.500;	 

    PRINT 'Row was inserted.'; 
    PRINT 'New ProductID: ' + CONVERT(varchar, @ProductID);
END TRY
BEGIN CATCH
    PRINT 'An error occurred. Row was not inserted.';
    PRINT 'Error number: ' + CONVERT(varchar(100), ERROR_NUMBER());
    PRINT 'Error message: ' + CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH;
GO


-- Clean 
DELETE FROM Products where ProductName = '47';