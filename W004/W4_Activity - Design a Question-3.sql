USE AP
GO
IF OBJECT_ID('OverDue') IS NOT NULL
   DROP TABLE OverDue;

WITH Summary AS 
(
SELECT Invoices.VendorID, LastName, FirstName, InvoiceTotal, PaymentTotal, CreditTotal, InvoiceDueDate
, PaymentDate
FROM Invoices LEFT JOIN ContactUpdates
ON Invoices.VendorID = ContactUpdates.VendorID 
)
SELECT * 
INTO OverDue 
FROM Summary;

INSERT INTO OverDue
VALUES (999, 'Lebron', 'James', 987.00, 987.00, 0.00, '2022-04-22', '2022-04-24')

UPDATE OverDue
SET PaymentDate = '2022-12-31'
WHERE PaymentDate IS NULL

SELECT *
FROM OverDue
ORDER BY PaymentDate DESC