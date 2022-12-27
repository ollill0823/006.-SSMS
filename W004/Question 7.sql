/*

 Use the existing CustomersAM table created in the earlier question 
 (e.g. you'll just amend the above change).
 
After you've made the change from the previous question, the security team 
has asked you to do another MERGE pass to amend the CustomerAM with 
'YES' flags for any Customers with a hotmail email address 
(eg. ending with "@hotmail.com") . In implementing this solution use a single 
MERGE statement to update the CustomersAM table appropriately.
 
 
HINT: As with the previous problem's use of LEFT() (Links to an external site.), 
use the RIGHT() f (Links to an external site.)unction to extract the 
right pattern for hotmail email addresses.




*/





-------------------------Answer from me ------------------------------
--version A--
USE MyGuitarShop
GO

UPDATE Question6
SET Resetpwd = NULL
WHERE Resetpwd IS NOT NULL


MERGE INTO Question6 AS Q
USING Customers AS C
ON Q.CustomersAM = C.CustomerID
WHEN MATCHED AND 
		RIGHT (C.EmailAddress, 12) LIKE '@hotmail.com'
	THEN 
	UPDATE SET
		Q.Resetpwd = 'YES';

UPDATE Question6
SET Resetpwd = 'NO'
WHERE Resetpwd IS NULL

--version B--
USE MyGuitarShop
GO

MERGE INTO Question6 AS Q
USING Customers AS C
ON Q.CustomersAM = C.CustomerID
WHEN MATCHED AND 
		Q.Resetpwd = 'YES' AND
		RIGHT (C.EmailAddress, 12) LIKE '@hotmail.com'
	THEN 
	UPDATE SET
		Q.Resetpwd = 'YES';









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




-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


MERGE
  CustomersAM cam
Using
  Customers cu
ON
  cam.CustomerID = cu.CustomerID
WHEN MATCHED AND
  RIGHT(cu.EmailAddress,12)='@hotmail.com'
THEN
  UPDATE SET
  cam.resetpwd = 'YES';