/*


You are working with the Product team and are creating a report for 
them to categorize their products. The Product report should include 
product name, list price, and product's category name. 
The report should be ordered by category name, then by product name

 

HINT: category name is not in the Product report. You'll need to get 
it through a join, and use table aliasing for readability.
 

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
  