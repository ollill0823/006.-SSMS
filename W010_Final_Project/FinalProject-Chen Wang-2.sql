/*

- Part A - Design and Create Database: 

	-- Design the database you’ll use to analyze the Spreadsheet tabs and 
		design a database with a set of tables tables and fields. 
		*** At this point, you won’t need to populate it, but will need to 
			design a normalized set  of database table structures and 
			relationships(e.g. FK).
			**** HINT: the spreadsheet Entities  (People, Offices, Software) 
				are NOT normalized and need to be by adding additional tables.
		*** In each of the tables, ensure there is an int ID that uniquely 
			identifies the row (e.g. could be your PK?). Each ID should be a 
			simple IDENTITY - generated automatically.
		*** HINT: Avoid using PK or FKs that don’t make sense (e.g. “Erik Kellener”)
			may be a unique key, but doesn’t mean it makes for a good unique PK/FK
	-- Create a series of statements that ~ (remember it needs to be idempotent)
		DROP and CREATE the NewCo database
		DROP and CREATE the  tables to use in the database
		Again, use your best judgement on data-types, but try to retain the 
		intended naming convention from each column in the sheet 
		(e.g avoid using ]zip code field that has a name “city” 
	-- Hint: Use your understanding of a normal form to model the database 
		from the spreadsheet. ******Avoid just mapping a single tab to a single 
		table, there’s more normalization to the structure needed.*****
*/



USE master;
GO

/****** A.1.0:  Drop a database if existing  ******/
IF DB_ID('FinalProject') IS NOT NULL
	DROP DATABASE FinalProject
GO

--- A.1.1 Create a database named FinalProject ---
CREATE DATABASE FinalProject;
GO 


USE FinalProject;
GO

---  A.2.0 Drop Addresses table if existing ---
IF OBJECT_ID('EmployeeOffice') IS NOT NULL
    DROP TABLE EmployeeOffice
GO


---  A.2.0 Drop Employees table if existing ---
IF OBJECT_ID('Office') IS NOT NULL
    DROP TABLE Office
GO

---  A.2.0 Drop System table if existing ---
IF OBJECT_ID('System') IS NOT NULL
    DROP TABLE System
GO

---  A.2.0 Drop Manager table if existing ---
IF OBJECT_ID('Manager') IS NOT NULL
    DROP TABLE Manager
GO

---  A.2.0 Drop SoftwareManage table if existing ---
IF OBJECT_ID('SoftwareManage') IS NOT NULL
    DROP TABLE SoftwareManage
GO

---  A.2.0 Drop Employees table if existing ---
IF OBJECT_ID('Employees') IS NOT NULL
    DROP TABLE Employees
GO

---  A.2.0 Drop SoftwareArchive table if existing ---
IF OBJECT_ID('SoftwareArchive') IS NOT NULL
    DROP TABLE SoftwareArchive
GO


---  A.2.1 Create a table called Employees ---
CREATE TABLE Employees
(
EmployeeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
DateOfBirth Date NOT NULL,
HomeZip varchar(10) NOT NULL
)
GO


---  A.2.1 Create a table called EmployeeOffice ---
CREATE TABLE EmployeeOffice
(
InternalID INT IDENTITY(1,1) NOT NULL,
EmployeeID INT NOT NULL,
OfficeID INT NOT NULL,
)
GO

---  A.2.1 Create a table called Office ---
CREATE TABLE Office
(
OfficeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
OfficeLoc varchar(60) NOT NULL,
Capacity INT NOT NULL,
OffLocZip varchar(10) NOT NULL,
ManagerID INT NOT NULL
)
GO


---  A.2.1 Create a table called System ---
CREATE TABLE System
(
SystemID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Asset_key varchar(60) NOT NULL,
VendorName varchar(60) NOT NULL,
ProductName varchar(60) NOT NULL,
ProductVersion INT NOT NULL,
PurchaseDate varchar(60) NOT NULL
)
GO



---  A.2.1 Create a table called Manager ---
CREATE TABLE Manager
(
ManagerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EmployeeID INT NOT NULL
)
GO


