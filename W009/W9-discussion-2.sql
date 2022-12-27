/*


Topic: Transactions

Question: Using the MyGuitarShop database, create a transaction that 
contains two insert statements. One insert statement will enter a new 
category 'Violins' into the categories table. The other statement will 
enter a new product with the violin category. Please enter the transaction 
in a try block. In the catch block, please use a rollback statement.



*/





USE MyGuitarShop;
GO

DECLARE @CategoryID INT;
BEGIN TRY
	BEGIN TRAN;
	INSERT Categories VALUES('Violins');
	SAVE TRAN CATE1;
	
	SET @CategoryID  = @@IDENTITY;
	
	INSERT Products	VALUES ( @CategoryID, 'Stentor', 'Fiddle', 'Good violin', '1000.00', '20.00', GETDATE());
	SAVE TRAN PROD1;


END TRY
BEGIN CATCH
	ROLLBACK TRAN;
	COMMIT TRAN;
END CATCH;



/* Delete createing data
DELETE Products WHERE ProductName = 'Fiddle';
DELETE Categories WHERE CategoryName = 'Violins';