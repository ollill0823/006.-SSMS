/*

You are working with the promotions team, and they want to provide a Tax 
holiday promotion.
 
To help them forecast the amount of taxes by Card type, they have asked you 
for an Orders report that only looks at Orders purchased on Mondays
 

The summary report should look just like below (columns and formatting)
HINT: The row with the 'Total' CardType is the summary of the previous rows - 
consider using ROLLUP
 
Use COALESCE or ISNULL in your answer.

*/


-------------------------Answer from me ------------------------------

USE MyGuitarShop
GO

--- Solution 1: Use SUB-QUERY + COALESCE Function
WITH Summary AS 
(
	SELECT CardType, SUM(TaxAmount) AS TaxAmount
	FROM Orders
	--- If use DATEPART function, Sunday = 1, Monday =2, so on. ---
	WHERE DATENAME(weekday, OrderDate) = 'Monday'
	GROUP BY CardType WITH ROLLUP
)

SELECT COALESCE(CardType, 'Total') AS CardType, TaxAmount
FROM Summary



--- Solution 2: Use GROUPING Function
SELECT 
	CASE 
		WHEN GROUPING(CardType) = 1 THEN 'All'
		ELSE CardType
	END AS CardType,
	SUM(TaxAmount) AS TaxAmount
FROM Orders
WHERE DATENAME(weekday, OrderDate) = 'Monday'
GROUP BY CardType WITH ROLLUP


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
  COALESCE(CardType,'Total') CardType,
  SUM(TaxAmount) AS TaxAmount
FROM
  Orders
WHERE
  DATENAME(weekday, OrderDate) = 'Monday'
GROUP BY
    CardType WITH ROLLUP
