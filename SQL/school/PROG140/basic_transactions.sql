--*  PROG 140           Assignment   #4		              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge
•	Describe the three types of action queries.
•	Explain how to handle null values and default values when coding INSERT and UPDATE statements.
•	Explain how the FROM clause is used in an UPDATE or DELETE statement.
•	Explain how the MERGE statement works.
•	Describe the use of views.
•	Name the three SQL statements you use to work with views.
•	Given a SELECT statement, determine whether it can be used as the basis for a view.
•	Given a SELECT statement, determine whether it can be used as the basis for an updatable view.
•	Describe the benefits provided by views.
•	Describe the effects of the WITH SCHEMABINDING and WITH ENCRYPTION clauses on a view.
•	Describe the effect of the WITH CHECK OPTION clause on an updatable view.
•	Describe the use of SQL Server’s catalog views for getting information from the system catalog.

Skills
•	Given the specifications for an action query, code the INSERT, UPDATE, or DELETE statement for doing the action.
•	Use the MERGE statement to merge rows from a source table into a target table.
•	Create a copy of a table by using the INTO clause of the SELECT statement.
•	Given a SELECT statement, create a new view based on the statement.
•	Given a SELECT statement, use the View Designer to create a new view based on the statement.
•	Use the View Designer to change the design of an existing view.


TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Assignment-04, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Assignment-04.sql.

		Xxxxx-PROG140-Assignment-04.sql

    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this Assignment page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the Exercise, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?

*/

/*	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 


    For this Assignment, we will use the MyGuitarShop database. 

!!!!! Execute CreateMyGuitarShop.sql before completing this assignment. This ensures that you have a "clean" database before starting.

!!!!! Look at the data before and after your SQL statement so that you understand what each statement is doing.

*/
--- CHAPTER 7 - How to insert, update, and delete data ---

USE MyGuitarShop;

--1.	Write an INSERT statement that adds this row to the Categories table:
--		CategoryName:	Woodwinds
--		Code the INSERT statement so SQL Server automatically generates the value for the CategoryID column.

insert into Categories
values ('Woodwinds');

-- select * from Categories


--2.	Write an UPDATE statement that modifies the row you just added to the Categories table. 
--		This statement should change the CategoryName column to “Brass”, and it should use the CategoryID column to identify the row.

update Categories
set CategoryName = 'Brass'
where CategoryID = 5;


--3.	Write a DELETE statement that deletes the row you added to the Categories table in question 1. 
--		This statement should use the CategoryID column to identify the row.

delete from Categories
where CategoryID = 5;


--4.	Write an INSERT statement that adds this row to the Products table:
--			ProductID:	The next automatically generated ID 
--			CategoryID:	4
--			ProductCode:	RJ_010X
--			ProductName:	RockJam 61
--			Description:	Piano with LCD Display Kit
--			ListPrice:	129.99
--			DiscountPercent:	0
--			DateAdded:	Today’s date/time.
--		Use a column list for this statement.

insert into Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
values (4, 'RJ_010X', 'RockJam 61', 'Piano with LCD Display Kit', 129.99, 0, GETDATE());

-- select * from products


--5.	Write an UPDATE statement that modifies the product you added in exercise 4. This statement should change 
--			the DiscountPercent column from 0% to 15%.

update Products
set DiscountPercent = 15
where ProductID = 11;


--6.	Write a DELETE statement that deletes the row in the Categories table that has an ID of 1. 
--		When you execute this statement, it will produce an error since the category has related rows in the Products table. 
--		To fix that, precede the DELETE statement with another DELETE statement that deletes all products in this category.


-- I couldn't get this to work with a delete statement? below this is how I would do it to remove the FK constraint
delete Products
where CategoryID = 1
delete Categories
where CategoryID = 1;

-- how I would solve this problem
alter table products
drop constraint FK__OrderItem__Produ__3B75D760
delete Products
where CategoryID = 1
delete Categories
where CategoryID = 1;

--7.	Write an INSERT statement that adds this row to the Customers table:
--			EmailAddress:	ash_ketchum@pikachu.com
--			Password:	(empty string)
--			FirstName:	Ash
--			LastName:	Ketchum
--		Use a column list for this statement.

