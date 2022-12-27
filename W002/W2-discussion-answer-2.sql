/*

Part I: Question

Write a SELECT statement that returns one column Comics table named 
Unique ID. Create this column using ComicName, ReleaseDate, and Publisher 
column. Sort by ComicName in descending order.

*/



GO
SELECT ComicName + ReleaseDate + and Publisher AS Unique_ID
FROM Comics
ORDER BY ComicName DESC
GO