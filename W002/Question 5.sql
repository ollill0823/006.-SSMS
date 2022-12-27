/*

In working with the Shipping team, you are developing a Customer report. 
The report should have the customer's first name, customer's last name, 
line 1 of their address, along with city, state, and zip code fields. 
The report should have exactly one row for each customer. 
Given there could be multiple Addresses for customers, or missing Addresses 
for customers.

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT ProductName, ListPrice, CategoryName
FROM Products AS PD JOIN Categories AS CA
ON PD.CategoryID = CA.CategoryID
ORDER BY CategoryName DESC, ProductName DESC
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT 
     CategoryName, ProductName, ListPrice
FROM 
     Categories c JOIN Products p
     ON c.CategoryID = p.CategoryID
ORDER BY 
     CategoryName, ProductName
  