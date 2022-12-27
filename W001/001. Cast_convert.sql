DECLARE @msg varchar(20)
SELECT @msg = 'The result is: ' + CAST((2+2) AS VARCHAR)
PRINT @msg



DECLARE @ok varchar(20)
SELECT @ok = 'I get ' + CAST(100 AS VARCHAR) + ' score.'
PRINT @ok

DECLARE @pp varchar(20)
SELECT @pp = 'The result is: ' + convert(varchar, (2*3))
PRINT @pp


SELECT GETDATE()
SELECT CONVERT (varchar(12), GETDATE(),1)

SELECT CONVERT (varchar(12), GETDATE(),2)
SELECT CONVERT (varchar(12), GETDATE(),3)

SELECT CONVERT (varchar(12), GETDATE(),101)
SELECT CONVERT (varchar(12), GETDATE(),102)
SELECT CONVERT (varchar(12), GETDATE(),100)