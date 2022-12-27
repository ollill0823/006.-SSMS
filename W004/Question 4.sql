/*


You've been asked to create a Tax collection report. The report should have 
the Order date,
Order ID, Order TaxAmount, and a running total that keeps track of the 
total tax collected
called (runningTaxCollection)
The runningTaxCollection field is calculated by adding the row's TaxAmount 
and + previous row's TaxAmount,
creating a cumulative (or running tax amount).
 

The report should be ordered by Order date in ascending order.



*/





-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO
SELECT OrderDate, OrderID, TaxAmount, 
	SUM(TaxAmount) OVER (ORDER BY OrderDate) AS runningTaxCollection
FROM Orders
ORDER BY OrderDate ASC;



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
  OrderDate,
  OrderID,
  TaxAmount,
  SUM(TaxAmount) OVER (ORDER BY OrderDate) AS runningTaxCollection
FROM
  Orders