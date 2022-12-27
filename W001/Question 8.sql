USE MyGuitarShop
GO
SELECT OrderID, OrderDate, 'Shipped' AS ShipStatus FROM Orders
WHERE ShipDate is not null
UNION
SELECT OrderID, OrderDate, 'Not Shipped' AS ShipStatus FROM Orders
WHERE ShipDate is null
GO


SELECT * FROM Orders