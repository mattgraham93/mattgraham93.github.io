--*  BUSIT 103           Assignment   #1              DUE DATE:  Consult course calendar
							
/*****	You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 
	To find the tables that contain the fields that are requested, consider creating a Database Diagram
	that includes only the tables from the SalesLT schema and referring to it. *****/




/***** Do not remove the USE statement. *****/

USE AdventureWorksLT2012;


--1.	List all data from the Customer table. "All data" means to include all fields and rows.
--		In your SELECT, list each of the fields from the Customer table separated by commas. 
--		i.e. Do NOT use SELECT * to display all data.

SELECT CustomerID, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt, rowguid, ModifiedDate
from SalesLT.Customer;


--2.	List all data from the Customer table.   
--		For this question, use SELECT * in your statement to display all fields. 
--
--		Note: When working with large data sets, it is best practice to list the fields in 
--		your SELECT separated by commas. However, you may use SELECT * in assignments
--		unless otherwise directed.


SELECT * from SalesLT.Customer;



--3.	Write a SQL statement that pulls all data from the AdventureWorksLT Products table. 


SELECT * from SalesLT.Product;


--4.	Write a SQL statement that pulls all of the records from the Products table, but show only 
--		the ProductID, Name, ProductNumber, and ListPrice and sort ListPrice in descending order.

SELECT ProductID, Name, ProductNumber, ListPrice FROM SalesLT.Product
ORDER BY ListPrice desc;



--5.	Write a SQL statement that pulls all of the records from the AdventureWorksLT Products table, 
--		but show only the ProductID, Name, ProductNumber, and ListPrice, 
--		and sort by Name in ascending order.

SELECT ProductID, Name, ProductNumber, ListPrice FROM SalesLT.Product
ORDER BY Name asc;


--6.  	List the colors of AdventureWorks products.  List each color only once and in alphabetical order. 
--		We will learn to deal with NULL in the next module, so NULL will show in the list of colors.


SELECT distinct color from SalesLT.Product
order by Color asc;



--7.	AdventureWorksLT customers are from which countries?
--		List the unique countries, i.e. list each country only one time.


select distinct CountryRegion from SalesLT.Address
order by CountryRegion asc;


--8.	AdventureWorksLT customers are from which city-states?
--		List the unique city-state combinations. For example
--
--			Bothell  |  Washington
--
--		should display only one time.

select distinct City, StateProvince from SalesLT.Address



















 