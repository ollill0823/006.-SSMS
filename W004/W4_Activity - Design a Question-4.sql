/*

Hi Class,

Topic: Date calculation, Create table, delete column

 

From the Invoices table from AP databases, Create a new table called OverDue 
that contains VendorID, InvoiceTotal, 
PaymentDate, PaymentTotal, CreditTotal, InvoiceDueDate, PaymentDate,  
and order by InvoiceTotal from the biggest to the smallest. Then Insert 
a new row that contains as below data:

VendorID	999
InvoiceTotal	987
PaymentTotal	987
CreditTotal	0.00
InvoiceDueDate	2022-04-22
PaymentDate	2022-04-24
Finally, change the PaymentDate column to '2022-12-31' when the data is null.

 

Hint: 

Use Insert Function to create a new table.
Find a way to only include specified columns (two ways at least: Drop the no need column or use subquery)
 
 */


USE AP
GO
IF OBJECT_ID('OverDue') IS NOT NULL
   DROP TABLE OverDue;


SELECT Invoices.VendorID, LastName, FirstName, InvoiceTotal, PaymentTotal, CreditTotal, InvoiceDueDate
, PaymentDate
INTO OverDue
FROM Invoices LEFT JOIN ContactUpdates
ON Invoices.VendorID = ContactUpdates.VendorID 

INSERT INTO OverDue
VALUES (999, 'Lebron', 'James', 987.00, 987.00, 0.00, '2022-04-22', '2022-04-24')

UPDATE OverDue
SET PaymentDate = '2022-12-31'
WHERE PaymentDate IS NULL

SELECT *
FROM OverDue
ORDER BY PaymentDate DESC