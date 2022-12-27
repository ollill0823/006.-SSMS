/*

Note: There are 4 parts to the response(A-D).

Use comments  to delineate your response

--Ensure that the script can be executed from beginning to end without error 
(over multiple runs)

-- A Add query part for Part A
-- B Add query part for Part B
-- C Add query part for Part C
-- D Add query part for Part D

You have been asked to work with the backoffice team to develop an asset 
tracking system that simply tracks an asset id (asset_id), an asset name 
(asset_name), and an asset type (asset_type). You decide to track everything 
in a table AssetList;
 

Approach HINT: Asset IDs need to be unique and in SEQUENCEd order and not 
hardcoded - starting with 1 and incrementing by 1
 
A) Write the SQL to create this table structure

AssetList Table data


|asset_id    | asset_name |    asset_type
1               computer        it
2               server          it
3               desk        facilities
4               mouse           it
5               lamp        facilities
6               plate        cafeteria
7               utensil      cafeteria
 

B)Write the SQL to create the 3 Tables and any associated CREATE statements
 
Now that you and your team have shown the departments your prototype,
they have each requested a separation of the data table by asset_type.
 
In other words, you'll need to create the solution with 3 different tables 
(AssetIT, AssetFacilities, AssetCafeteria) Each of the tables will have 
the asset id and the asset name.
 
You'll need to create a way to track the SEQUENCEd  assets "globally" 
(across all asset-type tables), and the asset ids still need to be unique 
across the 3 tables.

Depending on how the tables are populated, one "potential" view of this could be
(e.g. asset_id could be a different distribution)


C) Write the INSERT statements to populate them. 
Note after the insert statements you table should look like this
Use the following table data for your response.

AssetIT table
|asset_id |asset_name
1           computer
2            server
4            mouse
 

AssetFacilities
|asset_id |asset_name
3             desk
5             lamp
 

AssetCafeteria
|asset_id |asset_name
6             plate
7             utensil
 

D) Create a single view GlobalAssetList that displays all of the assets across 
all the tables.



*/


-------------------------Answer from me ------------------------------


USE MyWebDb
GO

-- A) Write the SQL to create this table structure --
-- A-1) Drop the existing table --
IF OBJECT_ID('AssetList') IS NOT NULL
	DROP TABLE AssetList
GO

IF OBJECT_ID('TestSequence1') IS NOT NULL
	DROP SEQUENCE TestSequence1
GO

-- A-2) Create a increment sequence --
CREATE SEQUENCE TestSequence1
	START WITH 1
	INCREMENT BY 1

-- A-3) Create a table AssetList, including asset_id, asset_name, asset_type --
CREATE TABLE AssetList
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL,
)
GO

-- A-4) Insrt rawdata into the table --
INSERT INTO AssetList
VALUES 
(NEXT VALUE for TestSequence1, 'computer', 'it'),
(NEXT VALUE for TestSequence1, 'server', 'it'),
(NEXT VALUE for TestSequence1, 'desk', 'facilities'),
(NEXT VALUE for TestSequence1, 'mouse', 'it'),
(NEXT VALUE for TestSequence1, 'lamp', 'facilities'),
(NEXT VALUE for TestSequence1, 'plate', 'cafeteria'),
(NEXT VALUE for TestSequence1, 'utensil', 'cafeteria')
GO

-- B)Write the SQL to create the 3 Tables and any associated CREATE statements --
-- B-1) Drop the existing table --
IF OBJECT_ID('AssetIT') IS NOT NULL
	DROP TABLE AssetIT

IF OBJECT_ID('AssetFacilities') IS NOT NULL
	DROP TABLE AssetFacilities

IF OBJECT_ID('AssetCafeteria') IS NOT NULL
	DROP TABLE AssetCafeteria

-- B-2) Create table AssetIT --
CREATE TABLE AssetIT
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL,
CONSTRAINT CK__AssetIT__asset_t CHECK (asset_type = 'it')
)
GO

-- B-3) Create table AssetFacilities --
CREATE TABLE AssetFacilities
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL CONSTRAINT CK__AssetFacilities__asset_t CHECK (asset_type = 'facilities')
)
GO

-- B-4) Create table AssetCafeteria --
CREATE TABLE AssetCafeteria
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL CONSTRAINT CK__AssetCafeteria__asset_t CHECK (asset_type = 'cafeteria')
)
GO

-- C) Write the INSERT statements to populate them. --
-- C-1.1) Restart sequence start from 1 --
ALTER SEQUENCE TestSequence1
	RESTART WITH 1

-- C-1.2) Insert data into Table AssetIT --
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'computer', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'server', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'desk', 'facilities')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'mouse', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'lamp', 'facilities')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'plate', 'cafeteria')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'utensil', 'cafeteria')
GO

-- C-1.3) Delete constraint, because I want to delete column asset_type --
ALTER TABLE AssetIT DROP CONSTRAINT CK__AssetIT__asset_t;
-- C-1.4) Delete column asset_type --
ALTER TABLE AssetIT DROP COLUMN asset_type
GO

