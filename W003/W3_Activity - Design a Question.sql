/*

In the Ingredients database, Please provide the number of the ingriendID's 
but add 2 to the sum. I want to group these by the ID so please find a way 
to do that. 

*/



USE AP
GO
SELECT DISTINCT VendorID, 
SUM(InvoiceTotal) OVER (PARTITION BY VendorID) +2 AS sum
FROM Invoices
ORDER BY VendorID