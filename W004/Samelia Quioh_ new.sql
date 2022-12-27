USE AP
GO


--Part A--
IF OBJECT_ID('totalInvoiceCopy') IS NOT NULL
   DROP TABLE totalInvoiceCopy;

	--Part A1. Copy a table from totalInvoice--
	SELECT *
	INTO totalInvoiceCopy
	FROM totalInvoice 

	--Part A2. Create a new column which is NULL--
	ALTER TABLE totalInvoiceCopy ADD Today VARCHAR (50)

	--Part A3. Update today's date into this column--
	UPDATE totalInvoiceCopy
	SET Today =  CONVERT(date, GETDATE())
	WHERE Today IS NULL

--Part B--
IF OBJECT_ID('totalInvoiceCopy') IS NOT NULL
   DROP TABLE totalInvoiceCopy;

    --Part B1. Copy a table from totalInvoice--
	SELECT *
	INTO totalInvoiceCopy
	FROM totalInvoice 

	--Part B2. Insert data into a new row--
	INSERT INTO totalInvoiceCopy
	VALUES (CONVERT(date, GETDATE()))