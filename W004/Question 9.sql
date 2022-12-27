/*

Building off of the previous question, the loyalty team now wants 
some additional information

on the report.

 

The new Order report calculate the Avg number of days since the 
last Order for each City where there are customers 
(e.g. there's at least 1 corresponding customer record in the Customers table).

 

The report should display the City name, and the avg number of days since 
the last order (AvgSinceLastOrder), and it should be sorted alphabetically 
by City name. Additionally, the report should only include customers who's 
SinceLastOrder exceeds 640 days, and should be executed in a single statement

 

HINT:

Use the previous question's query and  incorporate as a derived table 
into your query (e.g. in the from clause instead of a table, use the 
(sql statement) in the previous question.
Many customers have multiple addresses. Given we are looking at the city, 
it's ok if the per city average draws upon data for customers that are in 
multiple locations.




*/





-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO
SELECT Orders.CustomerID, City, OrderDate, GETDATE() AS Now, 
DATEDIFF(day, OrderDate, GETDATE()) AS TimeGap
FROM Orders JOIN Addresses
ON Orders.CustomerID = Addresses.CustomerID


--Question8--
USE MyGuitarShop
GO
SELECT CustomerID, DATEDIFF(day, MAX(OrderDate), GETDATE()) 
	AS SinceLastOrder
FROM Orders
GROUP BY CustomerID
HAVING DATEDIFF(day, MAX(OrderDate), GETDATE())  > 640

--Question9 final--
USE MyGuitarShop
GO
SELECT City, AVG(SinceLastOrder) AS AvgSinceLastOrder
FROM Addresses JOIN
		(SELECT CustomerID, DATEDIFF(day, MAX(OrderDate), GETDATE()) 
	AS SinceLastOrder
	FROM Orders
	GROUP BY CustomerID
	HAVING DATEDIFF(day, MAX(OrderDate), GETDATE())  > 640 ) AS DayOfLastOrder
	ON Addresses.CustomerID = DayOfLastOrder.CustomerID
	GROUP BY City
ORDER BY City

















--Question9 test1--
USE MyGuitarShop
GO
SELECT Orders.CustomerID, City,
	DATEDIFF(day, MAX(OrderDate), GETDATE()) AS SinceLastOrder 
FROM Orders JOIN Addresses
ON Orders.CustomerID = Addresses.CustomerID
GROUP BY City, Orders.CustomerID
HAVING DATEDIFF(day, MAX(OrderDate), GETDATE()) >640
ORDER BY City




-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
  a.City,
  AVG(lo.SinceLastOrder) AS AvgSinceLastOrder
FROM
  (SELECT
    CustomerID,
    MIN(CONVERT(INT, CAST(GETDATE() - o.OrderDate as DATETIME))) AS  SinceLastOrder
FROM
  Orders o
GROUP BY
  CustomerID
HAVING
  MIN(CONVERT(INT, CAST(GETDATE() - o.OrderDate as DATETIME))) >640
) lo
INNER JOIN
  Addresses a ON a.CustomerID = lo.CustomerID
GROUP BY
  City
ORDER BY
  City ASC