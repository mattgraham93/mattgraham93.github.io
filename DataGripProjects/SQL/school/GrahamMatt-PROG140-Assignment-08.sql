--*  PROG 140           Assignment # 8	(functions and triggers)	       DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the two types of user-defined functions.
•	Describe the two types of triggers.
•	Describe the effects of the WITH ENCRYPTION and WITH SCHEMABINDING clauses on a stored procedure, 
	user-defined function, or trigger.
•	Explain why you’d want to use the ALTER statement rather than dropping and recreating a procedure, 
	function, or trigger.
•	Given a stored procedure, user-defined function, or trigger, explain what each statement does.


Skills:

•	Given an expression, write a scalar-valued user-defined function based on the formula or expression.
•	Given a SELECT statement with a WHERE clause, write a table-valued user-defined function that replaces it.
•	Given the specifications for a database problem that could be caused by an action query, write a trigger that prevents the problem.
•	Given the specifications for a database problem that could be caused by a DDL statement, write a trigger that prevents the problem.


TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Assignment-08, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Assignment-08.sql.

		Xxxxx-PROG140-Assignment-08.sql

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


--- CHAPTER 15 - FUNCTIONS AND TRIGGERS ---
*/

USE MyGuitarShop;

/*

1.	Write a script that creates and calls a function named fnDiscountPrice that calculates 
the discount price of an item in the OrderItems table (discount amount subtracted from item price). 
To do that, this function should accept one parameter for the item ID, 
and it should return the value of the discount price for that item.
*/

create function fnDiscountPrice (@ItemID int)
returns money as
begin
	declare @DiscountAmount money
	declare @ItemPrice money
	declare @DiscountPrice money

	select @DiscountAmount = DiscountAmount, @ItemPrice = ItemPrice
	from OrderItems
		where ItemID = @ItemID

	return @ItemPrice - @DiscountAmount
end

select * from OrderItems

select dbo.fnDiscountPrice(5) DiscountPrice

/*
2.	Write a script that creates and calls a function named fnItemTotal that calculates 
the total amount of an item in the OrderItems table (discount price multiplied by quantity). 
To do that, this function should accept one parameter for the item ID, 
it should use the DiscountPrice function that you created in question 1, 
and it should return the value of the total for that item.
*/

create function fnItemTotal (@ItemID int)
returns money as
begin
	declare @Quantity int
	declare @DiscountPrice money

	select @Quantity = sum(Quantity), @DiscountPrice = dbo.fnDiscountPrice(@ItemID)
	from OrderItems
		where ItemID = @ItemID

	return @Quantity * @DiscountPrice
end


select dbo.fnItemTotal(5) TotalAmount


/*
3. Write a Scalar UDF, called fnYearMonth that will take any date as an input parameter and return
that same date in the following format:  YYYY-MMM  example:  2018-Nov  
(4 digits for the year, a hyphen, and 3 characters for the Month)
Note:  the Return will be in varchar format, NOT date format

Include at least 3 statements to test this new UDF with different dates
*/

create function fnYearMonth (@InputtedDate datetime)
returns varchar(10) as
begin
	declare @DateFormat varchar(25)

	select @DateFormat = FORMAT(@InputtedDate, 'MMM dd yyyy')

	return concat(right(@DateFormat, 4), '-', left(@DateFormat, 3))
end

select dbo.fnYearMonth(getdate()) DateAbbrv


/* 
4.	Create a trigger named Products_UPDATE that checks the new value for the DiscountPercent column 
of the Products table. This trigger should raise an appropriate error if the discount percent 
is greater than 100 or less than 0.

If the new discount percent is between 0 and 1, this trigger should modify the new discount percent 
by multiplying it by 100. That way, a discount percent of .2 becomes 20.

Test this trigger with an appropriate UPDATE statement.
*/

drop trigger if exists Products_UPDATE

create trigger Products_UPDATE
	on Products
	after update
as
	declare @DiscountPercent money

	select @DiscountPercent = DiscountPercent from inserted

	if @DiscountPercent < 0 or @DiscountPercent > 100
		throw 50001, 'The Discount Percent must be larger than 0 and less than 100', 1;
	if @DiscountPercent > 0 and @DiscountPercent < 1
		update Products
		set DiscountPercent = @DiscountPercent * 100
		where ProductID = (select ProductID from inserted);
	else
		update Products
		set DiscountPercent = @DiscountPercent
		where ProductID = (select ProductID from inserted);
go

select * from Products
where ProductID = 5

update Products
set DiscountPercent = 189.00
where ProductID = 5

update Products
set DiscountPercent = 89.00
where ProductID = 5

update Products
set DiscountPercent = 0.2
where ProductID = 5

/*
5.	Create a trigger named Products_INSERT that inserts the current date for the DateAdded column 
of the Products table if the value for that column is null.

Test this trigger with an appropriate INSERT statement.
*/

drop trigger if exists Products_INSERT

create trigger Products_INSERT
	on Products
	after insert
as
	set nocount on
	update Products
	set DateAdded = GETDATE()
	where ProductID in (select ProductID from inserted where DateAdded is null)

select * from Products

insert Products(CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
values(
	1,'Test1','Test1','Test1',99.00,10,'2018-01-01'	

)

select * from Products

insert Products(CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
values(
	2,'Test2','Test2','Test2',99.00,10,null
)

select * from Products

/*
6.	Create a table named ProductsAudit. This table should have all columns of the Products table, 
except the Description column. Also, it should have an AuditID column for its primary key, 
and the DateAdded column should be changed to DateUpdated.

Create a trigger named Products_UPDATE. 

This trigger should insert the old data about the product into the ProductsAudit table after the row is updated. 

Then, test this trigger with an appropriate UPDATE statement.
*/

CREATE TABLE ProductsAudit(
	[AuditID] [int] IDENTITY(1,1) primary key NOT NULL,
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[ProductName] [varchar](255) NOT NULL,
	[Description] [text] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[DiscountPercent] [money] NOT NULL,
	DateUpdated [datetime] NULL,
)

drop trigger if exists Products_UPDATE

-- removed Description as it is a "text" column and this error raised when I created my trigger
-- Cannot use text, ntext, or image columns in the 'inserted' and 'deleted' tables.

create trigger Products_UPDATE
	on Products
	after update
as
	insert into ProductsAudit 
		(ProductID, CategoryID, ProductCode, ProductName, ListPrice, DiscountPercent, DateUpdated)
	select ProductID, CategoryID, ProductCode, ProductName, ListPrice, DiscountPercent, GETDATE()
	from deleted	
go


-- This fails to update, due to what is noted above. I need to do some table re-configuration to make this happen (e.g. change text to varchar)
select * from Products

update Products
set DiscountPercent = 25
where ProductID = 19