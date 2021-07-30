--*  BUSIT 103           Assignment   #2              DUE DATE:  Consult course calendar
							
/*****	You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 
	To find the tables that contain the fields that are requested, consider creating a Database Diagram
	that includes only the tables from the SalesLT schema and referring to it. *****/



/***** Do not remove the USE statement. *****/

USE AdventureWorksLT2012;


--1a.	Write a SQL statement that pulls all of the records from the AdventureWorksLT SalesOrderHeader table.

select * from SalesLT.SalesOrderHeader


--1b.	Write a SQL statement that pulls all of the records from the AdventureWorksLT SalesOrderDetail table.

select * from SalesLT.SalesOrderDetail
--		select distinct productID from SalesLT.SalesOrderDetail


--1c.	Study the tables in the AdventureWorksLT database and pretend you will type in data for the scenario
--		below (i.e. you will *NOT* use INSERT - pretend you will hand type in the data).
--		Explain how you would add records to the AdventureWorksLT database for the following scenario:
--
--			An existing customer places an order for 3 distinct existing products, 
--			(i.e. not a quantity of 3 of one single product).
--
--		Use the following format for your explanation:

--			STEP 1: Open Table X and input N records.
--			STEP 2: Open Table Y and input N records.
--			etc.

--		Make sure to comment out your explanation.


--		STEP 1: Open Product table and get 3 product IDs
--		STEP 2: Open SalesOrderDetail and add 3 product IDs with quantities
--		STEP 3: Open SalesOrderHeader and add SalesOrderID
--		I'm unsure of the rest of what we are looking for here.



--2.	You may wonder ...
--		Do AdventureWorksLT customers just order the same few products, or are they ordering 
--		a wide variety of products? It could be that AdventureWorksLT has hundreds of orders, 
--		but all for only 2 different products. Or it could be that AdventureWorksLT has 
--		hundreds of orders for many different products. 
--
--		Do AdventureWorksLT customers order a variety of products? Explain. 
--		Make sure to comment out your explanation.

--		AdventureWorksLT customers order a variety of products, over 140 were pulled when looking at distinct ProductIDs.


--		Write a query statement that supports your explanation.



select distinct productid from SalesLT.SalesOrderDetail



--3.	List all AdventureWorks products model IDs.  List each model ID only once 
--		and sort in order from lowest to highest. Note: You will display only the model id field.

select distinct ProductModelID from SalesLT.ProductModel
order by ProductModelID















 