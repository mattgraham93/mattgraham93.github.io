--*  PROG 140           Assignment   #6		              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the use of scripts.
•	Describe the difference between a scalar variable and a table variable.
•	Describe the scope of a local variable.
•	Describe the use of cursors.
•	Describe the scopes of temporary tables, table variables, and derived tables.
•	Describe the use of dynamic SQL.
•	Given a Transact-SQL script, explain what each statement in the script does.


Skills:

•	Given a Transact-SQL script written as a single batch, insert GO commands to divide the script into appropriate batches.
•	Given the specification for a database problem, write a script that solves it.
•	Use the SQLCMD utility to execute a query or a script.



TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Assignment-06, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Assignment-06.sql.

		Xxxxx-PROG140-Assignment-06.sql

    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this Exercise page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the Exercise, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?

	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 


    For this Assignment, we will use the MyGuitarShop database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

--- CHAPTER 14 - HOW TO CODE SCRIPTS -- 


--1.	Write a script that declares a variable and sets it to the count of all products in the Products table. 
--		If the count is less than or equal to 8, the script should display a message that says, 
--		“The number of products is less than or equal to 8”. 
--		Otherwise, it should say, “The number of products is greater than 8”.

USE MyGuitarShop;

declare @products int

select @products = count(ProductID)
from products

if @products > 8
	print 'The number of products is less than or equal to 8'
	else
	print 'The number of products is greater than 8'
go


--2.	Write a script that uses two variables to store (1) the count of all of the products in the Products table and 
--		(2) the average list price for those products. If the product count is greater than or equal to 8, 
--		the script should print a message that displays the values of both variables. 
--		Otherwise, the script should print a message that says, “The number of products is less than 8”.


USE MyGuitarShop;

declare @product_count int
declare @avg_list_price decimal(18,2)

select @product_count = count(ProductID), @avg_list_price = AVG(ListPrice)
from products

if @product_count < 8
	print 'The number of products is less than 8'
	else
	print concat('The number of products is greater than or equal to 8. 
Total count: ',@product_count ,' 
Average list price: $', @avg_list_price)
go



--3.	Write a script that attempts to insert a new category named “Guitars” into the Categories table. 
--		If the insert is successful, the script should display this message: SUCCESS: Record was inserted.
--		If the update is unsuccessful, the script should display a message something like this:
--		FAILURE: Record was not inserted.
--		Error 2627: Violation of UNIQUE KEY constraint 'UQ__Categori__8517B2E0A87CE853'. 
--		Cannot insert duplicate key in object 'dbo.Categories'. The duplicate key value is (Guitars).

USE MyGuitarShop;

begin try
	insert into Categories(CategoryName)
	values ('Guitars')
	print 'SUCCESS'
end try
begin catch
	print 'FAILURE: Record was not recorded 
Error 2627: Violation of UNIQUE KEY constraint UQ__Categori__8517B2E0A87CE853.
Cannot insert duplicate key in object dbo.Categories. The duplicate key value is (Guitars).'
end catch
go




--4.	Write a script that attempts to insert a new category named “Violins” into the Categories table. 
--		If the insert is successful, the script should display this message: SUCCESS: Record was inserted.
--		If the update is unsuccessful, the script should display a message something like this:
--		FAILURE: Record was not inserted.
--		Error 2627: Violation of UNIQUE KEY constraint 'UQ__Categori__8517B2E0A87CE853'. 
--		Cannot insert duplicate key in object 'dbo.Categories'. The duplicate key value is (Violins).

USE MyGuitarShop;

begin try
	insert into Categories(CategoryName)
	values ('Violins')
	print 'SUCCESS: Record was inserted.'
end try
begin catch
	print 'FAILURE: Record was not recorded 
Error 2627: Violation of UNIQUE KEY constraint UQ__Categori__8517B2E0A87CE853.
Cannot insert duplicate key in object dbo.Categories. The duplicate key value is (Violins).'
end catch
go