insert into Customers (EmailAddress, Password, FirstName, LastName)
values ('ash_ketchum@pikachu.com', '', 'Ash', 'Ketchum');


--8.	Write an UPDATE statement that modifies the Customers table. Change the password column to “secret” for the customer 
--			with an email address of ash_ketchum@pikachu.com.

update Customers
set Password = 'secret'
where EmailAddress = 'ash_ketchum@pikachu.com';


--9.	Write an UPDATE statement that modifies the Customers table. Change the password column to “reset” for every customer in the table. 

update Customers
set Password = 'reset';


--10.	Change the database connection to a different database from MyGuitarShop (use the USE command).
--		Open the script named CreateMyGuitarShop.sql that’s in the Week 04 Resources page.
--		Then, run the script. That should restore the data that’s in the database.

--		use MyGuitarShop2;

--- CHAPTER 13 - How to work with views ---

USE MyGuitarShop;


--11.	Create a view named CustomerAddresses that shows the shipping and billing addresses for each customer in the MyGuitarShop database.
--		This view should return these columns from the Customers table: CustomerID, EmailAddress, LastName and FirstName.
--		This view should return these columns from the Addresses table: BillLine1, BillLine2, BillCity, BillState, BillZip, 
--			ShipLine1, ShipLine2, ShipCity, ShipState, and ShipZip.
--		Use the BillingAddressID and ShippingAddressID columns in the Customers table to determine which addresses are billing addresses 
--			and which are shipping addresses. 
--		Hints: You can use two JOIN clauses to join the Addresses table to Customers table twice (once for each type of address).
--				Put the command GO before the CREATE VIEW command.

create view CustomerAddresses
as
select c.CustomerID, EmailAddress, LastName, FirstName, a.Line1 BillLine1, a.Line2 BillLine2, a.City BillCity, a.State BillState, a.ZipCode BillZip
from Customers c
	join Addresses a
		on c.CustomerID = a.CustomerID

-- select * from CustomerAddresses

--12.	Write a SELECT statement that returns these columns from the CustomerAddresses view that you created in question 11: 
--			CustomerID, LastName, FirstName, BillLine1.

select CustomerID, LastName, FirstName, BillLine1
from CustomerAddresses;


--13.	Write an UPDATE statement that updates the CustomerAddresses view you created in question 11 so it sets 
--			the first line of the shipping address to “3000 Landerholm Circle SE” for the customer with an ID of 3.

update CustomerAddresses
set BillLine1 = '3000 Landerholm Circle SE'
where CustomerID = 3;


--14.	Create a view named OrderItemProducts that returns columns from the Orders, OrderItems, and Products tables.
--		This view should return these columns from the Orders table: OrderID, OrderDate, TaxAmount, and ShipDate.
--		This view should return these columns from the OrderItems table: ItemPrice, DiscountAmount, 
--			FinalPrice (the discount amount subtracted from the item price), Quantity, and ItemTotal (the calculated total for the item).
--		This view should return the ProductName column from the Products table.

create view OrderItemProducts
as
select o.OrderID, o.OrderDate, o.TaxAmount, o.ShipDate, oi.ItemPrice, oi.DiscountAmount, oi.ItemPrice - oi.DiscountAmount FinalPrice, oi.Quantity, (oi.ItemPrice - oi.DiscountAmount) * oi.Quantity ItemTotal, p.ProductName
from Orders	o
	join OrderItems oi
		on o.OrderID = oi.OrderID
	join Products p
		on oi.ProductID = p.ProductID;


--15.	Create a view named ProductSummary that uses the view you created in question 14. 
--		This view should return some summary information about each product (remember GROUP BY?).
--		Each row should include these columns: ProductName, OrderCount (the number of times the product has been ordered), 
--			and OrderTotal (the total sales for the product).

create view ProductSummary
as
select ProductName, COUNT(ProductName) OrderCount, SUM(ItemTotal) OrderTotal
from OrderItemProducts
group by ProductName;


--16.	Write a SELECT statement that uses the view that you created in question 15 to get total sales for the five best selling products.

select top 5 ProductName, OrderCount, OrderTotal
from ProductSummary

