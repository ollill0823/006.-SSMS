USE AP
GO


--Part A--
IF OBJECT_ID('OverDue2') IS NOT NULL
   DROP TABLE OverDue2;


SELECT *
INTO OverDue2
FROM Invoices 
ORDER BY InvoiceTotal DESC 

ALTER TABLE OverDue2 ADD Today VARCHAR (50)


UPDATE OverDue2
SET Today =  CONVERT(date, GETDATE())
WHERE Today IS NULL

--Part A--
IF OBJECT_ID('OverDue2') IS NOT NULL
   DROP TABLE OverDue2;

SELECT *
INTO OverDue2
FROM Invoices 
ORDER BY InvoiceTotal DESC 

INSERT INTO OverDue2
VALUES (CONVERT(date, GETDATE()))