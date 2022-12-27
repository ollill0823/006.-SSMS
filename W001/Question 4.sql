USE MyGuitarShop
GO
SELECT ProductName, ListPrice, CategoryName
FROM Products AS PD JOIN Categories AS CA
ON PD.CategoryID = CA.CategoryID
ORDER BY CategoryName DESC, ProductName DESC
GO







SELECT * FROM Products
SELECT * FROM Categories