USE MyGuitarShop
GO

-- Test
UPDATE Products
SET ListPrice = 749.00
WHERE ProductID = 1;
SELECT * FROM ProductsAudit;
GO  

-- Clean
DROP TRIGGER IF EXISTS Products_UPDATE_AUDIT
-- Now revert Products before Test was fired UPDATE Products
SET ListPrice = 749.00;
WHERE ProductID = 1;


