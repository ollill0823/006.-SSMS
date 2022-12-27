/*

Hi classmates:

Topic: Leave a message, PRINT, and Create a local variable

Question: Write a code to leave a message that prints out as the below picture:


Hint:

* Use Database AP.
* Vendor ID = 123.
* The picture uses five local variables:  Invoices (VendorID = 123, SUM of 
InvoiceTotal = $4378.02, the oldest date of InvoiceDate (2015-12-10), 
the latest date of InvoiceDate (2016-04-02) ); Vendors ( Vendor name )
* Use the convert function to transfer the date to varchar; the below 
picture includes many examples for converting.

*/

USE AP
GO

DECLARE @Vendornumber int, @MAXInvoiceDate date, @MINInvoiceDate date;
DECLARE @SUMInvoiceTotal money;
DECLARE @VendorName varchar(20);

SET @Vendornumber = 123
SELECT @MAXInvoiceDate = MAX(InvoiceDate), @MINInvoiceDate = MIN(InvoiceDate),
@SUMInvoiceTotal = SUM(InvoiceTotal)
FROM Invoices 
WHERE VendorID = @Vendornumber;

SET @VendorName = (SELECT VendorName FROM Vendors WHERE VendorID = @Vendornumber);


PRINT 'VendorID : ' + CONVERT(varchar, @Vendornumber,1) + ', Name : ' + CONVERT(varchar, @VendorName,1) + ', earn $' + CONVERT(varchar, @SUMInvoiceTotal,1) + ' from ' + CONVERT(varchar, @MINInvoiceDate,23) + ' to ' + CONVERT(varchar, @MAXInvoiceDate,23) + ' .'

