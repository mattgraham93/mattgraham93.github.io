--*  PROG 140           Chapter 15 Exercise	(Stored Procedures)	              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Explain why a stored procedure executes faster than an equivalent SQL script.
•	Describe the basic process for validating data within a stored procedure.
•	Describe the basic purpose of the system stored procedures.
•	Describe the effects of the WITH ENCRYPTION and WITH SCHEMABINDING clauses on a stored procedure, 
	user-defined function, or trigger.
•	Explain why you’d want to use the ALTER statement rather than dropping and recreating a procedure, 
	function, or trigger.
•	Given a stored procedure, user-defined function, or trigger, explain what each statement does.


Skills:

•	Given the specifications for a database problem, write a stored procedure that solves it. Include data validation when necessary.


TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap15_sp.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap15_sp.sql.

		Xxxxx-PROG140-Exercise-Chap15_sp.sql

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

--- CHAPTER 15 - HOW TO CODE STORED PROCEDURES

1.	Write a script that creates and calls a stored procedure named spInsertDepartment. 
	First, code a statement that creates a procedure that adds a new row to the Departments table. 
	To do that, this procedure should have one parameter for the department name.
	Code at least two EXEC statements that test this procedure. (Note that this table doesn’t allow duplicate department names.)
*/
USE MurachCollege;
go

create procedure spInsertDepartment @DepartmentName varchar(50)
as
begin try
    insert into Departments(DepartmentName)
		select @DepartmentName
    print 'SUCCESS: ' + @DepartmentName + ' was successfully inserted.'
end try
begin catch
    print 'FAILURE: Record was not inserted.';
    print 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1) + ': '+ ERROR_MESSAGE()
end catch
go

select * from Departments

-- Test fail
exec spInsertDepartment @DepartmentName = 'English'
go

-- Test success
exec spInsertDepartment @DepartmentName = 'Test'
go

/*
2.	Write a script that creates and calls a stored procedure named spInsertInstructor that inserts a row into the Instructors table. 
	This stored procedure should accept one parameter for each of these columns: LastName, FirstName, Status, DepartmentChairman, AnnualSalary, and DepartmentID.
	This stored procedure should set the DateAdded column to the current date.
	If the value for the AnnualSalary column is a negative number, the stored procedure should raise an error that indicates that this column doesn’t accept negative numbers. 
	Code at least two EXEC statements that test this procedure.
*/

--drop procedure spInsertInstructor

create procedure spInsertInstructor @LastName varchar(25), @FirstName varchar(25), @Status char(1), @AnnualSalary money, @DepartmentID int, @DepartmentChairman bit
as
begin try
    if @AnnualSalary < 0
		print 'No records updated. Salaries must be greater than or equal to 0.'
	else
		insert into Instructors(LastName, FirstName, Status, AnnualSalary, DepartmentID, DepartmentChairman)
		select @LastName, @FirstName, @Status, @AnnualSalary, @DepartmentID, @DepartmentChairman
    --print 'SUCCESS: ' + @FirstName + ' was successfully inserted.'
end try
begin catch
    print 'FAILURE: Record was not inserted.';
    throw;
end catch
GO

select * from Instructors

-- Test fail
exec spInsertInstructor @LastName = 'Eilish', @FirstName = 'Billie', @Status = 'F', @AnnualSalary = -55000, @DepartmentID = 12, @DepartmentChairman = 1
go

-- Test success
exec spInsertInstructor @LastName = 'Eilish', @FirstName = 'Billie', @Status = 'F', @AnnualSalary = 55000, @DepartmentID = 8, @DepartmentChairman = 1
go


/*
3.	Write a script that creates and calls a stored procedure named spUpdateInstructor that updates the AnnualSalary column in the Instructors table. 
	This procedure should have one parameter for the instructor ID and another for the annual salary.
	If the value for the AnnualSalary column is a negative number, the stored procedure should raise an error that indicates that the value for this column must be a positive number.
	Code at least two EXEC statements that test this procedure.
*/


create procedure spUpdateInstructor @InstructorID int,@AnnualSalary money
as
begin try
	if @AnnualSalary < 0
		print 'No records updated. Discount Percents must be greater than or equal to 0.'
	else
		update Instructors
		set AnnualSalary = @AnnualSalary
		where InstructorID = @InstructorID
		--print 'Success'
	end try
	begin catch
		print 'FAILURE: Record was not inserted.';
		throw;
	end catch
go

-- Test fail: 

exec spUpdateInstructor @InstructorID = 9, @AnnualSalary = -75.21
go

-- Test success: 


exec spUpdateInstructor @InstructorID = 9, @AnnualSalary = 75.21
go
