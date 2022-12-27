/*


You've been asked to format a product report. The report lists the following 
fields:
ListPrice
DiscountPercentage
DateAdded
 

In the output, the fields are formatted as:  Note each field's name and 
format. Use CONVERT, FORMAT and/or CAST() for formatting.
 
DollarFormat	DisplayDiscPercent	ForMultiPercentage	JustDate
$699.00	30%	0.30	2015-10-30
$1,199.00	30%	0.30	2015-12-05
...	...	...	...
 

Note: Not all rows are displayed
... ... ... ... ...



*/





-------------------------Answer from me ------------------------------
SELECT FORMAT(ListPrice, 'C2') AS DollarFormat,
	CAST(CAST(DiscountPercent AS DECIMAL(3)) AS varchar) + '%' AS DisplayDiscPercent,
	(DiscountPercent)/100 AS ForMultiPercentage,
	CAST(DateAdded AS date) AS JustDate
FROM Products



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT
   '$'+CONVERT(varchar,ListPrice,1) AS DollarFormat,
   CONVERT(varchar,CAST(DiscountPercent AS int),1) +'%' AS DisplayDiscPercent ,
   CAST(DiscountPercent/100 AS Decimal(3,2)) AS ForMultPercentage ,
   CAST(DateAdded AS date) as JustDate
FROM
   Products