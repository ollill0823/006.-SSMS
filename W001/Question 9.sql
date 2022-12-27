USE MyGuitarShop
GO
SELECT LastName + ', '+ FirstName AS FullName FROM Customers
WHERE LastName LIKE '[M-Z]%'
ORDER BY FullName ASC
GO


SELECT * FROM Customers


