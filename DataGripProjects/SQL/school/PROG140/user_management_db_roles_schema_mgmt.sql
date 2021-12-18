--*  PROG 140           Assignment 10			             DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Identify the two ways that SQL Server can authenticate a login ID. 
•	Identify the two SQL Server authentication modes.
•	Describe these terms: principals and securables.
•	Describe the difference between an object permission and a database permission.
•	Describe the guidelines for a strong password.
•	Describe what a user can do when given any of the standard permissions for a SQL Server object: 
		Select, Update, Insert, Delete, Execute, References, and ALTER.
•	Describe the difference between a denied permission and a revoked permission.
•	Describe the two types of fixed roles provided by SQL Server: fixed server roles and fixed database roles.
•	Describe the use of application roles



Skills:

•	Given the specifications for a new user’s security permissions, write the Transact-SQL statements 
	that create the new user and grant the security permissions.
•	Given the specifications for a new user’s security permissions, use the Management Studio 
	to create the new user and grant the security permissions.
•	Given the specifications for a set of security permissions for a database, write the Transact-SQL statements 
	to create a new database role and assign users or groups to it.
•	Given the specifications for a set of security permissions for a server, write the Transact-SQL statements 
	to create a new server role and assign logins to it.
•	Given the specifications for a set of security permissions, use the Management Studio 
	to create a new role and assign users or groups to it.
•	Use SQL statements or the Management Studio to add users to the fixed server roles or the fixed database roles.



TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Assignment10.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Assignment10.sql.

		Xxxxx-PROG140-Assignment10.sql

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

--- CHAPTER 17 - MANAGE DATABASE SECURITY
*/
/*
1.	Write a script that creates a user-defined database role named OrderEntry in the MyGuitarShop database. 
	Give INSERT and UPDATE permission to the new role for the Orders and OrderItems table. 
	Give SELECT permission for all user tables.
	Hints:	1. Create the role
			2. Grant permissions on object to roles
			3. Add the role to the db_datareader role. This allows its members to read all the tables in the database.

*/
USE MyGuitarShop;

create role OrderEntry

grant insert, update
	on Orders
	to OrderEntry

grant insert, update
	on OrderItems
	to OrderEntry

alter role db_datareader add member OrderEntry;



/*
2.	Write a script that 
	(1) creates a login ID named “RobertHalliday” with the password “HelloBob”; 
	(2) sets the default database for the login to the MyGuitarShop database; 
	(3) creates a user named “RobertHalliday” for the login; and 
	(4) assigns the user to the OrderEntry role you created in exercise 1.
*/
USE MyGuitarShop;

create login RobertHalliday with password = 'HelloBob!',
	default_database = MyGuitarShop;

create user RobertHalliday for login RobertHalliday

alter role OrderEntry add member RobertHalliday


/*
3.	Using the Management Studio, create a login ID named “RBrautigan” with the password “RBra9999,” 
	and set the default database to the MyGuitarShop database. 
	
	Then, grant the login ID access to the MyGuitarShop database, 
	create a user for the login ID named “RBrautigan”, and assign the user to the OrderEntry role you created in exercise 1.
	Note: If you get an error that says “The MUST_CHANGE option is not supported”, 
	you can deselect the “Enforce password policy” option for the login ID.

	Submit 2 screenshots via the Assignment 10 page: 
		1) The new login creation page, and 
		2) The login properties user mapping page.


		That was frustrating, I couldn't make a user with a password. I tried everything I know and 
		it didn't do anything. So this person was made without a password and I tried to create the
		user to screenshot it and now it won't let me drop the one I made in test. I'll add that instead. :/
*/


/*
4.	Write a script that removes the user-defined database role named OrderEntry. 
	Hint: This script should begin by removing all users from this role. 
	You will first need to find out which users have that role. 
	Question 4 of the Chapter 17 Exercise Answers provides guidance about how to do that. 
*/
USE MyGuitarShop;

alter role OrderEntry drop MEMBER RobertHalliday
alter role OrderEntry drop MEMBER RBrautigan
drop role OrderEntry;


/*
5.	Write a script that 
	(1) creates a schema named Admin, 
	(2) transfers the table named Addresses from the dbo schema to the Admin schema, 
	(3) assigns the Admin schema as the default schema for the user named RobertHalliday that you created in exercise 2, and 
	(4) grants all standard privileges except for REFERENCES and ALTER to RobertHalliday for the Admin schema.

	Hint: See textbook pages 544-545.

*/
USE MyGuitarShop;
go

create schema Admin;
go

alter schema Admin transfer dbo.Addresses;

alter user RobertHalliday with default_schema = Admin;

grant select, update, insert, delete, execute
on schema :: Admin
to RobertHalliday

