
/*

Create a script that creates a temporary table #Fib where each row is the next 
element of the Fibonacci sequence. 
https://en.wikipedia.org/wiki/Fibonacci_number (Links to an external site.)

Here's an example of the first 7 numbers in the Fibonacci sequence
1, 2, 3, 5, 8, 13, 21

In generating the sequence, each number takes the two previous
numbers and adds them (e.g. 1+2 =3, 3+5=8, 8+13=21)

In the resulting #Fib temp table each number will have it's own row

#Fib
seq
1
2
3
5
8
13
21

Design the script so it uses a variable called @maxseq which is the maximum 
value the sequence could generate. Note it's not the exact, but the maximum.

To simplify, you can pre-populate the table with the first two rows (e.g. 1, 2) 
to ensure you have the previous 2 values to generate the next number sequence

Other Strategies:
- Consider a strategy that uses WHILE LOOP and have a variable that acts as a 
counter.
- In capturing the previous 2 rows, there is a way to use TOP 2 
(to get the first 2 rows). 

Note: There's more than one approach to get the correct answer

*/


-------------------------Answer from me ------------------------------



IF OBJECT_ID(N'tempdb..#Fib') IS NOT NULL
DROP TABLE #Fib
GO

--Creating a temporary table #Fib
CREATE TABLE #Fib
(seq int);
GO

--Declaring local variables
DECLARE @F1 INT = 1, @F2 INT = 2, @Number INT = 3, @temp INT;
DECLARE @Stop_number INT = 1000;
--Inserting the 1st, 2nd row data
INSERT #Fib VALUES (@F1), (@F2);
	WHILE ( @Number <= @Stop_number)
		BEGIN 
			SET @temp = @F2;
			SET @F2 = @F1 + @F2;
			SET @F1 = @temp;
			SET @Number = @Number + 1;
			INSERT #Fib VALUES (@F2);
		END
--Inserting @maxseq to take the max number from the Fibonacci sequence
DECLARE @maxseq INT;
SELECT @maxseq = MAX(seq) FROM #Fib;

--Printing the max Fibonacci number
PRINT 'The row number is ' + CONVERT(varchar, @Number-1) + ', and the max number is ' + CONVERT(varchar, @maxseq) + '.'
GO


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

DECLARE @maxseq int;
DECLARE @nextseq int;

-- Prep #Fib
DROP TABLE IF EXISTS #Fib;
CREATE TABLE #Fib
( seq int);

INSERT INTO #Fib VALUES (1);
INSERT INTO #Fib VALUES (2);

-- Set up loop, set up vars
SET @maxseq = 34;
SET @nextseq = (SELECT SUM( seq ) FROM
(SELECT TOP 2 seq From #Fib ORDER BY seq DESC) a)

-- Main loop
WHILE @maxseq >0
BEGIN
SET @nextseq = (SELECT SUM( seq ) FROM
(SELECT TOP 2 seq From #Fib ORDER BY seq DESC) a)
IF (@nextseq <=@maxseq)
INSERT INTO #Fib VALUES (@nextseq)
ELSE
BREAK
END

-- Look at result.
SELECT * FROM #Fib;