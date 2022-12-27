/*


Again, working with the Fulfillment team, you now need to generate an 
Order report specific to the order items.

The report should have the following fields: Item ID, Item price, 
amount of discount, quantity of items ordered, *total price, *discount total, 
and *item total.

* - Use the following fields names for the report's output, and calculate 
them with the described formula

PriceTotal  = multiplying the item price by the quantity

DiscountTotal =  multiplying the discount amount by the quantity

ItemTotal = subtracting the discount amount from the item price and then
multiplying by the quantity


The report should only return Order items where the ItemTotal is >500, 
and sort the report by item total in descending order.
 

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT ItemID, ItemPrice, DiscountAmount, Quantity, ItemPrice*Quantity AS PriceTotal, DiscountAmount*Quantity AS DiscountTotal, 
(ItemPrice - DiscountAmount)*Quantity AS ItemTotal FROM OrderItems
WHERE (ItemPrice - DiscountAmount)*Quantity > 500
ORDER BY ItemTotal DESC
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT 
     ItemID, ItemPrice, DiscountAmount, Quantity, 
     ItemPrice * Quantity AS PriceTotal, 
     DiscountAmount * Quantity AS DiscountTotal, 
    (ItemPrice - DiscountAmount) * Quantity AS ItemTotal
FROM 
     OrderItems
WHERE 
     (ItemPrice - DiscountAmount) * Quantity > 500
ORDER BY 
     ItemTotal DESC