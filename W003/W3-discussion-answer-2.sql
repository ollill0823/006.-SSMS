/*

Topic: Subquery

Question: In the MyGuitarShop database, please provide the first name, 
last name, and email address of the customers whose shipping address 
is located in California. 

*/



USE MyGuitarShop
GO
WITH summary AS (
SELECT FirstName AS [first name], LastName AS [last name],
EmailAddress AS [email address]
FROM Customers JOIN Addresses
ON Customers.CustomerID = Addresses.CustomerID
WHERE Addresses.State = 'CA'
)

SELECT DISTINCT * FROM summary