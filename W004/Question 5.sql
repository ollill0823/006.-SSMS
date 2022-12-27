/*

In working with your Product marketing team, you've been asked 
to help write a report to find a category that is not currently 
being assigned to any products. The report will have a single field 
(CategoryName) and will be the  list of categories that are not 
currently assigned to any products.
 

Part A : Write the SQL to accomplish this, using the EXISTS conditional clause
 

Part B : Solve again, but use the ANY clause
 
HINT Part B:  In the WHERE clause, the conditions [field1] <> [field2] or 
[field1] != [field2]   does not translate to not equal to any.  
Look up some examples in the documentation or Google for SQL ANY clause for help.




*/





-------------------------Answer from me ------------------------------
--PartA--
USE MyGuitarShop
GO

SELECT CategoryName 
FROM Categories
WHERE NOT EXISTS 
	(SELECT * 
	FROM Products 
	WHERE Categories.CategoryID = Products.CategoryID );

--PartB--
USE MyGuitarShop
GO

	SELECT CategoryName 
	FROM Categories
EXCEPT
	SELECT CategoryName 
	FROM Categories
	WHERE CategoryID = ANY
		(SELECT DISTINCT CategoryID 
		FROM Products 
		);

--PartB extended--
USE MyGuitarShop
GO

SELECT CategoryName 
FROM Categories
WHERE CategoryID != ALL
	(SELECT DISTINCT CategoryID 
	FROM Products 
	);


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

-- Part A
SELECT
  CategoryName
FROM
  Categories c
WHERE NOT EXISTS
  (SELECT
     *
  FROM
   Products
WHERE
  CategoryID = c.CategoryID)

-- Part B
SELECT
  CategoryName
FROM
  Categories c
WHERE
  NOT c.CategoryID = ANY (SELECT CategoryID FROM Products)