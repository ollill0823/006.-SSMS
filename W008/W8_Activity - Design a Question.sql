/*

Topic: Create a function and use a function

Using the AP database to create a function and then using the function to 
find VendorState = 'CA' information.

Hint: 

* The data should retrieve VendorID, VendorName, LastName, FirstName, and 
VendorState.
* You can check function introduction on page 480~481
* Share another coding that did not use function : 
        SELECT Vendors.VendorID, VendorName, LastName, FirstName, VendorState 
        FROM Vendors JOIN ContactUpdates
        ON Vendors.VendorID = ContactUpdates.VendorID
        WHERE VendorState = 'CA'

		*/




USE AP;

IF OBJECT_ID('fnVendorState') IS NOT NULL
    DROP FUNCTION fnVendorState;
GO

CREATE FUNCTION fnVendorState
    (@VendorState varchar(50) NULL)
    RETURNS TABLE
RETURN
	(SELECT Vendors.VendorID, VendorName, LastName, FirstName, VendorState 
	FROM Vendors JOIN ContactUpdates
	ON Vendors.VendorID = ContactUpdates.VendorID
	WHERE VendorState = @VendorState);
GO

USE AP;
SELECT * FROM dbo.fnVendorState('CA');



SELECT Vendors.VendorID, VendorName, LastName, FirstName, VendorState 
	FROM Vendors JOIN ContactUpdates
	ON Vendors.VendorID = ContactUpdates.VendorID
	WHERE VendorState = 'CA'