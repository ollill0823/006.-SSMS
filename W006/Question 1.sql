/*

You are working with a team to create a new customer membership status. 
Your company has put together a marketing program with American Express and 
MasterCard (Credit card payment companies) for this new membership.
 

Any customer that has used American Express for their purchasing is 
considered a 'Premier' member. MasterCard use is considered 'Plus' 
and all others with at least one past order are considered 'Standard' members.
 

To pilot the program you need to generate a Customer membership report.
 
The report contains  the Customer's ID, Last Name, and a new field Membership. 
Each Customer record should be unique. Membership is either 'Premier', 'Plus' 
or 'Standard' as described above.
 

In your report you should assume all customers only use a single payment 
type (American Express, MasterCard., etc)
 
Only a single query is needed, JOINS are fine and use a CASE Function


*/


-------------------------Answer from me ------------------------------
USE MyGuitarShop
GO

-- Define membership to Premier(American Express), Plus(MasterCard), Standard(Others) from Cardtype
SELECT DISTINCT Customers.CustomerID, LastName,
	CASE 
		WHEN CardType = 'American Express' --Premier(American Express)--
			THEN 'Premier'
		WHEN CardType = 'MasterCard'       --Plus(MasterCard)--
			THEN 'Plus'
		ELSE 'Standard'                    --Standard(Others)--
	END AS Membership			
FROM Customers JOIN Orders
ON Customers.CustomerID = Orders.CustomerID



-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

SELECT DISTINCT
  c.CustomerID, c.LastName,
  CASE o.CardType
    WHEN 'American Express' THEN 'Premier'
    WHEN 'MasterCard' THEN 'Plus'
  ELSE 'Standard'
  END as Membership
FROM
  Customers c JOIN Orders o
  ON c.CustomerID = o.CustomerID