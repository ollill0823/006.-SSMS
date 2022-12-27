/*

You are collaborating with a product quality team and there is apparently 
a miscoded set of products (2 products) somewhere in the product table.

The information and clue you have is the product list price for each of 
these two products are the same.  Since this happens somewhat frequently 
you need to write a query that finds any products that have the same list price. 
The report should display product name, and list price. It should be sorted 
alphabetically by product name.

HINT: Only the product table is necessary.

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT ProductName, ListPrice FROM Products
ORDER BY ListPrice DESC, ProductName DESC
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT 
     p1.ProductName, p1.ListPrice
FROM 
     Products p1 JOIN Products p2
     ON p1.ProductID <> p2.ProductID 
     AND p1.ListPrice = p2.ListPrice
ORDER BY 
     p1.ProductName
  