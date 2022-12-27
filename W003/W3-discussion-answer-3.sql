/*

Topic: Summary Query using OVER Clause

Question: Please provide the total payment count and total payment 
amount and to each vendor. Please use OVER clause instead of GROUP BY clause

*/



USE AP
GO
SELECT DISTINCT Vendorname,
COUNT(PaymentTotal) OVER (PARTITION BY Invoices.VendorID) AS PaymentCount,
SUM(PaymentTotal) OVER (PARTITION BY Invoices.VendorID) AS PaymentSum

FROM Vendors JOIN Invoices
ON Vendors.VendorID = Invoices.VendorID