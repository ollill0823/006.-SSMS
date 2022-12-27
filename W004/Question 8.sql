/*

You are working with the customer loyalty team and have been asked to create 
a report. The report should include the Customer's ID along with the number of 
days since their most recent order (call it SinceLastOrder). Additionally, 
the report should only include customers who's SinceLastOrder exceeds 640 days, 
and should be executed in a single statement.
 

HINT:
#1 In order to calculate the # of days since the last order, you'll need to 
use the current date. Use GETDATE()  (Links to an external site.)which gets 
the current date.
 
#2 Customers may have more than one order, so we're only looking for the most 
recent order (e.g. use OrderDate)
#3 Consider using a MIN() or MAX() function in the HAVING clause.. Note: this 
isn't the only way to query the data.




*/





-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO
SELECT CustomerID, DATEDIFF(day, MAX(OrderDate), GETDATE()) 
	AS SinceLastOrder
FROM Orders
GROUP BY CustomerID
HAVING DATEDIFF(day, MAX(OrderDate), GETDATE())  > 640




-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
  CustomerID,
  MIN(CONVERT(INT, CAST(GETDATE() - o.OrderDate as DATETIME))) AS SinceLastOrder
FROM
  Orders o
GROUP BY
  CustomerID
HAVING
  MIN(CONVERT(INT, CAST(GETDATE() - o.OrderDate as DATETIME))) >640