/*

Again, you are working with the product quality team, 
but this time you're trying to find all categories that have no product 
assigned to them. The report should have the category name, and the product id.  
The query will need to use some type of JOIN.

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT CategoryName, ProductID
FROM Categories LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT 
     c.CategoryName, p.ProductID
FROM 
     Categories c LEFT JOIN Products p
     ON c.CategoryID = p.CategoryID
WHERE 
     p.ProductID IS NULL;
  