---  A.2.1 Create a table called SoftwareManage ---
CREATE TABLE SoftwareManage
(
SoftwareManageID INT IDENTITY(1,1) NOT NULL,
SystemID INT NOT NULL, 
EmployeeID INT,
ManagerID INT
)
GO



---  A.2.1 Create a table called SoftwareArchive ---
CREATE TABLE SoftwareArchive
(
AuditID INT PRIMARY KEY IDENTITY,
SystemID INT NOT NULL, 
EmployeeID INT,
ManagerID INT,
DateUpdated DATETIME DEFAULT NULL
)
GO




---  A.3.1 Create relationship ( Foreign key: Address/Primary key: Employees) ---
ALTER TABLE EmployeeOffice
WITH NOCHECK ADD CONSTRAINT FK_EmployeeOffice_Employees
FOREIGN KEY(EmployeeID)   /* Foreign key */
REFERENCES Employees (EmployeeID) /* Primary key */
GO


---  A.3.1 Create relationship ( Foreign key: Office/Primary key: Manager) ---
ALTER TABLE Office
WITH NOCHECK ADD CONSTRAINT FK_Office_Manager
FOREIGN KEY(ManagerID)   /* Foreign key */
REFERENCES Manager (ManagerID) /* Primary key */
GO


---  A.3.1 Create relationship ( Foreign key: EmployeeOffice/Primary key: Office) ---
ALTER TABLE EmployeeOffice
WITH NOCHECK ADD CONSTRAINT FK_EmployeeOffice_Office
FOREIGN KEY(OfficeID)   /* Foreign key */
REFERENCES Office (OfficeID) /* Primary key */
GO


---  A.3.1 Create relationship ( Foreign key: Manager/Primary key: Employees) ---
ALTER TABLE Manager
WITH NOCHECK ADD CONSTRAINT FK_Manager_Employees
FOREIGN KEY(EmployeeID)   /* Foreign key */
REFERENCES Employees (EmployeeID) /* Primary key */
GO


---  A.3.1 Create relationship ( Foreign key: SoftwareManage/Primary key: Employees) ---
ALTER TABLE SoftwareManage
WITH NOCHECK ADD CONSTRAINT FK_SoftwareManage_Employees
FOREIGN KEY(EmployeeID)   /* Foreign key */
REFERENCES Employees (EmployeeID) /* Primary key */
GO

---  A.3.1 Create relationship ( Foreign key: SoftwareManage/Primary key: Manager) ---
ALTER TABLE SoftwareManage
WITH NOCHECK ADD CONSTRAINT FK_SoftwareManage_Manager
FOREIGN KEY(ManagerID)   /* Foreign key */
REFERENCES Manager (ManagerID) /* Primary key */
GO



---  A.3.1 Create relationship ( Foreign key: SoftwareManage/Primary key: System) ---
ALTER TABLE SoftwareManage
WITH NOCHECK ADD CONSTRAINT FK_SoftwareManage_System
FOREIGN KEY(SystemID)   /* Foreign key */
REFERENCES System (SystemID) /* Primary key */
GO


