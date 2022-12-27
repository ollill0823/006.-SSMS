USE MyGuitarShop
GO
SELECT LastName, FirstName, ShippingAddressID AS AddressID FROM Customers
INTERSECT
SELECT LastName, FirstName, BillingAddressID AS AddressID FROM Customers
GO


SELECT * FROM Customers


USE MyGuitarShop
GO
SELECT LastName, FirstName, ShippingAddressID AS AddressID FROM Customers
EXCEPT
SELECT LastName, FirstName, BillingAddressID AS AddressID FROM Customers
GO
