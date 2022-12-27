USE AP;
GO

CREATE FUNCTION fnState
(@VendorState varchar(5)) 
RETURNS table

RETURN (SELECT Vendors.VendorID, VendorName, LastName, FirstName, VendorState 
        FROM Vendors JOIN ContactUpdates
        ON Vendors.VendorID = ContactUpdates.VendorID
        WHERE VendorState = @VendorState);
GO

SELECT * FROM fnState('CA');