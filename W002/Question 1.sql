/*


You've been asked to generate a Product report. The report should have 
the Product code, Product name, List price and percentage of discount.  
Additionally, the report should be sorted by list price with the most expensive 
product at the top of the report.

Hint: This type of question requires interpretation and inference. 
While the question doesn't explicitly state the name of the table, or column, 
it does specify the semantic or domain requirements. For example, 
"Product report" implies Product table, or "percentage of discount" 
implies DiscountPercent for the column name. Lastly, "list price with 
the most expensive product at the top of the report" implies ORDER BY 
ListPrice DESC. It's important to understand the database in order to 
ensure you're using the correct tables and column names.

 

Write the SQL to accomplish this.

*/




-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO
SELECT CategoryName, Count(*) AS ProductCount,
	Max(ListPrice) AS MostExpensiveProduct
FROM Products JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName
ORDER BY ProductCount DESC;



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT 
     ProductCode, 
     ProductName, 
     ListPrice, 
     DiscountPercent
FROM 
     Products
ORDER BY 
     ListPrice DESC;