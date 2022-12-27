/*


You are working with your product inventory team. 
They've asked you to develop a report that is comprised of the 
name of the Category along with the number of Products (called ProductCount), 
and the amount of the most expensive list price item (called MostExpensiveProduct) 
for each category. The report should be sorted by the ProductCount 
in descending order.



*/





-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO
SELECT CategoryName, Count(*) AS ProductCount,
	Max(ListPrice) AS MostExpensiveProduct
FROM Products JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName
ORDER BY ProductCount DESC;



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
   CategoryName,
  COUNT(*) AS ProductCount,
  MAX(ListPrice) AS MostExpensiveProduct
FROM
  Categories c JOIN Products p
ON
  c.CategoryID = p.CategoryID
GROUP BY
  CategoryName
ORDER BY
  ProductCount DESC