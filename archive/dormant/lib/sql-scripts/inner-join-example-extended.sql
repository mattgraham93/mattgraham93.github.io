--*  BUSIT 103                    assignment   #6                      DUE DATE :  Consult course calendar
							
--You are to develop SQL statements for each task listed. You should type your SQL statements under 
--each task. You are required to use inner joins to solve each problem. Even if you know another method 
--that will produce the result, this module is practice in inner joins.


--NOTE: We are now using a different database. 
USE AdventureWorks2012;

/*  Reminder: You are required to use the INNER JOIN syntax to solve each problem. INNER JOIN is ANSI syntax. 
	It is generally considered more readable, especially when joining many tables. Even if you have prior 
	experience with joins, you will still use the INNER JOIN syntax and refrain from using any OUTER or 
	FULL joins for SQL Assignments 6 and 7. */



--1.a.	List any products that have product reviews.  Show product name, product ID, and comments. 
--		Sort alphabetically on the product name. Don’t over complicate this. A correctly written 
--		inner join will return only those products that have product reviews; i.e., matching values in 
--		the linking field. 

select P.Name, P.[ProductID], PR.[Comments]
from [Production].[Product] as P
	inner join Production.ProductReview as PR
		on P.ProductID = PR.ProductID
order by P.Name asc 

--1.b.	Copy/paste 1.a. to 1.b. then modify 1.b. to show only records in which the word 'heavy' is 
--		found in the Comments field. Show product ID, product name, and comments. Sort on ProductID. 

select P.Name, P.[ProductID], PR.[Comments]
from [Production].[Product] as P
	inner join Production.ProductReview as PR
		on P.ProductID = PR.ProductID
where pr.Comments like '%heavy%'
order by P.ProductID asc 

--2.a.	List product models with products. Show the product model ID, model name, product ID,
--		product name, standard cost, and class. Round all money values to exactly two decimal places. 
--		Be sure to give any derived fields an alias. order by standard cost from highest to lowest.
--		Hint: You know you need to use the Product table. Now look for a related table that contains  
--		the information about the product model and inner join it to Product on the linking field.  

select p.ProductModelID, pm.Name, p.Name, cast(p.StandardCost as decimal(10,2)), p.Class
from [Production].[Product] as P
	inner join Production.ProductModel as PM
		on p.ProductModelID = pm.ProductModelID;

--2.b.	Copy/paste 2.a. to 2.b. then modify 2.b. to list only products with a value in the  
--		class field. Do this using NULL appropriately in the where clause. Hint: Remember
--		that nothing is ever equal (on not equal) to NULL; it either is or it isn't NULL.
	
select p.ProductModelID, pm.Name as ProductModelName, p.Name as ProductName, cast(p.StandardCost as decimal(10,2)) as StandardCost, p.Class as ProductClass
from [Production].[Product] as P
	inner join Production.ProductModel as PM
		on p.ProductModelID = pm.ProductModelID
where p.Class is not null;

--2.c.	Copy/paste 2.b. to 2.c. then modify 2.c. to list only products that contain a value in 
--		the class field and contain 'fork' or 'front' in the product model name. Be sure that NULL 
--		does not appear in the Class field by using parentheses appropriately.

select p.ProductModelID, pm.Name as ProductModelName, p.Name as ProductName, cast(p.StandardCost as decimal(10,2)) as StandardCost, p.Class as ProductClass
from [Production].[Product] as P
	inner join Production.ProductModel as PM
		on p.ProductModelID = pm.ProductModelID
where p.Class is not null and (pm.name like ('%fork%') or pm.name like ('%front%'));

--3.a.	List Product categories, their subcategories and their products.  Show the category name, 
--		subcategory name, product ID, and product name, in this order. Sort in alphabetical order on 
---		category name, subcategory name, and product name, in this order. Give each Name field a 
--		descriptive alias. For example, the Name field in the Product table will have the alias ProductName.

select pc.Name as ProductCategoryName, ps.Name as ProductSubcategoryName, p.ProductID, p.Name as ProductName
from [Production].[Product] as P 
	inner join Production.ProductSubcategory as PS
		on p.ProductSubcategoryID = ps.ProductSubcategoryID
	inner join Production.ProductCategory as PC
		on ps.ProductCategoryID = pc.ProductCategoryID;

