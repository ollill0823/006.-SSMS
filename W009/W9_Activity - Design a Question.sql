/*

Hi classmates,

Topic: delay function, Transactions, Save function:

Question: Use the Categories table (MyGuitarShop) to create a transaction to insert data.

 

Hint:

	1. First saves CategoryName = 'Superman', then saves CategoryName = 'Stars'

	2. Before committing the data, you set two extra functions:
	you consider CategoryName = 'Stars' is not good, so you decide to roll back 
	to only add CategoryName = 'Superman'.
		To avoid concurrency in using the same table, you set a 2hrs time delay to 
		complete the code.
	3. After completing 2, commit the transaction.

	4. the final table will be as the below:

CategoryID	CategoryName
2	Basses
3	Drums
1	Guitars
4	Keyboards
5	Superman
 


USE MyGuitarShop;
GO

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

BEGIN TRAN;
INSERT Categories
	VALUES('Superman');
	SAVE TRAN Categories1;

	INSERT Categories
	VALUES('Stars');
	SAVE TRAN Categories2;

	WAITFOR DELAY '00:00:05';

	ROLLBACK TRAN Categories1;

COMMIT TRAN;


SELECT * FROM Categories

/* Delete the Created row
DELETE Categories WHERE CategoryName = 'Superman';

