/*


You are working together with the fulfillment team in your company, 
and need to generate an Order report. The report should find all orders 
that have not shipped yet. The report should return the Order ID, Order 
Date, and Ship Date.


Hint: No JOIN is necessary, all of the information is in a single table. 
Also, Orders that haven't shipped should have a NULL value.

 

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT OrderID, OrderDate, ShipDate FROM Orders
WHERE ShipDate is null
GO



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT OrderID, 
       OrderDate, 
       ShipDate
FROM Orders
WHERE ShipDate IS NULL