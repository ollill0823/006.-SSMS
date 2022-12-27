/*

TOPIC: Code Function

QUESTION:  In AP database, create a scalar-valued function named 
fnRecentUnpaidInvoiceID that returns the InvoiceID of the latest 
invoice with unpaid balance

*/



 

USE AP;

IF OBJECT_ID(' fnRecentUnpaidInvoiceID') IS NOT NULL
    DROP FUNCTION  fnRecentUnpaidInvoiceID;
GO

-- Build
CREATE FUNCTION  fnRecentUnpaidInvoiceID()
    RETURNS INT
BEGIN
    RETURN
        (SELECT MAX(InvoiceID) FROM Invoices WHERE (InvoiceTotal-PaymentTotal-CreditTotal) > 0) ;
END;
GO

-- Test
PRINT 'The Last InvoiceID of unpaid balance is ' + CONVERT(varchar, dbo.fnRecentUnpaidInvoiceID());

