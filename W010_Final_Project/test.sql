



	DECLARE @EmployeeID INT;
	DECLARE @FirstName varchar(60), @LastName varchar(60);
	DECLARE @Fullname varchar(60), @OfficeLoc varchar(60);
	SET @Fullname = 'Mickey Mouse';
	SET @FirstName = LEFT(@Fullname, CHARINDEX(' ', @Fullname)-1);
	SET @LastName = RIGHT(@Fullname, LEN(@Fullname) - CHARINDEX(' ', @Fullname));
	SELECT @EmployeeID = EmployeeID
	FROM Employees
	WHERE FirstName = @FirstName AND LastName = @LastName;

	PRINT @EmployeeID



	DECLARE @SystemID INT;
	
	DECLARE @Fullname varchar(60), @OfficeLoc varchar(60);
	SET @Fullname = 'Mickey Mouse';
	SET @FirstName = LEFT(@Fullname, CHARINDEX(' ', @Fullname)-1);
	SET @LastName = RIGHT(@Fullname, LEN(@Fullname) - CHARINDEX(' ', @Fullname));
	SELECT @EmployeeID = EmployeeID
	FROM Employees
	WHERE FirstName = @FirstName AND LastName = @LastName;

	PRINT @EmployeeID


	USE FinalProject;
	GO

	SELECT * FROM System WHERE SystemID = dbo.fn_findSystemID('MW10NOPQ');
	SELECT * FROM System WHERE Asset_key = 'MW10NOPQ';


	PRINT dbo.fn_findSystemID('MW10NOPQ')
	GO




	USE FinalProject;
	GO

	INSERT INTO Manager(OfficeMgr)
	VALUES ('Miky') WHERE NOT EXISTS (SELECT OfficeMgr FROM Manager)
	;


	 IF EXISTS (SELECT 1 FROM Tbl WHERE UniqueColumn = 'Something')
 BEGIN
     UPDATE Tbl 
     SET ...
     WHERE UniqueColumn = 'Something';
 END
 ELSE
 BEGIN
     INSERT INTO Tbl
     SELECT ...
 END


 	USE FinalProject;
	GO

 IF NOT EXISTS ( SELECT OfficeMgr FROM Manager WHERE OfficeMgr = 'Miky')
 BEGIN
	INSERT INTO Manager
	VALUES('Miky2')
END;