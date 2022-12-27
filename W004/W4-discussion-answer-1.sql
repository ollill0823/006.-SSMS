/*

Topic: Filtering

Topic: Select Into and Insert Into

Please create a copy of the totalInvoice table and add the 
dates of this week into the table.

*/



I am not sure if you want me to create a new column or a row, so I write two codes to answer your question.

 

------------------------------------------------Code Begin---------------------------------------------------------

---------------------------------------------Create a column-------------------------------------------------------

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

---------------------------------------------Create a row-----------------------------------------------------------

IF OBJECT_ID('totalInvoiceCopy') IS NOT NULL
   DROP TABLE totalInvoiceCopy;

    --Part B1. Copy a table from totalInvoice--
    SELECT *
    INTO totalInvoiceCopy
    FROM totalInvoice 

    --Part B2. Insert data into a new row--
    INSERT INTO totalInvoiceCopy
    VALUES (CONVERT(date, GETDATE()))