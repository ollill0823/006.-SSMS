/*

PART I: topic: How to create a view

Write a CREATE VIEW statement that defines a view named BasicInvoice 
that returns three columns: GuitarBrand, InvoiceNumber, and TotalInvoice. 
Then, write a SELECT statement that returns all of the columns in the view, 
sorted by GuitarBrand, where the first letter of the vendor name is G, I, or F.

*/


CREATE VIEW BasicInvoice 
AS
SELECT GuitarBrand, InvoiceNumber, TotalInvoice
FROM Table_NAME


SELECT * FROM BasicInvoice
WHERE LEFT(GuitarBrand, 1) IN ('G', 'I', 'F')
ORDER BY GuitarBrand

