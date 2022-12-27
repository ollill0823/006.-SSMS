USE MyGuitarShop
GO
SELECT CASE
		WHEN GROUPING(CategoryName) = 1 THEN 'All'
		ELSE CategoryName
	END AS Category,
	COUNT(*) AS ProductsCount
FROM Products JOIN Categories 
ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName WITH ROLLUP


USE MyGuitarShop
GO
SELECT CategoryID, CategoryName
FROM Categories

SELECT CategoryID
FROM Products