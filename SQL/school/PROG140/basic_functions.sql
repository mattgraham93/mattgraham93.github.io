--*  PROG 140           Chapter 9 Exercise              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe how the use of functions can solve the problems associated with (1) sorting string data that contains numeric values, and (2) doing date or time searches.

Skills:

•	Code queries that require any of the functions presented in this chapter for working with string, numeric, and date/time data.
•	Code queries that use any of the general purpose functions presented in this chapter.

TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap09.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap09.sql

		Xxxxx-PROG140-Exercise-Chap09.sql

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

*/

/*	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 


    For this Exercise, we will use the Murach College database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

--- CHAPTER 9 - HOW TO USE FUNCTIONS -- 

USE MurachCollege;

--1.	Write a SELECT statement that returns these columns from the Instructors table:
--			The AnnualSalary column
--			A column named MonthlySalary that is the result of dividing the AnnualSalary column by 12
--			A column named MonthlySalaryRounded that calculates the monthly salary and then uses the ROUND function to round the result to 2 decimal places

select AnnualSalary,
	AnnualSalary / 12 MonthlySalary,
	ROUND(AnnualSalary/12, 2) MonthlySalaryRounded
from Instructors;


--2.	Write a SELECT statement that returns these columns from the Students table:
--			The EnrollmentDate column
--			A column that returns the four-digit year that’s stored in the EnrollmentDate column
--			A column that returns only the day of the month that’s stored in the EnrollmentDate column
--			A column that returns the result from adding four years to the EnrollmentDate column; use the CAST function so only the year is returned

select EnrollmentDate,
	YEAR(EnrollmentDate) EnrollmentYear,
	day(EnrollmentDate) EnrollmentDay,
	CAST(year(EnrollmentDate)+4 as varchar) ExpectedGraduation
from Students


--3.	Write a SELECT statement that returns these columns:
--			The DepartmentName column from the Departments table
--			The CourseNumber column from the Courses table
--			The FirstName column from the Instructors table
--			The LastName column from the Instructors table
--			Add a column that includes the first three characters from the DepartmentName column in uppercase, concatenated with the CourseNumber column, the first character of the FirstName column if this column isn’t null or an empty string otherwise, and the LastName column. 
--		For this to work, you will need to cast the CourseNumber column to a character column.

select DepartmentName, CourseNumber, FirstName, LastName, 
	CONCAT(
		LEFT(DepartmentName,1),
		cast(LEFT(CourseNumber,1) as varchar),
		case when FirstName is not null
			then LEFT(FirstName, 1)
		else
			left(lastname,1)
		end
		) CourseCode 
from Instructors i
	inner join Courses c
		on i.InstructorID = c.InstructorID
	inner join Departments d
		on i.DepartmentID = d.DepartmentID and c.DepartmentID = d.DepartmentID


--4.	Write a SELECT statement that returns these columns from the Students table:
--			The FirstName column
--			The LastName column
--			The EnrollmentDate column
--			The GraduationDate column
--			A column that shows the number of months between the EnrollmentDate and GraduationDate columns
--		Return one row for each student who has graduated.

select FirstName, LastName, EnrollmentDate, GraduationDate,
	DATEDIFF(MONTH, EnrollmentDate, GraduationDate) as TimeInSchool
from Students
where GraduationDate is not null






