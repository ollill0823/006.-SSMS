/*

To build on Question #2 you are asked to create a shipping report for Orders. 
The report should display the Order ID and Order date. 
It also should should display a new field named ShipStatus which is either 
'Shipped' or 'NOT Shipped' depending on whether the Ship date is NULL or not. 

Hint: Consider using a UNION to construct the query.

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT OrderID, OrderDate, 'Shipped' AS ShipStatus FROM Orders
WHERE ShipDate is not null
UNION
SELECT OrderID, OrderDate, 'Not Shipped' AS ShipStatus FROM Orders
WHERE ShipDate is null
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

  SELECT 
     'SHIPPED' AS ShipStatus, 
      OrderId, OrderDate
  FROM 
      Orders
  WHERE 
      ShipDate IS NOT NULL
UNION
  SELECT 
     'NOT SHIPPED', OrderID, OrderDate
  FROM
     Orders
  WHERE 
     ShipDate IS NULL
  