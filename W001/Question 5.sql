USE MyGuitarShop
GO
SELECT FirstName, LastName, Line1, City, State, ZipCode 
FROM Customers JOIN Addresses
ON  Customers.CustomerID = Addresses.CustomerID
GO










SELECT * FROM Customers
SELECT * FROM Addresses