--3.b.	Copy/paste 3.a. to 3.b. then modify 3.b. to list only Products in product category 1.  
--		Show the category name, subcategory name, product ID, and product name, in this order. Sort in 
--		alphabetical order on category name, subcategory name, and product name. 
--		Hint: Add product category id field to select clause, make sure your results are correct, then 
--		remove or comment out the field.  Something to consider: Look at the data in the ProductName field. 
--		Could we find bikes by searching for 'bike' in the ProductName field?

select pc.Name as ProductCategoryName, ps.Name as ProductSubcategoryName, p.ProductID, p.Name as ProductName
from [Production].[Product] as P 
	inner join Production.ProductSubcategory as PS
		on p.ProductSubcategoryID = ps.ProductSubcategoryID
	inner join Production.ProductCategory as PC
		on ps.ProductCategoryID = pc.ProductCategoryID
order by pc.name, ps.name, p.Name;

--3.c.	Copy/paste 3.b. to 3.c. then modify 3.c. to list Products in product category 3. Make no other changes 
--		to the statement. Consider what kinds of products are in category 3. 

select pc.Name as ProductCategoryName, ps.Name as ProductSubcategoryName, p.ProductID, p.Name as ProductName
from [Production].[Product] as P 
	inner join Production.ProductSubcategory as PS
		on p.ProductSubcategoryID = ps.ProductSubcategoryID
	inner join Production.ProductCategory as PC
		on ps.ProductCategoryID = pc.ProductCategoryID
	where pc.ProductCategoryID = 3
order by pc.name, ps.name, p.Name;


--4.a.	List Product models, the categories, the subcategories, and the products.  Show the model name, 
--		category name, subcategory name, product ID, and product name in this order. Give each Name field a   
--		descriptive alias. For example, the Name field in the ProductModel table will have the alias ModelName.
--		Sort in alphabetical order by model name.
--		
select pm.Name as ProductModelName, pc.Name as ProductCategoryName, ps.name as ProductSubcategoryName, p.ProductID, p.name as ProductName
from [Production].[Product] as P
	inner join Production.ProductSubcategory as PS
		on p.ProductSubcategoryID = ps.ProductSubcategoryID
	inner join Production.ProductCategory as PC
		on ps.ProductCategoryID = pc.ProductCategoryID
	inner join Production.ProductModel as PM
		on p.ProductModelID = pm.ProductModelID

--4.b.	Copy/paste 4.a. to 4.b. then modify 4.b. to list those products in model ID 23 and  
--		are the color black. Modify the sort to order only on Product ID. 
--		Hint: Add the product model id field to the select clause to 
--		check your results and then remove or comment it out.

select pm.Name as ProductModelName, pc.Name as ProductCategoryName, ps.name as ProductSubcategoryName, p.ProductID, p.name as ProductName
from [Production].[Product] as P
	inner join Production.ProductSubcategory as PS
		on p.ProductSubcategoryID = ps.ProductSubcategoryID
	inner join Production.ProductCategory as PC
		on ps.ProductCategoryID = pc.ProductCategoryID
	inner join Production.ProductModel as PM
		on p.ProductModelID = pm.ProductModelID
where pm.ProductModelID = '23' and p.Color like 'black';

--5.	List all sales for clothing that were ordered during 2007.  Show sales order id, product ID, 
--		product name, order quantity, and line total for each line item sale. Make certain you are  
--		retrieving only clothing. There are multiple ways to find clothing. Show the results  
--		by sales order id and product name. 

select so.[SalesOrderID], so.ProductID, p.name as ProductName, so.OrderQty, cast(so.LineTotal as decimal(10,2)) as LineTotal
from [Sales].[SalesOrderDetail] as SO
	inner join Production.Product as P 
		on so.ProductID = p.ProductID
	inner join Sales.SalesOrderHeader as SH
		on so.SalesOrderID = sh.SalesOrderID
where sh.OrderDate >= '2007-01-01' and sh.OrderDate <= '2007-12-31'
order by so.SalesOrderDetailID, p.Name

