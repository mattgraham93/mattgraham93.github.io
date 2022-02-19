--*  DA310    Assignment   #4              DUE DATE:  Consult course calendar
							
/*
Assignment 4 - (these are the same instructions as in Canvas)

PURPOSE:

Knowledge:

    o Understand how data is stored in relational database tables
    o Understand the mechanics of completing assignments for this class

Skills:

    o Outside of class, access a computer that has SQL Server loaded on it
    o Interpret questions to understand how to answer the questions
    o Write SQL queries to answer questions by retrieving data from database tables

TASK:

    1. Download the following SQL file and rename it Xxxxx-DA310-Assignment-04, where Xxxxx is your last and first name. 
	For example, I would rename this file CharleneCheng-DA310-Assignment-04.sql.

		Xxxxx-DA310-Assignment-04.sql

    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this assignment page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the assignment, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?

*/

/*	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 


    For this assignment, we will use the AdventureWorksLT2012 database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

USE AdventureWorksLT2012;


--1.	Write a SQL statement that pulls all of the records from the AdventureWorksLT Product table. 
--      I have answered the first question to show you the format I expect. 

SELECT *
FROM SalesLT.Product;


--2.	Write a SQL statement that pulls all of the records from the AdventureWorksLT Product table, 
--		but show only the ProductID, Name, ProductNumber, and ListPrice.

select ProductID, Name, ProductNumber, ListPrice
from SalesLT.Product;


--3.	Write a SQL statement that pulls all of the records from the AdventureWorksLT Product table, 
--		but show only the ProductID, Name, and ListPrice, 
--		and sort by Name in ascending order.

select ProductID, Name, ListPrice
from SalesLT.Product
order by 2 asc;


--4.	Write a SQL statement that pulls all of the records from the AdventureWorksLT Product table, 
--		but show only the ProductID, Name, ProductNumber, and ListPrice, 
--		and sort by ListPrice in descending order. 

select ProductID, Name, ListPrice
from SalesLT.Product
order by 3 desc;


--5.	Write a SQL statement that pulls all of the records from the AdventureWorksLT ProductCategory table.

select *
from SalesLT.ProductCategory;


--6a.	Write a SQL statement that pulls all of the records from the AdventureWorksLT SalesOrderHeader table.

select *
from SalesLT.SalesOrderHeader;


--6b.	Write a SQL statement that pulls all of the records from the AdventureWorksLT SalesOrderDetail table.

select *
from SalesLT.SalesOrderDetail;


--7a. Write a SQL statement that create a database and then drop the database.

create database test;
drop database test;


--7b. Write a SQL statement that create a table Employee, columns should be EmployeeID which is in integer type, Last Name and First Name in varchar type, age in integer type. Make sure EmployeeID is the key and every employee is older than 21 year-old.

create table Employee (
	EmployeeID int not null,
	LastName varchar(100),
	FirstName varchar(100),
	Age int check (Age >= 21)
)


--7c. Write a SQL statement that insert the following values into 7b.table, explain which row cannot be inserted into the table and why.

insert into Employee values (001, 'Jason', 'Unwin', 20) 
insert into Employee values (001, 'Jason', 'Unwin', 22) 
insert into Employee values (001, 'Jason', 'Unwin', 23)
insert into Employee values (002, 'Jason', 'Unwin', 20)
insert into Employee values (002, 'Jason', 'Unwin', 26) 

select * from Employee;

drop table Employee;
 

--8. Explain the differences between DELETE, DROP and TRUNCATE

/**
	Delete means the rows are removed from the table, usually with a where clause
	Drop is used when removing database/server objects (tables, users, security roles, etc)
	Truncate is another table expression, it removes all rows from the selected table
**/


--9. Write a SQL statement that define a procedure which contains 7b and 7c, and run it. 

drop procedure if exists CreateEmployees;

create procedure CreateEmployees
as 
	drop table if exists Employee;

	create table Employee (
		EmployeeID int not null,
		LastName varchar(100),
		FirstName varchar(100),
		Age int check (Age >= 21) -- the stored procedure does not handle the check well. Need to understand more of why
	)

	insert into Employee (
		EmployeeID,
		LastName,
		FirstName,
		Age
	) values
		(1, 'Graham', 'Matt', 28),
		(2, 'Wootten', 'Audrey', 25),
		(3, 'Jain', 'Lilliana', 42),
		(4, 'Jenkins', 'Todd', 35)
;

exec CreateEmployees;

select * from Employee

--10. Why should we migrate from Excel to sql? (150 words)

/*
	The best part about migrating to SQL is that you get the ability to have a centralized location for tabular data.
	Excel is such a heavy tool and is very limited in storage capabilities. Only being able to store a little more than 1M rows,
	it doesn't serve as a sustainable or efficient data storage solution. I also argue that Excel has become outdated in the scheme
	of cloud computing and app development.

	Something else SQL provides over Excel is the abiity to provide deep security control. Data security proves to be one of the most
	important problems as we age through in the 21st century. Having the ability to control what your users do and do no have access
	to provides teams and organizations to leverage many unified data points while protecting sensitive data when needed.

	My team is continuing to balance the enterprise reliance of excel while leveraging cloud technologies. We use SharePoint, 
	Azure Blob Storage, Logic Apps, Data Factory, and SQL to move, manipulate, and store our data. Our database currently serves
	about 500 daily active users, which is pretty cool!
*/


