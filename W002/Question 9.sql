/*

You are asked to create a Customer name report. The report will display a 
field named FullName. This field is in the format "Last, First" 
(e.g. Kellener, Erik). Additionally, the report will only include 
customers who's first initial of the last name is M... and the way including 
names that start with Z (e.g. Kellener would not appear in the final report). 
Lastly, the report should be sorted alphabetically.

Write the SQL to accomplish this



*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT LastName + ', '+ FirstName AS FullName FROM Customers
WHERE LastName LIKE '[M-Z]%'
ORDER BY FullName ASC
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT 
     CONCAT(LastName, ', ', FirstName) AS FullName
FROM 
     Customers
WHERE 
     LastName > 'M'
ORDER BY 
     LastName
  