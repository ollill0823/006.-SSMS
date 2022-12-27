/*

Hi Class,

Topic: DATEADD, CAST or CONVERT, the abbreviation of the names, FIRST_VALUE, LAST_VALUE

 

I have hired some vendors to assist me in selling products. However, because I am mean, I did not provide them with any health insurance. Unluckily, the United States Department of Labor has found the fact, and they requested me to provide relevant detail. Could you help me find the result table from the database?

The result will include VendorID, the abbreviation of the names, InvoiceDate, PaymentTotal, When the health insurance starts AS FirstDate, when the health insurance should end as LastDate.

Hint: 

USE AP database
	* USE ContactUpdates to get Vendor's LastName and FirstName
	* When the health insurance starts AS FirstDate means prior one month to 
	the first date of the Invoice from the vendor
	* When the health insurance should end as LastDate means after a quarter 
	of the last date of the Invoice from the vendor
	* Please Order by InvoiceDate DESC
	* FIRST_VALUE & LAST_VALUE can reference  from book P.297 or  handout chapter 
	9 P.48
	* DateADD can use negative number
	* FirstDate and LastDate should transfer to Date mode (Use CAST or CONVERT)
 

Result Table: 46 rows

TOP 5

VendorID	VendorName	InvoiceDate	PaymentTotal	FirstDate	LastDate
94	Suscipe.R.	3/5/2016 0:00	17.5	2/5/2016	6/5/2016
123	Bucket.C.	4/2/2016 0:00	127.75	11/10/2015	7/2/2016
123	Bucket.C.	3/30/2016 0:00	22.57	11/10/2015	7/2/2016
123	Bucket.C.	3/24/2016 0:00	67	11/10/2015	7/2/2016
123	Bucket.C.	3/23/2016 0:00	44.44	11/10/2015	7/2/2016
 

TAIL 5

VendorID	VendorName	InvoiceDate	PaymentTotal	FirstDate	LastDate
123	Bucket.C.	12/16/2015 0:00	144.7	11/10/2015	7/2/2016
123	Bucket.C.	12/16/2015 0:00	15.5	11/10/2015	7/2/2016
123	Bucket.C.	12/16/2015 0:00	42.75	11/10/2015	7/2/2016
123	Bucket.C.	12/13/2015 0:00	138.75	11/10/2015	7/2/2016
123	Bucket.C.	12/10/2015 0:00	40.2	11/10/2015	7/2/2016

*/



USE AP
GO

SELECT Invoices.VendorID, LastName + '.' + LEFT(FirstName,1) + '.' AS VendorName,
	InvoiceDate, PaymentTotal,
	LAST_VALUE(CAST(DATEADD(month,-1, InvoiceDate) AS DATE)) OVER (PARTITION BY Invoices.VendorID ORDER BY InvoiceDate DESC
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS FirstDate,
	FIRST_VALUE(CAST(DATEADD(quarter,1, InvoiceDate) AS DATE)) OVER (PARTITION BY Invoices.VendorID ORDER BY InvoiceDate DESC) AS LastDate

FROM Invoices JOIN ContactUpdates
ON Invoices.VendorID = ContactUpdates.VendorID




