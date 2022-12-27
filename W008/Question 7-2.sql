USE MyGuitarShop
GO

-- Test1 (DiscountPercent = '0.40')
Insert Products
VALUES ('1', 'superwoman', 'basketball', 'GOGO', '500.23', '0.40', GETDATE());
GO

-- Test2 (DiscountPercent = '100.40')
Insert Products
VALUES ('1', 'superwoman', 'basketball', 'GOGO', '500.23', '100.40', GETDATE());
GO

-- Test3 (DiscountPercent = '-0.40')
Insert Products
VALUES ('1', 'superwoman', 'basketball', 'GOGO', '500.23', '-0.40', GETDATE());
GO

-- Test4 (DiscountPercent = '50.40')
Insert Products
VALUES ('1', 'superwoman', 'basketball', 'GOGO', '500.23', '50.40', GETDATE());
GO

-- Clean 
DELETE FROM Products where ProductName = 'basketball';