/*

- Part B -Create data management stored procedures and functions - 
  (again, all of these should be idempotent)

	-- sp_addEmployee: Parameters (firstname, lastname, dob, zipcode)
		** zipcode is the employee’s home zip.
		** Action:Adds an employee to the database
	-- fn_findEmployeeID: Parameters (fullname)
		** Note fullname is the firstname + ‘ ‘ +lastname
		** Action:Performs a lookup on the fullname, and returns an internal ID 
		for the employee (note, these are generated by the identities)
	-- sp_addOffice: Parameters (location,capacity,zip,manager’s name)
		** location is the name of the office (e.g. Olaf)
		** capacity is the number of employees that can fit at the location
		** Zip is the office’s zipcode
		** Manager’s name is the fullname of the employee’s manager
		** Action:Adds a new Office location record
		Incorporate the newly created fn_findEmployeeID function into your 
		solution. This will help you translate the Manager’s name (fullname) 
		to their corresponding EmployeeID.
	-- fn_findOfficeID: Parameters (location)
		** location is the name of the office (e.g. Olaf)
		** Action:returns the corresponding internal ID for the @location parameter.
	-- sp_addEmployeeOffice: Parameters (fullname, location)
		** location is the name of the office (e.g. Olaf)
		** fullname is the firstname + ‘ ‘ +lastname
		** Hint: Feel free to use any of the functions, stored procedures, 
		or create your own to support this.
		** Action: Assigns an employee to an office location
		** Use the fn_findOfficeID and fn_findEmployeeID to assist in 
		adding the data to the appropriate tables.
		** Every employee should be assigned to an office. Employees 
		can be assigned to multiple offices.
	-- sp_addSoftware: Parameters (asset_key, vendor name, product name, product version, purchaseDate)
		** Asset_key is unique id of a software asset
		** Vendor_name is the name of the software publisher
		** Product_name is the name of the software product
		** Product_version is the version of the product
		** purchaseDate is the date the product was purchased by the company
		** Action: Adds a software asset to the system
		** Note: for Software, assignedTo and approvedBy fields are defaulted to NULL. They are updated via other stored procedures.
		** Note: purchaseDate parameter is optional and if not specified, defaults to the current date.
	-- sp_assignSoftware: Parameters (asset_key, fullname, approvedBy)
		** Asset_key is unique id of a software asset
		** Fullname is the name of the employee the software should be assigned to
		** approvedBy is the fullname of the employee that approved the software 
		assignment. Use the fn_findEmployeeId(approvedBy) to translate 
		fullname to Id for storing in the table.
		** Action: Assigns a specific software license to an employee 
		(e.g. updates AssignedTo field). Use fn_findEmployeeId(fullname) 
		to translate to an Id for storing in the table.
		** Software can only be assigned to a single person at one time. 
		Software that has a NULL in the assignedTo is considered to be unassigned.

*/
GO


/****** B.1.0:  Drop stored procedures:sp_addEmployee if existing  ******/
USE FinalProject;
GO

IF OBJECT_ID('sp_addEmployee') IS NOT NULL
    DROP PROC sp_addEmployee;
GO

/****** B.1.1:  Create stored procedures:sp_addEmployee  ******/
CREATE PROC sp_addEmployee
	@FirstName varchar(50),
	@LastName varchar(50),
	@DateOfBirth Date,
	@HomeZip varchar(10)

AS

	INSERT Employees
	VALUES (
		@FirstName,
		@LastName,
		@DateOfBirth,
		@HomeZip);
GO






USE FinalProject;
GO

/****** B.2.0:  Drop function:fn_findEmployeeID if existing  ******/
IF OBJECT_ID('fn_findEmployeeID') IS NOT NULL
    DROP FUNCTION fn_findEmployeeID;
GO


/****** B.2.1:  Create function:fn_findEmployeeID  ******/
CREATE FUNCTION fn_findEmployeeID
	(@Fullname varchar(60))
	RETURNS INT


BEGIN
	DECLARE @FirstName varchar(60), @LastName varchar(60);
	SET @FirstName = LEFT(@Fullname, CHARINDEX(' ', @Fullname)-1)
	SET @LastName = RIGHT(@Fullname, LEN(@Fullname) - CHARINDEX(' ', @Fullname))
	RETURN (SELECT EmployeeID FROM Employees WHERE FirstName = @FirstName 
		AND LastName = @LastName);
END;
GO


USE FinalProject;
GO

/****** B.3.0:  Drop function:fn_findManagerID  if existing  ******/
IF OBJECT_ID('fn_findManagerID ') IS NOT NULL
    DROP FUNCTION fn_findManagerID ;
GO

/****** B.3.1:  Create function:fn_findManagerID  ******/
CREATE FUNCTION fn_findManagerID
	(@EmployeeID varchar(60))
	RETURNS INT


