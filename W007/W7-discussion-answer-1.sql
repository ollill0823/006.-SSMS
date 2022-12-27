/*

Hi Class,

Topic: sql script

Question: Please write a sql script to show latest orderdate/ earliest 
orderdate/ number of orders for customerid is 4.
*/




USE MyGuitarShop
GO

DECLARE @Customer INT;
DECLARE @LastOrderDate DATE, @OldestOrderDate DATE;


SET @Customer = 4;
SELECT @LastOrderDate = MAX(OrderDate), @OldestOrderDate = MIN(OrderDate)
FROM Orders
WHERE CustomerID = @Customer;


PRINT 'Customer ID = ' + Convert(varchar, @Customer) + ', the oldest order date is on ' + Convert(varchar, @OldestOrderDate) + ';';
PRINT 'the latest order date is on ' + Convert(varchar, @LastOrderDate) + '.';
