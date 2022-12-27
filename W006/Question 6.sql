/*

You are teaming with the eCommerce group of engineers to develop a front-end 
drop down interface widget for the site. The widget essentially lists the 
the product categories available
to be assigned to the products. (e.g. Basses, Drums, Guitars, and Keyboards).
 
Your strategy  to create a view (category_list) that includes the name 
of the categories, only. This view is then accessed by the widget to post 
on the front-end application dropdown.
 
You've been asked by the engineering lead to create the table view (category_list) 
so that it  prevents any of the engineers, or administrators from making any 
changes to the underlying Categories table, as occasionally team members may 
not realize there is a view that could be affected if they make any 
structural/content changes to the table.

HINT: Review the CREATE VIEW documentation on how to limit changes to the 
underlying table's SCHEMA.


*/


-------------------------Answer from me ------------------------------


USE MyGuitarShop
GO

---  Drop the exisitng view ---
IF OBJECT_ID('Category_list') IS NOT NULL
	DROP VIEW Category_list
GO

---  Create a view table named Category_list ---
CREATE VIEW Category_list
AS
SELECT CategoryName
FROM Categories
GO

SELECT * FROM Category_list


-------------------------Answer from the teacher ------------------------------
USE MyGuitarShop
GO


-- Not necessarily part of the answer, but helps in developing it.
-- Clean up

Use MyGuitarShop;

DROP VIEW IF EXISTS category_list;
DROP TABLE IF EXISTS categories2;

-- create copy of categories that doesn't have any constraints.
SELECT * INTO categories2 from Categories;
GO

-- ANSWER (without schema, errors)
CREATE VIEW dbo.category_list WITH SCHEMABINDING as
  SELECT CategoryName
    FROM
  dbo.categories2;

-- verify view
GO
SELECT * from category_list
SELECT * FROM categories2

-- Test failure, could also test other ways
ALTER TABLE categories2
DROP COLUMN CategoryName

SELECT *
FROM
  INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_NAME='Customers'