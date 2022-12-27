/*

Now modify the response from the previous question (Fibonacci sequence) to 
create the same result, but use a CURSOR to assist in the calculation of the 
previous two numbers (e.g. Use a CURSOR within the WHILE LOOP to cycle through the rows)

 

Hint:

When thinking about how to structure the CURSOR, look at the documentation SQL 
Server reference for CURSORS, specifically SCROLL cursors and how to use them 
to navigate a tables.  SCROLL Cursors allow you to navigate to FIRST, LAST, PREV 
and NEXT positions.

There are a number of ways you create the script. Here is one potential way 
(note this is pseudo sql, and needs to be fully converted to SQL to get credit 
and to run correctly)

-- Rough pseudo sql

Declare temp tables, and variables

Insert initial 2 values (1, 2) into temp table

Declare the SCROLL cursor as

a SELECT TOP 2 from the temp table and sort in descending to ensure only the 2 
highest values are seen in the scroll cursor

While Loop  (condition to keep going)

  BEGIN

  Open the cursor

  Fetch the LAST row into a variable

  Fetch the Prior row into another variable

 SET a new variable = addition of the above 2 variables

 Test via an

IF statement if the loop should end 

  if it should end, use a BREAK statement to jump out out of the loop

 ELSE

  Insert new variable into temp table

Close the Cursor

END

Deallocate the Cursor

-- print out the results

Select * from the Temptable


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
DECLARE @F1 INT = 1, @F2 INT = 2, @Number INT = 3;
--Inserting the 1st, 2nd row data
INSERT #Fib VALUES (@F1), (@F2);

--Defining a cursor
DECLARE Fibonacci_Cursor CURSOR
FOR
	-- Selecting top 2 number to do calculation
	SELECT TOP 2 seq FROM #Fib 
	ORDER BY seq DESC;
-- Opening cursor
OPEN Fibonacci_Cursor;

--Declaring local variables inside the cursor
DECLARE @New_F1 INT, @New_F2 INT, @temp INT, @Stop_number INT = 1000;

--Transferring seq column data into variables
FETCH NEXT FROM Fibonacci_Cursor INTO @New_F2;
FETCH NEXT FROM Fibonacci_Cursor INTO @New_F1;
--Checking if the cursor successfully get the data
WHILE (@@FETCH_STATUS = 0)
	BEGIN
			--Starting Fibonacci calculation
			SET @temp = @New_F2 + @New_F1;
			SET @New_F1 = @New_F2;
			SET @New_F2 = @temp;
			SET @Number = @Number+1;

			--If keep going the calculation
			IF @Number > @Stop_number+1
				BREAK;
			ELSE
				INSERT #Fib VALUES (@temp);
	END;

--Closing the cursor
CLOSE Fibonacci_Cursor;
--Droping the cursor
DEALLOCATE Fibonacci_Cursor;

--Inserting @maxseq to take the max number from the Fibonacci sequence
DECLARE @maxseq INT;
SELECT @maxseq = MAX(seq) FROM #Fib;

--Printing the max Fibonacci number 
PRINT 'The row number is ' + CONVERT(varchar, @Stop_number) + ', and the max number is ' + CONVERT(varchar, @maxseq) + '.'
GO

SELECT * FROM #Fib



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


DECLARE @maxseq int;
DECLARE @nextseq int;
DECLARE @currseq int;


-- Prep #Fib
DROP TABLE IF EXISTS #Fib;
CREATE TABLE #Fib
( seq int);

-- Prepopulate
INSERT INTO #Fib VALUES (1);
INSERT INTO #Fib VALUES (2);

DECLARE Fib_Cursor SCROLL CURSOR  FOR
  SELECT TOP 2 seq From #Fib ORDER BY seq DESC

SET @maxseq = 34; /* Any number */
SET @nextseq = 0;

WHILE @maxseq >0
BEGIN
  OPEN Fib_Cursor
  FETCH LAST FROM Fib_Cursor INTO @currseq;
  SET @nextseq = @currseq;
  FETCH PRIOR FROM Fib_Cursor INTO @currseq
  SET @nextseq = @nextseq + @currseq;

  IF @nextseq <= @maxseq
  BEGIN
    print @nextseq; /* not required */
    INSERT INTO #Fib VALUES (@nextseq)
  END
ELSE
  BREAK;
CLOSE Fib_Cursor;
END
DEALLOCATE Fib_Cursor;

select * from #Fib;