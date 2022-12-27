USE MyGuitarShop;
GO
/*
--Valid
SELECT ItemID, ItemPrice, DiscountAmount,
dbo.fnDiscountPrice(ItemID) AS DiscountPrice
FROM OrderItems
GO
*/
-- Valid
USE MyGuitarShop;
GO

SELECT (ItemPrice-DiscountAmount) AS DiscountPrice
FROM OrderItems WHERE ItemID = dbo.fnDiscountPrice(2);