BEGIN
	RETURN (SELECT ManagerID FROM Manager WHERE EmployeeID = @EmployeeID);
END;
GO



/****** B.4.0:  Drop stored procedures:sp_addOffice if existing  ******/
IF OBJECT_ID('sp_addOffice') IS NOT NULL
    DROP PROC sp_addOffice;
GO

/****** B.4.1:  Create stored procedures:sp_addOffice  ******/
CREATE PROC sp_addOffice
	@OfficeLoc varchar(60),
	@Capacity INT,
	@OffLocZip varchar(10),
	@OfficeMgr varchar(60)

AS
	DECLARE @ManagerID INT;
	DECLARE @FullName varchar(60);
	DECLARE @EmployeeID INT;
	SET @EmployeeID = dbo.fn_findEmployeeID(@OfficeMgr);
	IF NOT EXISTS ( SELECT EmployeeID FROM Manager WHERE EmployeeID = @EmployeeID)
	INSERT INTO Manager
	VALUES (
		@EmployeeID);

	SET @ManagerID = dbo.fn_findManagerID(@EmployeeID);
	
	INSERT Office
	VALUES (
		@OfficeLoc,
		@Capacity,
		@OffLocZip,
		@ManagerID);
GO







USE FinalProject;
GO

/****** B.5.0:  Drop function:fn_findOfficeID if existing  ******/
IF OBJECT_ID('fn_findOfficeID') IS NOT NULL
    DROP FUNCTION fn_findOfficeID;
GO


/****** B.5.1:  Create function:fn_findOfficeID  ******/
CREATE FUNCTION fn_findOfficeID
	(@OfficeLoc varchar(60))
	RETURNS INT

BEGIN
	RETURN (SELECT OfficeID FROM Office WHERE OfficeLoc = @OfficeLoc);
END;
GO


/****** B.6.0:  Drop stored procedures:sp_addEmployeeOffice if existing  ******/
IF OBJECT_ID('sp_addEmployeeOffice') IS NOT NULL
    DROP PROC sp_addEmployeeOffice;
GO

/****** B.6.1:  Create stored procedures:sp_addOffice  ******/
CREATE PROC sp_addEmployeeOffice
    @Fullname varchar(60),
	@OfficeLoc varchar(60)

AS
	DECLARE @EmployeeID INT;
	DECLARE @OfficeID INT;
	SET @EmployeeID = dbo.fn_findEmployeeID(@Fullname);
	SET @OfficeID = dbo.fn_findOfficeID(@OfficeLoc);
	INSERT EmployeeOffice
	VALUES (
		@EmployeeID,
		@OfficeID);
GO


/****** B.7.0:  Drop stored procedures:sp_addSoftware if existing  ******/
IF OBJECT_ID('sp_addSoftware') IS NOT NULL
    DROP PROC sp_addSoftware;
GO

/****** B.7.1:  Create stored procedures:sp_addSoftware  ******/
CREATE PROC sp_addSoftware
	@Asset_key varchar(60),
	@VendorName varchar(60),
	@ProductName varchar(60),
	@ProductVersion INT,
	@PurchaseDate Date = NULL

AS
	IF @PurchaseDate IS NULL
    SET @PurchaseDate = GETDATE()
	INSERT System
	VALUES (
		@Asset_key,
		@VendorName,
		@ProductName,
		@ProductVersion,
		@PurchaseDate);
GO


USE FinalProject;
GO

/****** B.8.0:  Drop function:fn_findSystemID if existing  ******/
IF OBJECT_ID('fn_findSystemID') IS NOT NULL
    DROP FUNCTION fn_findSystemID;
GO


/****** B.8.1:  Create function:fn_findSystemID ******/
CREATE FUNCTION fn_findSystemID
	(@Asset_key varchar(60))
	RETURNS INT

BEGIN
	RETURN (SELECT SystemID FROM System WHERE Asset_key = @Asset_key);
END;
GO







/****** B.9.0:  Drop stored procedures:sp_addSoftware if existing  ******/
IF OBJECT_ID('sp_assignSoftware') IS NOT NULL
    DROP PROC sp_assignSoftware;
