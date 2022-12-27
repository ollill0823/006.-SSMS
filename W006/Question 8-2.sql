USE MyWebDb
GO

-- A) Write the SQL to create this table structure --
-- A-1) Drop the existing table and create a new one --
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
-- B-1) Drop the existing table and create a new one --
IF OBJECT_ID('AssetIT') IS NOT NULL
	DROP TABLE AssetIT

IF OBJECT_ID('AssetFacilities') IS NOT NULL
	DROP TABLE AssetFacilities

IF OBJECT_ID('AssetCafeteria') IS NOT NULL
	DROP TABLE AssetCafeteria
GO

-- B-1) Drop the existing table and create a new one --
SELECT asset_id, asset_name INTO AssetIT FROM AssetList
WHERE asset_type = 'it'

SELECT asset_id, asset_name INTO AssetFacilities FROM AssetList
WHERE asset_type = 'facilities'

SELECT asset_id, asset_name INTO AssetCafeteria FROM AssetList
WHERE asset_type = 'cafeteria'
GO


IF OBJECT_ID('AssetIT') IS NOT NULL
	DROP TABLE AssetIT
GO

IF OBJECT_ID('AssetFacilities') IS NOT NULL
	DROP TABLE AssetFacilities
GO

IF OBJECT_ID('AssetCafeteria') IS NOT NULL
	DROP TABLE AssetCafeteria
GO

CREATE TABLE AssetIT
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL,
CHECK (asset_type = 'it')
)
GO

CREATE TABLE AssetFacilities
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL CHECK (asset_type = 'facilities')
)
GO

CREATE TABLE AssetCafeteria
(
asset_id INT NOT NULL,
asset_name varchar(10) NOT NULL,
asset_type varchar(10) NOT NULL CHECK (asset_type = 'cafeteria')
)
GO


INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'computer', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'server', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'desk', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'mouse', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'lamp', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'plate', 'it')
INSERT INTO AssetIT VALUES 
(NEXT VALUE for TestSequence1, 'utensil', 'facilities')
GO



IF OBJECT_ID('GlobalAssetList ') IS NOT NULL
	DROP view GlobalAssetList 
GO


CREATE VIEW GlobalAssetList 
AS
	SELECT asset_id, asset_name, 'AssetIT' AS [From] FROM AssetIT
UNION
	SELECT asset_id, asset_name, 'AssetFacilities' AS [From] FROM AssetFacilities
UNION 
	SELECT asset_id, asset_name, 'AssetCafeteria' AS [From] FROM AssetCafeteria
GO


SELECT * FROM GlobalAssetList 