/*

You've been asked build a product report that illustrates potential 
sold inventory for each product. The report should display the product name, 
and the (productTotal) which is defined as the (item price - discount amount) 
* quantity. Additionally the report needs to display at the bottom (last row), 
the Product total for all productTotals in the report, and the report will be 
ordered by ProductTotal in ascending order




*/





-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT ProductName, SUM((ItemPrice-DiscountAmount)*Quantity) AS ProductTotal
FROM OrderItems JOIN Products
	ON OrderItems.ProductID = Products.ProductID
GROUP BY ProductName WITH CUBE
ORDER BY ProductTotal ASC;


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
  ProductName,
  SUM((ItemPrice - DiscountAmount) * Quantity) AS ProductTotal
FROM
  Products p
JOIN
  OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY
  ProductName WITH ROLLUP
ORDER BY
  ProductTotal ASC