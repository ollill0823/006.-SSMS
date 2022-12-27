/*

Hi Class,

Topic: Table Create, Insert data

 

1.1 Create two tables in the database New_AP based on the snapshot I have pictured;

1.2 Insert data into the separate two tables (the information I have attached in 
Appendix 4).

 
*/



USE New_AP
GO


CREATE TABLE Friends
( CastID  INT NOT NULL PRIMARY KEY,
CastFirstName varchar(50) NOT NULL,
CastLastName varchar(50) NOT NULL);


CREATE TABLE Characters
( CastID  INT NOT NULL PRIMARY KEY,
ActualFirstName varchar(50) NOT NULL,
ActualLastName varchar(50) NOT NULL,
Sex varchar(6) NOT NULL CHECK ( Sex = 'Male' OR Sex = 'Female'),
Age INT NOT NULL CHECK (Age > 0),
BirthDate date NOT NULL);


INSERT Friends (CastID, CastFirstName, CastLastName) VALUES 
(1, 'Rachel', 'Green'),
(2, 'Monica', 'Geller'),
(3, 'Phoebe', 'Buffay'),
(4, 'Joey', 'Tribbiani'),
(5, 'Chandler', 'Bing'),
(6, 'Ross', 'Geller')
GO

INSERT Characters (CastID, ActualFirstName, ActualLastName, Sex, Age, BirthDate) VALUES 
(1, 'Jennifer', 'Aniston', 'Female', 53, '1968-02-11'),
(2, 'Courteney', 'Cox', 'Female', 57, '1964-06-15'),
(3, 'Lisa', 'Kudrow', 'Female', 58, '1963-07-30'),
(4, 'Matt', 'LeBlanc', 'Male', 54, '1967-07-25'),
(5, 'Matthew', 'Perry', 'Male', 52, '1969-08-19'),
(6, 'David', 'Schwimmer', 'Male', 55, '1966-11-02')
GO