GO

/****** B.9.1:  Create stored procedures:sp_assignSoftware  ******/
CREATE PROC sp_assignSoftware
	@Asset_key varchar(60),
	@FullName varchar(60) = NULL,
	@ApprovedBy varchar(60) = NULL

AS

	DECLARE @SystemID INT;
	DECLARE @EmployeeID INT, @Employee_ManageID INT;
	DECLARE @ManagerID INT;
	SET @SystemID = dbo.fn_findSystemID(@Asset_key);
	IF @FullName IS NOT NULL
		SET @EmployeeID = dbo.fn_findEmployeeID(@FullName);
	IF @ApprovedBy IS NOT NULL
		SET @Employee_ManageID = dbo.fn_findEmployeeID(@ApprovedBy);
		SET @ManagerID = dbo.fn_findManagerID(@Employee_ManageID);

	INSERT SoftwareManage
	VALUES (
		@SystemID ,
		@EmployeeID,
		@ManagerID);
GO



/* 

- Part C - Populate database by using the following stored procedure calls. 

*/
GO

/****** Part C.1 Add employees: ******/
EXEC sp_addEmployee 'Mickey','Mouse','01/02/1933','90012'
EXEC sp_addEmployee 'Minnie','Mouse','02/03/1933','90012'
EXEC sp_addEmployee 'Donald', 'Duck','03/04/1944','30011'
EXEC sp_addEmployee 'Porky', 'Pig','05/06/1956','90056'
EXEC sp_addEmployee 'Mister', 'Incredible','05/06/1956','90056'
EXEC sp_addEmployee 'Snow', 'White','07/08/1962','32700'


/******  Part C.2 Add offices: ******/
EXEC sp_addOffice 'Ariel',100,'92801','Mickey Mouse'
EXEC sp_addOffice 'Looney Tunes',500,'91522','Minnie Mouse'
EXEC sp_addOffice 'Olaf',300,'32830','Mickey Mouse'
EXEC sp_addOffice 'Simba',300,'32830','Mister Incredible'



/******  Part C.3 Assign employee’s to an office ******/
EXEC sp_addEmployeeOffice 'Mickey Mouse','Ariel'
EXEC sp_addEmployeeOffice 'Mickey Mouse','Olaf'
EXEC sp_addEmployeeOffice 'Mickey Mouse','Looney Tunes'
EXEC sp_addEmployeeOffice 'Donald Duck','Olaf'
EXEC sp_addEmployeeOffice 'Porky Pig','Looney Tunes'
EXEC sp_addEmployeeOffice 'Minnie Mouse','Ariel'
EXEC sp_addEmployeeOffice 'Minnie Mouse','Olaf'
EXEC sp_addEmployeeOffice 'Mister Incredible','Simba'
EXEC sp_addEmployeeOffice 'Snow White','Ariel'
EXEC sp_addEmployeeOffice 'Snow White','Olaf'



/******  Part C.4 Add software licenses to the system ******/
EXEC sp_addSoftware 'MW08ABCD','Microsoft','Windows','08','01/01/2017'
EXEC sp_addSoftware 'AA13EFGH','Adobe','Acrobat','14','01/06/2016'
EXEC sp_addSoftware 'MO16IJKLM','Microsoft','Windows','10','01/01/2017'
EXEC sp_addSoftware 'MW10NOPQ','Microsoft','Windows','10','01/01/2017'
EXEC sp_addSoftware 'MW11RSTU','Microsoft','Windows','11','01/01/2017'
EXEC sp_addSoftware 'MW13VWXY','Microsoft','Windows','13','01/01/2017'
EXEC sp_addSoftware 'MW14ZABC','Microsoft','Windows','14','01/01/2017'
EXEC sp_addSoftware 'AA12EFGH','Adboe','Acrobat','12','10/01/2017'
EXEC sp_addSoftware 'AA11IJKL','Adboe','Acrobat','11','10/01/2017'



