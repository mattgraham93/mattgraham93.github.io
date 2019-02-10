--*  BUSIT 103					Assignment   #3						DUE DATE :  Consult course calendar
							
/*  You are to develop SQL statements for each task listed. You should type your SQL statements 
	under each task. You should always create an alias for any derived fields. Add a sort that makes 
	sense for each query. */



USE AdventureWorksLT2012;



--1.	Build a single column of data in which you concatenate the text ...
--
--			Welcome back, 
--		
--		.. to the FirstName and LastName field for each customer, and then to an exclamation point. 
--		The first record should display as follows:
--
--			Welcome back, Catherine Abel!
--
--		Give the column the alias WelcomeDisplay.
--		Order the results in alphabetical order by last name then by first name.


SELECT CONCAT('Welcome back, ', FirstName, ' ', LastName, '!') as WelcomeDisplay
FROM SalesLT.Customer;




--2.	Using concatenation, build a single column of data that displays as follows:
--
--			Catherine Abel your ID is 29485.
--		
--		Note that in the sample display Catherine Abel and 29485 come from fields.
--		And note that " your ID is " and the period at the end of the phrase are static text.
--
--		Give the column the alias CustomerDisplay.
--		Order the results in alphabetical order by last name then by first name.


SELECT CONCAT(FirstName, ' ', LastName, ' your ID is ', CustomerID) as CustomerDisplay
FROM SalesLT.Customer
ORDER BY LastName, Firstname;


--3.	Using concatenation, build a single column of data that displays product category numbers   
--		and names in one column as follows:
--	 
--					Product Category 1: Bikes 
--
--		Note that "Product Category" and the colon ":" are static text. 
--		Note that number and name, in this case the 1 the name Bikes, are field values.
--		Give the column a meaningful alias and sort order.


SELECT CONCAT('Product Category ', ProductCategoryID, ': ', Name) as ProductCategoryDisplay
FROM SalesLT.ProductCategory
ORDER BY ProductCategoryID, Name;

	
--4.	Run and view the following code:

		select 
			SalesOrderID
			, UnitPrice * (1-UnitPriceDiscount) * OrderQty
			, LineTotal
		from [SalesLT].[SalesOrderDetail];

--		Copy and paste the above code into a. and b. below where you will use CAST() and CONVERT() on 
--		Columns 2 and 3 to display numeric values to exactly 2 decimal places. Column 2 and 3 should 
--		show the same amount. LineTotal (Column 3) is included to double check your calculation; 
--		the two amounts should match. Add a meaningful sort to the statement.


--a.	CAST is the ANSI standard. Write the statement using CAST with decimal as the data type.

		select SalesOrderID, CAST(UnitPrice * (1-UnitPriceDiscount) * OrderQty AS decimal(10,2)), LineTotal as OrderTotal
		from [SalesLT].[SalesOrderDetail];



--b.	Write the statement again using CONVERT with decimal as the data type. CONVERT is a T-SQL function. 
--	     
		select SalesOrderID, CONVERT(decimal(10,2), UnitPrice * (1-UnitPriceDiscount) * OrderQty), LineTotal as OrderAmount
		from [SalesLT].[SalesOrderDetail];


--5.	AdventureWorks predicts a 6% increase in production costs for all their products.   
--		They wish to see how the increase will affect their profit margins. To help them 
--		understand the impact of this increase in production costs (StandardCost), you will create 
--		a list of all products showing ProductID, Name, ListPrice, FutureCost (use StandardCost * 1.06  
--		to compute FutureCost), and Profit (use ListPrice minus the calculation for FutureCost to find Profit). 
--
--		All money values are to show exactly 2 decimal places. Order the results descending by Profit. 
--		FYI:  Read online about the "Logical Query Processing Phases".  It will explain why you
--		cannot use an alias created in the SELECT clause in a calculation but can use it in the ORDER BY clause.

--	a.	First write the requested statement using CAST. CAST is the ANSI standard. There will be five 
--		fields (columns). There will be one row for each product in the Product table. 


SELECT [ProductID], [Name], [ListPrice], CAST([StandardCost]*1.06 as decimal(10,2)) as FutureCost, CAST([ListPrice]-([StandardCost]*1.06) as decimal(10,2)) as Profit
FROM [SalesLT].[Product];


--b.	Next write the statement from 5a again using CONVERT. There will be five 
--		fields (columns). There will be one row for each product in the Product table. 


SELECT [ProductID], [Name], [ListPrice], CONVERT(decimal(10,2),[StandardCost]*1.06) as FutureCost, CONVERT(decimal(10,2), [ListPrice]-([StandardCost]*1.06)) as Profit
FROM [SalesLT].[Product];


--6.	For a. and b. below, list all sales orders showing PurchaseOrderNumber, SalesOrderID, CustomerID, OrderDate, 
--		DueDate, and ShipDate. Format the datetime fields so that no time is displayed. Be sure to give each derived 
--		column an alias and add a meaningful sort to each statement. 

--a.	CAST is the ANSI standard. Write the statement using CAST. 

SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CAST([OrderDate] AS DATE) as OrderDate, CAST([DueDate] AS DATE) as DueDate, CAST([ShipDate] AS DATE) as ShipDate
FROM [SalesLT].[SalesOrderHeader];

--b.	Write the statement again using CONVERT.

SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CONVERT(varchar(10),CAST([OrderDate] AS DATE),101) as OrderDate, CONVERT(varchar(10),CAST([DueDate] AS DATE),101) as DueDate, CONVERT(varchar(10),CAST([ShipDate] AS DATE),101) as ShipDate
FROM [SalesLT].[SalesOrderHeader];

--c.	Write a statement using either 6a or 6b add a field that calculates the 
--		difference between the due date and the ship date. Name the field ShipDays and show
--		the result as a positive number. Be sure Datetime fields still show only the date.
--		The DateDiff function is not an ANSI standard; don't use it in this statement.

SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CAST([OrderDate] AS DATE) as OrderDate, CAST([DueDate] AS DATE) as DueDate, CAST([ShipDate] AS DATE) as ShipDate, CAST([DueDate] - [ShipDate] AS int) as ShipDays
FROM [SalesLT].[SalesOrderHeader];

--d.	Rewrite the statement from 6c to use the DateDiff function to find the
--		difference between the OrderDate and the ShipDate. Again, show only the date in datetime fields.

SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CAST([OrderDate] AS DATE) as OrderDate, CAST([DueDate] AS DATE) as DueDate, CAST([ShipDate] AS DATE) as ShipDate, DateDiff(day,[ShipDate],[DueDate]) as ShipDays
FROM [SalesLT].[SalesOrderHeader];
 
--7.	EXPLORE: Research the following on the Web for an answer:
--		Find a date function that will return a datetime value that contains the date and time from the computer
--		on which the instance of SQL Server is running (this means it shows the date and time of the PC on which 
--		the function is executed). The time zone offset is not included. Write the statement so it will execute.
--		Format the result to show only the date portion of the field and give it the alias of MyPCDate.


SELECT SYSDATETIME();