-- C-2.1) Restart sequence start from 1 --
ALTER SEQUENCE TestSequence1
	RESTART WITH 1
GO

-- C-2.2) Insert data into Table AssetFacilities --
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'computer', 'it')
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'server', 'it')
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'desk', 'facilities')
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'mouse', 'it')
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'lamp', 'facilities')
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'plate', 'cafeteria')
INSERT INTO AssetFacilities VALUES 
(NEXT VALUE for TestSequence1, 'utensil', 'cafeteria')
GO

-- C-2.3) Delete constraint, because I want to delete column asset_type --
ALTER TABLE AssetFacilities DROP CONSTRAINT CK__AssetFacilities__asset_t;
-- C-2.4) Delete column asset_type --
ALTER TABLE AssetFacilities DROP COLUMN asset_type
GO

-- C-3.1) Restart sequence start from 1 --
ALTER SEQUENCE TestSequence1
	RESTART WITH 1
GO

-- C-3.2) Insert data into Table AssetCafeteria --
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'computer', 'it')
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'server', 'it')
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'desk', 'facilities')
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'mouse', 'it')
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'lamp', 'facilities')
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'plate', 'cafeteria')
INSERT INTO AssetCafeteria VALUES 
(NEXT VALUE for TestSequence1, 'utensil', 'cafeteria')
GO

-- C-3.3) Delete constraint, because I want to delete column asset_type --
ALTER TABLE AssetCafeteria DROP CONSTRAINT CK__AssetCafeteria__asset_t;
-- C-3.4) Delete column asset_type --
ALTER TABLE AssetCafeteria DROP COLUMN asset_type
GO




-- B/C extended)  --
-- B/C extended-1) Drop the existing table --
IF OBJECT_ID('AssetIT') IS NOT NULL
	DROP TABLE AssetIT

IF OBJECT_ID('AssetFacilities') IS NOT NULL
	DROP TABLE AssetFacilities

IF OBJECT_ID('AssetCafeteria') IS NOT NULL
	DROP TABLE AssetCafeteria
GO

-- B/C extended-2) summary and copy specified column into a new table --
SELECT asset_id, asset_name INTO AssetIT FROM AssetList
WHERE asset_type = 'it'

SELECT asset_id, asset_name INTO AssetFacilities FROM AssetList
WHERE asset_type = 'facilities'

SELECT asset_id, asset_name INTO AssetCafeteria FROM AssetList
WHERE asset_type = 'cafeteria'
GO




-- D) Create a single view GlobalAssetList that displays all of the assets across all the tables.--
-- D-1) Drop the existing table --
IF OBJECT_ID('GlobalAssetList ') IS NOT NULL
	DROP view GlobalAssetList 
GO

-- D-2) Create a view table GlobalAssetList  --
CREATE VIEW GlobalAssetList 
AS
	SELECT asset_id, asset_name, 'AssetIT' AS [From] FROM AssetIT
UNION
	SELECT asset_id, asset_name, 'AssetFacilities' AS [From] FROM AssetFacilities
UNION 
	SELECT asset_id, asset_name, 'AssetCafeteria' AS [From] FROM AssetCafeteria
GO


SELECT * FROM GlobalAssetList 


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


-- A)
CREATE TABLE AssetList
(asset_id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
asset_name VARCHAR(50),
asset_type VARCHAR(15)
);


--B) Create Objects
CREATE SEQUENCE AssetSequence START WITH 1;

CREATE TABLE AssetIT
(asset_id INTEGER NOT NULL PRIMARY KEY,
asset_name VARCHAR(50) );

CREATE TABLE AssetFacilities
(asset_id INTEGER NOT NULL PRIMARY KEY,
asset_name VARCHAR(50) );

CREATE TABLE AssetCafeteria
(asset_id INTEGER NOT NULL PRIMARY KEY,
asset_name VARCHAR(50) );

--C) Create Insert statements
INSERT INTO AssetIT VALUES (NEXT VALUE FOR AssetSequence,'computer');
INSERT INTO AssetIT VALUES (NEXT VALUE FOR AssetSequence,'server');
INSERT INTO AssetFacilities VALUES (NEXT VALUE FOR AssetSequence,'asset_name');
INSERT INTO AssetIT VALUES (NEXT VALUE FOR AssetSequence,'mouse');
INSERT INTO AssetFacilities VALUES (NEXT VALUE FOR AssetSequence,'lamp');
INSERT INTO AssetCafeteria VALUES (NEXT VALUE FOR AssetSequence,'plate');
INSERT INTO AssetCafeteria VALUES (NEXT VALUE FOR AssetSequence,'utensil');

--D) View Global list
GO
CREATE VIEW GlobalAssetList AS
SELECT * from AssetIT UNION
SELECT * from AssetFacilities UNION
SELECT * from AssetCafeteria

select * from GlobalAssetList