/******  Part C.5 Add software licenses to employees ******/
EXEC sp_assignSoftware 'MW08ABCD','Mickey Mouse','Mickey Mouse'
EXEC sp_assignSoftware 'AA13EFGH','Mickey Mouse','Mickey Mouse'
EXEC sp_assignSoftware 'MO16IJKLM','Mickey Mouse','Mickey Mouse'
EXEC sp_assignSoftware 'MW10NOPQ','Donald Duck','Minnie Mouse'
EXEC sp_assignSoftware 'MW11RSTU','Minnie Mouse','Mickey Mouse'
EXEC sp_assignSoftware 'MW13VWXY','Mister Incredible','Minnie Mouse'
EXEC sp_assignSoftware 'MW14ZABC','Porky Pig','Mickey Mouse'
EXEC sp_assignSoftware 'MW14ZABC','Porky Pig','Minnie Mouse'
EXEC sp_assignSoftware 'MW14ZABC'





/*

- Part D - Create a Software Archive
	
	-- You realize the current system doesn’t allow historical tracking when 
	software licenses are re-assigned to employees (eg. termination, job role 
	change,etc..).
	-- You decide to create that capability.
		*** Add a way to track changes to software assignments:
			**** Use a new table SoftwareArchive that tracks the assignment 
			changes and is automatically populated via a trigger. 
				***** In the new table use a datetime mechanism to track when 
				the change was made (aka a timestamp)
				***** It’s not critical to know specifically the types of changes 
				(e.g. think of this as a running log of changes).
				***** Test the tracking with the following statements and 
				verify they have been logged in the Software Archive.
	-- In working through the changes you realize there is a need for another function.
		*** Create fn_findEmployee: Parameters (employee id)
		*** employee id is the numeric id of the employee record in the Employee table
		*** Action: returns the fullname version of the employee’s name
			**** HINT: fullname is the firstname + ‘ ‘ +lastname
	-- Create a table VIEW -  vSoftwareArchive that will allow you to view 
	the assignment changes. 
		*** Fields in the view should be : asset_key, assignedTo, 
		approvedBy, dateUpdated
		*** assignedTo and approvedBy should be displayed as the fullname 
		of the employees, rather than an internal identity key.
		*** Incorporate the new fn_findEmployee function in this view.

*/
GO

USE FinalProject;
GO


/****** D.1.0:  Drop a trigger and a table   ******/
DROP TRIGGER IF EXISTS Software_INSERT_AUDIT;
GO

/****** D.1.1:  Create a trigger that audit the SoftwareArchive when inserted  ******/
CREATE TRIGGER Software_INSERT_AUDIT
ON SoftwareManage
FOR INSERT
AS
INSERT INTO SoftwareArchive
(SystemID, EmployeeID, ManagerID, DateUpdated)
VALUES(
(SELECT SystemID FROM Inserted),
(SELECT EmployeeID FROM Inserted),
(SELECT ManagerID FROM Inserted),
GETDATE());

GO

/*
-- Test Data
EXEC sp_assignSoftware 'AA11IJKL','Porky Pig','Mickey Mouse'
EXEC sp_assignSoftware 'AA12EFGH','Porky Pig','Minnie Mouse'
EXEC sp_assignSoftware 'AA11IJKL'

*/
GO

USE FinalProject;
GO


/****** D.2.0:  Drop function:fn_findEmployee if existing  ******/
IF OBJECT_ID('fn_findEmployee') IS NOT NULL
    DROP FUNCTION fn_findEmployee;
GO


/****** D.2.1:  Create function:fn_findEmployee  ******/
CREATE FUNCTION fn_findEmployee
	(@Parameters INT)
	RETURNS varchar(60)


BEGIN
	DECLARE @FirstName varchar(60), @LastName varchar(60);
	
	SELECT @FirstName = FirstName, @LastName = LastName
	FROM Employees
	WHERE EmployeeID = @Parameters;
	RETURN ( @FirstName + ' ' + @LastName)
END;
GO


