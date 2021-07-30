--*  BUSIT 103           Assignment   #4              DUE DATE:  Consult course calendar
							
/*	You are to develop SQL statements for each task listed. You should type your SQL statements under each task. 
	You should test each SQL statement using the database shown in the USE statement. The SQL statement should 
	execute against that database without errors. */


--Do not remove the USE statement
USE AdventureWorksLT2012;

--1.  Use the SalesLT.Address table to list addresses in the United States. Select the address1, 
--    city, state/province, country/region and postal code. Sort by state/province and city.

SELECT [AddressLine1], [City], [StateProvince], [PostalCode]
FROM [SalesLT].[Address]
ORDER BY [StateProvince], [City] ASC;


--2.  Use the SalesLT.Address table to list addresses in the US states of Idaho or Montana. 
--    Select the address1, city, state/province, country/region and postal code. Sort by state/province and city.

SELECT [AddressLine1], [City], [StateProvince], [CountryRegion], [PostalCode]
FROM [SalesLT].[Address]
WHERE [StateProvince] IN ('Idaho', 'Montana')
ORDER BY [StateProvince], [City] ASC;

--3.	Use the SalesLT.Address table to list addresses in the cities of Victoria or Vancouver. 
--		Select the address1, city, state/province, country/region and postal code.
--		Order the list by city.

SELECT [AddressLine1], [City], [StateProvince], [CountryRegion], [PostalCode]
FROM [SalesLT].[Address]
WHERE [City] IN ('Victoria', 'Vancouver')
ORDER BY [City] ASC;

--4.	Use the SalesLT.Address table to list addresses in the cities of Victoria or Vancouver in the 
--		Canadian province of British Columbia. Select the address1, city, state/province, country/region 
--		and postal code. Order the list by city.

SELECT [AddressLine1], [City], [StateProvince], [CountryRegion], [PostalCode]
FROM [SalesLT].[Address]
WHERE [StateProvince] = 'British Columbia' and [City] IN ('Victoria', 'Vancouver')
ORDER BY [City] ASC;

--5.	List the company name and phone for those customers whose phone number contains the following sequence: 34.
--		Order the list by phone number in ascending order. "Contains" means that the sequence exists within the phone number.


SELECT [CompanyName], [Phone]
FROM [SalesLT].[Customer]
WHERE [Phone] LIKE '34%'

--6.	List the name, product number, size, standard cost, and list price in alphabetical order by name 
--		for Products whose standard cost is $1500 or more. Show all money values at exactly two decimal places. 
--		Be sure to give each derived column an alias.

SELECT [Name], [ProductNumber], [Size], CAST([StandardCost] AS DECIMAL(10,2)) AS StandardCost, CAST([ListPrice] AS DECIMAL(10,2)) AS ListPrice
FROM [SalesLT].[Product]
WHERE [StandardCost]>= 1500
ORDER BY [Name]

--7.	List the name, product number, size, standard cost, and list price in alphabetical order by name 
--		for Products whose list price is $100 or less and standard cost is $40 or more.

SELECT [Name], [ProductNumber], [Size], CAST([StandardCost] AS DECIMAL(10,2)) AS StandardCost, CAST([ListPrice] AS DECIMAL(10,2)) AS ListPrice
FROM [SalesLT].[Product]
WHERE [ListPrice]<= 100 AND [StandardCost]>=40
ORDER BY [Name]

--8.	List the name, standard cost, list price, and size for products whose size is one of the 
--		following:  XS, S, M, L, XL. Show all money values at exactly two decimal places. Be sure to 
--		give each derived column an alias. Order the list by name in alphabetical order.

SELECT [Name], CAST([StandardCost] AS DECIMAL(10,2)) AS StandardCost, [Size]
FROM [SalesLT].[Product]
WHERE [Size] IN ('XS','S','M','L','XL')
ORDER BY [Name]

--9.	List the name, product number, and sell end date for all products in the Product table
--		that are not currently sold. Sort by the sell end date from most recent to oldest date. Show   
--		only the date (no time) in the sell end date field. Be sure to give each derived column an alias.

SELECT [Name], [ProductNumber], CAST([SellEndDate] AS DATE) as SellEndDate
FROM [SalesLT].[Product]
ORDER BY [SellEndDate] desc;

--10. List the name, product number, standard cost, list price, and weight for products whose standard cost  
--    is less than $50, list price is greater than $100, and weight is greater than 1,000. Round money values 
--    to exactly 2 decimal places and give each derived column a meaningful alias. Sort by weight.

SELECT [Name], [ProductNumber], CAST([StandardCost] AS DECIMAL(10,2)) AS StandardCost, CAST([ListPrice] AS DECIMAL(10,2)) AS ListPrice, Weight
FROM [SalesLT].[Product]
WHERE [StandardCost]<50 AND [ListPrice]>100 AND [Weight]>1000
ORDER BY [Weight];

--11. In a and b below, explore the data to better understand how to locate products. 

--a.  List the name, product number, and product category ID for all products in the Product 
--    table that include 'bike' in the name. Sort by the name. 
--    Something to consider: How many of these products are actually bikes?

SELECT [Name], [ProductNumber], [ProductCategoryID]
FROM [SalesLT].[Product]
WHERE [Name] like '%Bike%'
ORDER BY Name

--b.  List the name and product category id, and parent id for all categories in the product category   
--    table that include 'bike' in the name. Sort by the parent product category id. 
--    Something to consider: How many of these product categories are actually bikes? What is the  
--	  ProductCategoryID for Bikes? 

--PCI for Bikes is 1 :)
	
SELECT [Name], [ProductCategoryID], [ParentProductCategoryID]
FROM [SalesLT].[ProductCategory]
WHERE [Name] like '%Bike%'
ORDER BY Name

