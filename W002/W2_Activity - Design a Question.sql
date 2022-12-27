/*  Part I: Question

Data is from Examples (from the data professor shares)

You hire an awkward waiter and you found he keyin the wrong Invoice in someday, 
please help me find which datasets are wrong (hint: there are two mistakes)

Write a SELECT statement that returns VendorName, VendorCity, VendorZipCode, 
Mistakes_Money, InvoiceDate, and sort by InvoiceDate from old to new.


Hint: 
1. You need to use two-column to complete this question: PaidInvoices & Vendors
2. Mistakes_Money Means the money gets from the customer which is different from 
the money writer key in ; (That is the difference between PaymentTotal 
AND InvoiceTotal)
3. From old to new means the old date was put on top, and the latest was put on the bottom
4. There are two rows. 

*/




Use Examples

SELECT * FROM PaidInvoices
SELECT * FROM Vendors

SELECT VendorName, VendorCity, VendorZipCode, (PaymentTotal- InvoiceTotal) AS Mistakes_Money, InvoiceDate
FROM PaidInvoices LEFT JOIN Vendors
ON PaidInvoices.VendorID = Vendors.VendorID
WHERE NOT (PaymentTotal- InvoiceTotal) = 0
ORDER BY InvoiceDate ASC


SELECT VendorName, VendorCity, VendorZipCode, (PaymentTotal- InvoiceTotal) AS Mistakes_Money, InvoiceDate
FROM PaidInvoices LEFT JOIN Vendors
ON PaidInvoices.VendorID = Vendors.VendorID
WHERE (PaymentTotal- InvoiceTotal) != 0
ORDER BY InvoiceDate ASC



SELECT VendorName, VendorCity, VendorZipCode, PaymentTotal - InvoiceTotal as Mistakes_Money, InvoiceDate
from Vendors as v , PaidInvoices as PA
where v.VendorID=PA.VendorID
and PaymentTotal - InvoiceTotal<>0
order by InvoiceDate