/*

Rewrite the answer to the previous question.
If you previously used a ROLLUP/CUBE approach, rewrite it with a CTE. 
Note the CTE doesn't add a summary row at the bottom. You'll want to 
use a UNION clause to append a summary row at the bottom of the table.
 
If you wrote it with a CTE, use a ROLLUP/CUBE, and a ROLLUP already 
includes the summary, so it isn't needed.
 



*/





-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO
WITH Rawdata AS
(
	SELECT ProductName, SUM((ItemPrice-DiscountAmount)*Quantity) AS ProductTotal
	FROM OrderItems JOIN Products
	ON OrderItems.ProductID = Products.ProductID
	GROUP BY ProductName
)
	SELECT * FROM Rawdata
UNION
	SELECT NULL AS ProductName, SUM(ProductTotal) AS ProductTotal
	FROM Rawdata
ORDER BY ProductTotal;


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


WITH grand_total as
(
SELECT
  NULL as ProductName,
  SUM((ItemPrice - DiscountAmount) * Quantity) as ProductTotal
FROM
  Products p JOIN OrderItems oi
ON
  p.ProductID = oi.ProductID
)
SELECT
  ProductName,
  SUM((ItemPrice - DiscountAmount) * Quantity) as ProductTotal
FROM
  Products p JOIN OrderItems oi
ON
  p.ProductID = oi.ProductID
GROUP BY
  ProductName
UNION
SELECT
  *
FROM
  grand_total
ORDER BY
  ProductTotal ASC