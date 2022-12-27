/*

You've been asked to create another Customer report. This time you would like 
the find customers who have the same Billing Address as the Shipping Address. 
The report should have Last and First name, and the common address ID named 
AddressID.  The catch is you will need to construct the query using an INTERSECT. 
No need for a WHERE clause.


Hint: Answer only involves the customer table. 

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT LastName, FirstName, ShippingAddressID AS AddressID FROM Customers
INTERSECT
SELECT LastName, FirstName, BillingAddressID AS AddressID FROM Customers
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
      FirstName, LastName,
      ShippingAddressID as AddressID
FROM
     Customers
INTERSECT
SELECT
     FirstName, LastName,
     BillingAddressID as AddressID
FROM
      Customers
  