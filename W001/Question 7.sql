USE MyGuitarShop
GO
SELECT CategoryName, ProductID
FROM Categories LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID
GO





SELECT * FROM Categories
SELECT * FROM Products