/*

Your security team has brought a request to you. There's been a 
breach in the customer database,
and certain customer passwords need to be reset.
 

The initial criteria is any customer who's last name is between A-M 
(including all names that start with an M) and the first digit 
of the password is a number .
 

For this implementation, break the solution it into two parts
 

Part A: Create a copy of the Customers table (with CustomerID, Password fields) 
for Customers who's last name is between A-M, called CustomersAM with an 
additional column called resetpwd to store the state of whether or not 
the password should be reset. The value
of resetpwd is either 'YES', or 'NO '
 

Part B:
Now create an update statement(s) to update resetpwd to 'YES' for all Customers 
who's first character of the password is a number, and 'NO' for the rest
In order to capture the first character of the password use the LEFT() function  
(Links to an external site.)which is explained in the book or online documentation.




*/





-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO


IF OBJECT_ID('Question6') IS NOT NULL
   DROP TABLE Question6;

--PartA.1 Create a table--
SELECT CustomerID AS CustomersAM, LastName, Password
INTO Question6
FROM Customers

--PartA.2 Create a Column called Resetpwd--
ALTER TABLE Question6 ADD Resetpwd CHAR(3);

--PartB. update YES or NO into Resetpwd--
UPDATE Question6
SET Resetpwd = 'YES'
WHERE LEFT (Password, 1) LIKE '[0-9]' AND
LastName LIKE '[A-M]%'


UPDATE Question6
SET Resetpwd = 'NO'
WHERE Resetpwd IS NULL


ALTER TABLE Question6 DROP COLUMN LastName;



--Version C--
USE MyGuitarShop
GO

IF OBJECT_ID('Question6') IS NOT NULL
   DROP TABLE Question6;

--PartA.1 Create a table--
SELECT CustomerID AS CustomersAM, LastName, Password, 'YesOrNo' AS Resetpwd 
INTO Question6
FROM Customers

--PartB. update YES or NO in Resetpwd & LastName starts from A to M--
UPDATE Question6
SET Resetpwd = 'YES'
WHERE LEFT (Password, 1) LIKE '[0-9]' AND
LastName LIKE '[A-M]%'

UPDATE Question6
SET Resetpwd = 'NO'
WHERE Resetpwd = 'YesOrNo'

ALTER TABLE Question6 DROP COLUMN LastName;

--Version B--
USE MyGuitarShop
GO

IF OBJECT_ID('Question6') IS NOT NULL
   DROP TABLE Question6;

--PartA.1 Create a table--
SELECT CustomerID AS CustomersAM, Password, 'YesOrNo' AS Resetpwd 
INTO Question6
FROM Customers

--PartB.1. update YES in Resetpwd that LastName starts 
--         from A to M and the first password starts from 0 to 9--
UPDATE Question6
SET Resetpwd = 'YES'
WHERE CustomersAM IN 
	(SELECT CustomerID
	FROM Customers
	WHERE LEFT(Password, 1) LIKE '[0-9]' AND
		LastName LIKE '[A-M]%');
--PartB.2. update NO in the rest column of the Resetpwd--
UPDATE Question6
SET Resetpwd = 'NO'
WHERE Resetpwd = 'YesOrNo'


--Version C--
USE MyGuitarShop
GO

IF OBJECT_ID('Question6') IS NOT NULL
   DROP TABLE Question6;

--PartA.1 Create a table--
SELECT CustomerID AS CustomersAM, Password, 'YesOrNo' AS Resetpwd 
INTO Question6
FROM Customers

--PartB.1. update YES in Resetpwd that LastName starts 
--         from A to M and the first password starts from 0 to 9--
UPDATE Question6
SET Resetpwd = 'YES'
WHERE CustomersAM IN 
	(SELECT CustomerID
	FROM Customers
	WHERE LEFT(Password, 1) LIKE '[0-9]' AND
		LastName LIKE '[A-M]%');
--PartB.2. update NO in the rest column of the Resetpwd--
UPDATE Question6
SET Resetpwd = 'NO'
WHERE Resetpwd = 'YesOrNo'



--Version A--
USE MyGuitarShop
GO

IF OBJECT_ID('Question6') IS NOT NULL
   DROP TABLE Question6;

--PartA.1 Create a table--
SELECT CustomerID AS CustomersAM, Password, 'YesOrNo' AS Resetpwd 
INTO Question6
FROM Customers
WHERE LastName LIKE '[A-M]%'

--PartB.1. update YES in Resetpwd that LastName starts 
--         from A to M and the first password starts from 0 to 9--
UPDATE Question6
SET Resetpwd = 'YES'
WHERE CustomersAM IN 
	(SELECT CustomerID
	FROM Customers
	WHERE LEFT(Password, 1) LIKE '[0-9]' );

--PartB.2. update NO in the rest column of the Resetpwd--
UPDATE Question6
SET Resetpwd = 'NO'
WHERE Resetpwd = 'YesOrNo'




Version A: Follow the tips (303 rows, but in reality, I will not suggest doing that, because I will drop all the no need rows or keep all the no need ones)
Version B: All the rows remain from the mother table (The first version I answered, but I am not sure
           if ALTER function is suitable to use in this quiz)
Version C: Follow the tips (All the rows remain from the mother table )






-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

-- Adding a drop table to ensure it runs multiple times.
Drop TABLE IF EXISTS CustomersAM;

-- Part A: Extract Customers A-M into CustomersAM
SELECT
  CustomerID,
  [Password],
  'NO ' AS resetpwd
INTO
  CustomersAM from Customers
WHERE
  LastName < 'N'

-- Part B:Update resetpwd 
UPDATE
  CustomersAM
SET
  resetpwd = 'YES'
WHERE
  LEFT([Password],1) IN ('0','1','2','3','4','5','6','7','8','9')