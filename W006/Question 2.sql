/*

In following up from the previous question, MasterCard dropped out of the 
promotion. 

 

As a result, the program has changed:

There is no longer a 'Plus' membership status (Just Premier and Standard

Standard applies to all Customers (even if they haven't made a purchase)

Customers may NOW specify different payment methods for each order. 
(This may affect your query results.)

You need to modify the report. Instead of simply changing the CASE statement 
for MasterCard Customers, construct the query using an IIF() statement.

 

Use the following approach in your response:

- Use IIF instead of CASE
- Instead of using a Multi-table JOIN to validate if the relationship exists, 
use a Correlated Subquery within the IIF Condition to evaluate the logical 
condition.
 

HINT: When planning the IIF() statement, consider using a subquery with a 
count(*) in the criteria parameter of the function.  For example:

IIF((select count(*) from table)>10, value1, value2)

Note the use of the count(*) value returned from the subquery and how 
it can be used as a logical condition.

*/


-------------------------Answer from me ------------------------------




USE MyGuitarShop
GO

-- Define membership to Premier(American Express), Standard(Others) from Cardtype
SELECT CustomerID, LastName,
	IIF(
		-- Notice that IIF Function can only be used in boolean expression !! --
		--- So, sub-query should be changed to logical expression ---
		CustomerID IN (SELECT CustomerID FROM Orders
			WHERE CardType = 'American Express'), 'Premier', 'Standard') AS Membership
FROM Customers



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


SELECT
  c.CustomerID, c.LastName,
  IIF((
    SELECT
      COUNT(*)
    FROM
      Orders
    WHERE
      c.CustomerID = Orders.CustomerID
    AND
      Orders.CardType = 'American Express'
    )=0,'Standard','Premier') as Membership
FROM
  Customers c
ORDER BY c.CustomerID