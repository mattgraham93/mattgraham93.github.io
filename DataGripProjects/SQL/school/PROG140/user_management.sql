--*  PROG 140           Chapter 17 Exercise				             DUE DATE:  Consult course calendar
							
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

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap17.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap17.sql.

		Xxxxx-PROG140-Exercise-Chap17.sql

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


    For this Exercise, we will use the Murach College database. We tell SQL Server which database 
    to use via the USE statement.

--- CHAPTER 17 - MANAGE DATABASE SECURITY
1.	Write a script that 
	(1) creates a login ID named “JimRhodes” with the password “HelloJimR!”; 
	(2) sets the default database for the login to the MurachCollege database; and 
	(3) creates a user named “JimRhodes” for the login.
*/

use MurachCollege

create login JimRhodes with password = 'HelloJimR!',
	default_database = MurachCollege;

create user JimRhodes for login JimRhodes


/*
2.	Write a script that creates a user-defined database role named StudentEnrollment in the MurachCollege database. 
	Give INSERT, UPDATE, and DELETE permission to the new role for the Students, StudentCourses, and Courses tables. 
	Give SELECT permission for all user tables. 
	Then, assign the user you created in question 1 to this role.
*/

use MurachCollege

create role StudentEnrollment

grant insert, update, delete
	on Students
	to StudentEnrollment

grant insert, update, delete
	on StudentCourses
	to StudentEnrollment

grant insert, update, delete
	on Courses
	to StudentEnrollment

alter role db_datareader add member StudentEnrollment;

alter role StudentEnrollment add member JimRhodes;


/*
3.	Using the Management Studio, create a login ID named “AnneBoehm” with the password “ABoe99999”, and set the default database to the MurachCollege database. 
	Then, grant the login ID access to the MurachCollege database, create a user for the login ID named “AnneBoehm”, and assign the user to the StudentEnrollment role you created in question 1.
	Note: If you get an error that says “The MUST_CHANGE option is not supported”, you can deselect the “Enforce password policy” option for the login ID.
*/
-- Nothing required to submit here



/*
4.	Write a script that removes the user-defined database role named StudentEnrollment. 
	(Hint: This script should begin by removing all users from this role.)
*/

use MurachCollege

ALTER ROLE StudentEnrollment DROP MEMBER JimRhodes
ALTER ROLE StudentEnrollment DROP MEMBER AnneBoehm
DROP ROLE StudentEnrollment;



/*
5.	Write a script that 
	(1) creates a schema named Admin, 
	(2) transfers the table named Tuition from the dbo schema to the Admin schema, 
	(3) assigns the Admin schema as the default schema for the user named JimRhodes that you created in question 2, and 
	(4) grants all standard privileges except for REFERENCES and ALTER to JimRhodes for the Admin schema.
*/


use MurachCollege
go;

create schema Admin;
go

alter schema Admin transfer dbo.Tuition;

alter user JimRhodes with default_schema = Admin;

grant select, update, insert, delete, execute
on schema :: Admin
to JimRhodes