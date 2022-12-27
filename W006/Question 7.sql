/*

Background:
 
You are working with your Security team and the engineers to improve the
current strategy for storing and retrieving customer passwords.
 
If you're unfamiliar with a hash, or not sure how it applies to passwords, 
take a look at this video for a basic primer which discusses, passwords, hashes, 
and salts.
 


In the Customer table, there is a password field that is a one way hash of 
the actual password. During a log-in session, the customer enters their password, 
which is then run through the same one-way hash and compared to the value stored 
in the password field. If this matches, then the password is correct.

This approach is acceptable as a minimum effort, but is easily vulnerable 
to more modern techniques (e.g. rainbow or offline dictionary attacks).
 
 
Problem:

The security team has asked you to create a new password field (password2)  
that uses a salt as part of the password. The salt field is a unique value 
that is appended to a password, which is then run through a one-way hash and 
stored. This is more secure method to store passwords.

The following steps need to be scripted and should run from beginning to 
end (in a single process) without any errors:
 
-- Step #1 Set up table and add new fields
	* Create a test table (Customers2) using the data and structure from Customers
	Add 2 new fields to the table
	* PasswordSalt (store the unique salt value)
	* Password2 (store the new password hash value)
 

-- Step #2 - Populate the fields as follows:

	* PasswordSalt: is assigned a unique value (for each row) in the table. 
	HINT: Use the NewID() function to generate a value. Look in the reference 
	for the datatype NewID uses.
	* Password2: is assigned a SHA1-Hash of a password formula. 
	HINT: Look in the SQL reference for the HASHBYTES() function in generating 
	a SHA1 hash.
		** The formula to assign Password2 is:
			*** Password2 = HASH(Password+PasswordSalt)
			*** HINT: Consider implications on datatypes of combining the Password 
			and PasswordSalt. Feel free to convert them.

-- Step 3 - Validate if the fields have been encoded correctly

	* Write a validation query that compares the Password2 field with 
	formula: HASH(Password+PasswordSalt) and it displays either 
	a 'Yes' (for matching), or 'No' (for not matching) as a new field called 
	'Valid'
	* The output of the query lists  Password, PasswordSalt, Password2, Valid
 


*/


-------------------------Answer from me ------------------------------



USE MyGuitarShop
GO

---  Drop the existing view ---
IF OBJECT_ID('Customers2') IS NOT NULL
    DROP TABLE Customers2
GO

--- Step #1 Set up a table and add new fields ---
--- Step #1.1 Set up table---
SELECT * INTO Customers2 FROM Customers

--- Step #1.2  Add two new column PasswordSalt & Password2---
ALTER TABLE Customers2 ADD PasswordSalt varchar(60) NULL;
ALTER TABLE Customers2 ADD Password2 varbinary(200) NULL;
/*Take care that Password2 should use varbinary because
numbers or English words are randomly generated by the Hashbytes function */


--- Step #2 - Populate the fields as follows: --
--- Step #2.1 - Random function NEWID() data into PasswordSalt --
UPDATE Customers2 SET PasswordSalt = NEWID()

--- Step #2.2 - insert one way hash of password data into Password --
UPDATE Customers2 SET Password2 = HASHBYTES( 'SHA1' , Password )


--- Step 3 - Validate if the fields have been encoded correctly
SELECT Password, PasswordSalt, Password2, 
    IIF(Password2 = HASHBYTES( 'SHA1' , Password ), 'Yes', 'No')
        AS Valid
FROM Customers2


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO

-- Initial cleanup
DROP Table IF EXISTS Customers2
 

--Create test table
SELECT * INTO Customers2 FROM Customers
 

-- Add fields, default Salt upon creation
ALTER TABLE
  Customers2
ADD
  PasswordSalt UNIQUEIDENTIFIER NOT NULL DEFAULT NewID(),
  Password2 varchar(40)
 

GO
 

-- Update new password2 field with
-- formula: Password2 = SHA1-HASH(PasswordSalt + Password)
UPDATE
  Customers2
SET
  Password2 = HASHBYTES('SHA1',Password+CONVERT(varchar(40),PasswordSalt))



-- Validator to ensure they all match, at least validate the original hash in Password
SELECT
  Password, Password2, PasswordSalt,
 IIF(HASHBYTES('SHA1',Password+CONVERT(varchar(40),PasswordSalt))=Password2,'Yes','No') as Valid
FROM
  Customers2