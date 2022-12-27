/*

You are working with the Merchandising team on adding some more quality controls. The quality controls are implemented using  (TRY CATCH statements) with some additional Error messaging handling. You decide to add some controls on inserting new categories.

Write a script that INSERTS a row into the Categories table. It uses DECLARED variable  @CatName  at the beginning which is assigned a name of the Category that is passed to the INSERT statement.

The script should use a TRY CATCH block wrapped around the insertion, and perform the appropriate action depending on whether it's successful or not.

 

If the insert is successful, the script should display this message:

"SUCCESS: Record was inserted."

 

If the update is unsuccessful, the script should display a message something 
like this:

FAILURE: Record was not inserted.

Error 2627: Violation of UNIQUE KEY constraint 'XXXXX'.

Cannot insert duplicate key in object 'dbo.Categories'. The duplicate key 
value is (<the category name>).

 

Here's a rough sketch of the script. Note this is not valid SQL

-- DECLARE variables
-- SET variables
-- TRY Block
--     INSERT statement
--     PRINT message
---    DELETE statement (Optional revert by deleting newly added data)
-- END TRY block
--
-- BEGIN CATCH block
-- PRINT something
-- END CATCH block



*/


-------------------------Answer from me ------------------------------


USE MyGuitarShop;
GO


DECLARE @CatName varchar(80);
SET @CatName = 'Toy';

BEGIN TRY
	INSERT Categories
	VALUES (@CatName);
	PRINT 'SUCCESS: Record was inserted.';
	DELETE FROM Categories WHERE CategoryName = @CatName;
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.';
    PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) 
        + ': ' + ERROR_MESSAGE();
END CATCH;


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

DECLARE @CatName varchar(50)
-- Test : "Trumpets" success, "Guitars" unsuccessful
SET @CatName = 'Trumpets'

BEGIN TRY
INSERT Categories (CategoryName)
VALUES (@CatName);
PRINT 'SUCCESS: Record was inserted.';
-- Optional to revert data back to original state.
DELETE FROM Categories WHERE CategoryName=@CatName
END TRY


BEGIN CATCH
PRINT 'FAILURE: Record was not inserted.';
PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1)
+ ': ' + ERROR_MESSAGE();
END CATCH;