USE FinalProject;
GO

/****** D.3.0:  Drop function:fn_findEmployeeBYManager if existing  ******/
IF OBJECT_ID('fn_findEmployeeBYManager') IS NOT NULL
    DROP FUNCTION fn_findEmployeeBYManager;
GO


/****** D.3.1:  Create function:fn_findEmployeeBYManager  ******/
CREATE FUNCTION fn_findEmployeeBYManager
	(@ManagerID INT)
	RETURNS varchar(60)

BEGIN
	DECLARE @FirstName varchar(60), @LastName varchar(60);
	DECLARE @EmployeeID INT;
	SELECT @EmployeeID = EmployeeID 
		FROM Manager 
			WHERE ManagerID = @ManagerID;
	SELECT @FirstName = FirstName, @LastName = LastName
	FROM Employees 
	WHERE EmployeeID = @EmployeeID;
	RETURN ( @FirstName + ' ' + @LastName)
END;
GO


USE FinalProject;
GO



/****** D.4.0:  Drop a view   ******/
DROP VIEW IF EXISTS vSoftwareArchive;
GO

/****** D.4.1:  Create a view vSoftwareArchive ******/

CREATE VIEW vSoftwareArchive


AS 
SELECT Asset_key, dbo.fn_findEmployee(EmployeeID) AS assignedTo, 
	dbo.fn_findEmployeeBYManager(ManagerID) AS approvedBy
FROM System JOIN SoftwareArchive 
ON System.SystemID = SoftwareArchive.SystemID;
GO


/* Test

USE FinalProject;
GO

SELECT * FROM vSoftwareArchive;

*/


/*
- Part E - SoftwareArchive2 view
	-- After completing the view in Part D, you realize there’s an alternative 
	way to implement the view that doesn’t require use of the findEmployee 
	function (or any function). You decide to create a new view SoftwareArchive2. 
		*** This view displays the same data fields as the vSoftwareArchive 
		(but doesn’t reference it), only it uses one or more JOINs instead of 
		the fn_findEmployee function.

*/
GO


USE FinalProject;
GO

/****** E.1.0:  Drop a view   ******/
DROP VIEW IF EXISTS TempmanageID;
GO


/****** E.1.1:  Create a view SoftwareArchive2 ******/
CREATE VIEW TempmanageID
AS
SELECT Asset_key, (FirstName + ' ' + LastName) AS assignedTo, Manager.EmployeeID
	FROM SoftwareArchive 
		LEFT JOIN System
			ON System.SystemID = SoftwareArchive.SystemID
		LEFT JOIN Employees
			ON Employees.EmployeeID = SoftwareArchive.EmployeeID
		LEFT JOIN Manager
			ON Manager.ManagerID = SoftwareArchive.ManagerID

GO


/****** E.2.0:  Drop a view   ******/
DROP VIEW IF EXISTS SoftwareArchive2;
GO


/****** E.1.1:  Create a view SoftwareArchive2 ******/
CREATE VIEW SoftwareArchive2
AS
SELECT Asset_key, assignedTo, (FirstName + ' ' + LastName) AS approvedBy
FROM TempmanageID
	LEFT JOIN Employees
		ON Employees.EmployeeID = TempmanageID.EmployeeID
GO

/****** E.1.0:  Drop a view   ******/
DROP VIEW IF EXISTS TempmanageID;
GO


/* Test

USE FinalProject;
GO

SELECT * FROM SoftwareArchive2;

*/



SELECT Asset_key, (FirstName + ' ' + LastName) AS assignedTo, Manager.EmployeeID
	FROM SoftwareArchive 
		LEFT JOIN System
			ON System.SystemID = SoftwareArchive.SystemID
		LEFT JOIN Employees
			ON Employees.EmployeeID = SoftwareArchive.EmployeeID
		LEFT JOIN Manager
			ON Manager.ManagerID = SoftwareArchive.ManagerID
		LEFT JOIN Employees
			ON Employees.EmployeeID = SoftwareArchive.EmployeeID
