--*  PROG 140           Chapter 15 Exercise	(functions and triggers)	              DUE DATE:  Consult course calendar
							
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

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap15_trig.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap15_trig.sql.

		Xxxxx-PROG140-Exercise-Chap15_trig.sql

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

--- CHAPTER 15 - HOW TO CODE FUNCTIONS AND TRIGGERS ---
1.	Write a script that creates and calls a function named fnStudentUnits that calculates the total course units of a student in the StudentCourses table. 
	To do that, this function should accept one parameter for the student ID, and it should return the sum of the course units for the student.
	The SELECT statement that calls the function should return the StudentID from the StudentCourses table, the CourseNumber and CourseUnits from the Courses table, and the value return by the fnStudentUnits function for that student.
*/
USE MurachCollege;
go

drop function if exists fnStudentUnits
go

create function fnStudentUnits (@StudentID int)
returns int as
begin
	declare @units int
	select @units = sum(CourseUnits)
		from StudentCourses sc
			inner join Courses c
				on sc.CourseID = c.CourseID
		where sc.StudentID = @StudentID
	return @units
end
go

--select dbo.fnStudentUnits(15)

select sc.StudentID, c.CourseNumber, c.CourseUnits, dbo.fnStudentUnits(StudentID) TotalUnits
from StudentCourses sc
	join Courses c
		on sc.CourseID = c.CourseID
   
/*
2.	Write a script that creates and calls a function named fnTuition that calculates the total tuition for a student.
	To do that, this function should accept one parameter for the student ID, it should use the fnStudentUnits function that you created in question 1, and it should return the value of the 
	tuition for that student depending on whether the student is fulltime (more than nine units) or part-time (nine or fewer units). 
	(Hint: Use a cross join to work with data in the Students and Tuition tables.)
	The SELECT statement that calls the function should return the StudentID from the Students table, the value returned by the fnStudentUnits function for that student, and the value returned by the fnTuition function for that student. 
	Return only rows for students taking one or more units.
*/


drop function if exists fnTuition
go

create function fnTuition (@StudentID int)
returns money as
begin
	declare @TotalUnits int
	declare @TotalCost money
	set @TotalUnits = dbo.fnStudentUnits(@StudentID)
	
	if @TotalUnits > 9
		select @TotalCost = FullTimeCost from Tuition
	if @TotalUnits <= 9
		select @TotalCost = PartTimeCost from Tuition having @TotalUnits >= 1

	return @TotalCost
end
go

select StudentID, dbo.fnStudentUnits(StudentID) TotalUnits, dbo.fnTuition(StudentID) TotalTuition
from Students s
	cross join Tuition t
group by StudentID
having dbo.fnStudentUnits(StudentID) >= 1


/*
3.	Create a trigger named Instructors_UPDATE that checks the new value for the AnnualSalary column of the Instructors table.  This trigger should raise an appropriate error if the annual salary is greater than 120,000 or less than 0.
	If the new annual salary is between 0 and 12,000, this trigger should modify the new annual salary by multiplying it by 12. 
	That way, a monthly salary of 5,000 becomes an annual salary of 60,000.
	Test this trigger with an appropriate UPDATE statement.
*/

drop trigger if exists Instructors_UPDATE
go

create trigger Instructors_UPDATE
	on Instructors
	after update
as
	set nocount on
	update Instructors
	set AnnualSalary = AnnualSalary * 12
	where AnnualSalary > 0 and AnnualSalary < 12000
go

--select * from Instructors
update Instructors
set AnnualSalary = 75
where InstructorID = 9


/*
4.	Create a trigger named Instructors_INSERT that inserts the current date for the HireDate column of the Instructors table if the value for that column is null.
	Test this trigger with an appropriate INSERT statement.
*/

drop trigger if exists Instructors_INSERT
go

create trigger Instructors_INSERT
	on Instructors
	after insert
as
	set nocount on
	update Instructors
	set HireDate = GETDATE()
	where InstructorID in (select InstructorID from inserted where HireDate is null)

insert Instructors (LastName, FirstName, Status, DepartmentChairman, HireDate,AnnualSalary,DepartmentID)
values (
	'Graham2','Matt','F',0,null,75000,2
)

select * from Instructors


/*
5.	Create a table named InstructorsAudit. This table should have all columns of the Instructors table. 
	Also, it should have an AuditID column for its primary key and a DATETIME2 column named DateUpdated.
	Create a trigger named Instructors_UPDATE. This trigger should insert the old data about the instructor into the InstructorsAudit table after the row is updated and set the DateUpdated column to the current date and time.
	Then, test this trigger with an appropriate UPDATE statement.
*/

CREATE TABLE InstructorsAudit(
	AuditID [int] IDENTITY(1,1) primary key NOT NULL,
	[InstructorID] [int] NOT NULL,
	[LastName] [varchar](25) NOT NULL,
	[FirstName] [varchar](25) NULL,
	[Status] [char](1) NOT NULL,
	[DepartmentChairman] [bit] NOT NULL,
	[HireDate] [date] NULL,
	[AnnualSalary] [money] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[DateUpdated] [datetime2] not null
)

drop trigger if exists Instructors_UPDATE

create trigger Instructors_UPDATE
	on Instructors
	after update
as
	insert into InstructorsAudit 
		(InstructorID, LastName, FirstName, Status, DepartmentChairman, HireDate, AnnualSalary, DepartmentID, DateUpdated)
	select InstructorID, LastName, FirstName, Status, DepartmentChairman, HireDate, AnnualSalary, DepartmentID, GETDATE()
	from deleted
		
go

select * from Instructors

update Instructors
set AnnualSalary = 750000
where InstructorID = 1019

--drop table InstructorsAudit

--select * from Instructors
--select * from InstructorsAudit



