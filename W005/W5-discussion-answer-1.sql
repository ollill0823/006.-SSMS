/*

Topic: GROUPING function and CASE function

Question: In MyGuitarShop database, write a summary query that uses with 
ROLLUP operator to return the ProductsCount (the count for the products in 
each category) group by Category (an alias for CategoryName). Substitute the 
literal value 'ALL' for the summary rows with null values.

*/


USE MyGuitarShop
GO
SELECT CASE
        WHEN GROUPING(CategoryName) = 1 THEN 'All'
        ELSE CategoryName
    END AS Category,
    COUNT(*) AS ProductsCount
FROM Products JOIN Categories 
ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName WITH ROLLUP