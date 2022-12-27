USE MyGuitarShop
GO
SELECT OrderID, OrderDate, ShipDate FROM Orders
WHERE ShipDate is null
GO


use MyGuitarShop
go
SELECT OrderID, OrderDate, ShipDate FROM Orders
WHERE ShipDate is not null
