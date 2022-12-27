USE AP
GO
SELECT *
INTO OverDue
FROM Invoices 
ORDER BY InvoiceTotal DESC 
USE AP
ALTER TABLE OverDue DROP COLUMN [InvoiceNumber], [InvoiceDate], [InvoiceID], 
[TermsID]

INSERT INTO OverDue
VALUES ( 999, 987.00, 987.00, 0.00, '2022-04-22', '2022-04-24')

UPDATE OverDue
SET PaymentDate = '2022-12-31'
WHERE PaymentDate IS NULL

SELECT *
FROM OverDue
ORDER BY PaymentDate DESC






