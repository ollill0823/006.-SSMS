/*

Topic: SQL Scripts

Question: In the AP database, please write a script that prints the following:

1. The vendor name of the highest invoice and the invoice amount.

2. The full mailing address of that vendor.


*/




USE AP
GO

DECLARE @VendorID int, @VendorName varchar(15), @HighestInvoice MONEY, @Address varchar(60);

SET @HighestInvoice = (SELECT MAX(InvoiceTotal) FROM Invoices);
SET @VendorID = (SELECT VendorID FROM Invoices 
    WHERE InvoiceTotal = @HighestInvoice );
SELECT @VendorName = VendorName, @Address = VendorAddress1 + ', ' + VendorAddress2
FROM Vendors
WHERE VendorID = @VendorID


PRINT 'Vendor Name: ' + CONVERT(varchar, @VendorName) + ', Invoice amount: ' + CONVERT(varchar, @HighestInvoice);
PRINT 'Mailing address: ' + CONVERT(varchar, @Address);