--*  PROG 140           Exercise   #2 (Chapter 3)              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

    o Understand the mechanics of completing exercises for this class
	o Understand the SQL syntax for retrieving data from single database tables

Skills:

    o Outside of class, access a computer that has SQL Server loaded on it
    o Interpret questions to understand how to answer the questions
    o Write SQL queries to answer questions by retrieving data from a single database table

TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-02, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-02.sql.

		Xxxxx-PROG140-Exercise-02.sql

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

--- CHAPTER 3 - RETRIEVE DATA FROM A SINGLE TABLE ---

USE MurachCollege;

/*
1. Write a SELECT statement that returns all of the columns from the Courses table. 
   Then, run this statement to make sure it works correctly.
*/

select*
from Courses


/*
2.	Write a SELECT statement that returns three columns from the Courses table: 
		CourseNumber, CourseDescription, and CourseUnits. 
	Then, run this statement to make sure it works correctly.
	Add an ORDER BY clause to this statement that sorts the result set by CourseNumber in ascending sequence.
	Then, run this statement again to make sure it works correctly. 
	This is a good way to build and test a statement, one clause at a time.
*/

select CourseNumber, CourseDescription, CourseUnits
from Courses
order by CourseNumber asc


/*
3.	Write a SELECT statement that returns one column from the Students table named FullName that joins the LastName and FirstName columns.
	Format this column with the last name, a comma, a space, and the first name like this:
		Doe, John
	Sort the result set by last name in ascending sequence.
	Return only the students whose last name begins with a letter from A to M.
*/

select CONCAT(LastName, ', ', FirstName) as FullName
from Students
where LastName <= 'M'
order by LastName asc


/*
4.	Write a SELECT statement that returns these column names and data from the Instructors table:
		LastName		The LastName column
		FirstName		The FirstName column
		AnnualSalary	The AnnualSalary column
	Return only the rows with an annual salary that’s greater than or equal to 60,000.
	Sort the result set in descending sequence by the AnnualSalary column.
*/

select LastName, FirstName, AnnualSalary
from Instructors
order by AnnualSalary desc


/*
5.	Write a SELECT statement that returns these column names and data from the Instructors table:
		LastName	The LastName column
		FirstName	The FirstName column
		HireDate	The HireDate column
	Return only the rows with a hire date that’s in 2019.
	Sort the result set in ascending sequence by the HireDate column.
*/

select LastName, FirstName, HireDate
from Instructors
where YEAR(HireDate) = 2019
order by HireDate asc


/*
6.	Write a SELECT statement that returns these column names and data from the Students table:
		FirstName		The FirstName column
		LastName		The LastName column
		EnrollmentDate	The EnrollmentDate column
		CurrentDate		The current date
		MonthsAttended	A column that’s calculated by getting the difference between the enrollment date and the current date
	To get the value of the months attended, use the DATEDIFF function with the month argument.
	Sort the result set in ascending sequence by the MonthsAttended column.
*/

select LastName, FirstName, EnrollmentDate, GETDATE() as CurrentDate, DATEDIFF(MONTH, EnrollmentDate, GETDATE()) as MonthsAttended
from Students
order by MonthsAttended asc


/*
7.	Write a SELECT statement that returns these column names and data from the Instructors table:
		FirstName	The FirstName column
		LastName	The LastName column
		AnnualSalary	The AnnualSalary column
	Return only the top 20 percent of instructors based on annual salary.
*/


select top 20 percent 
	FirstName, LastName, AnnualSalary
from Instructors


/*
8.	Write a SELECT statement that returns these column names and data from the Students table:
		LastName	The LastName column
		FirstName	The FirstName column
	Return only the rows where the LastName column starts with the letter 'G'. To do that, use the LIKE phrase.
	Sort the result set by last name in ascending sequence.
*/


select LastName, FirstName
from Students
where LastName like 'G%'
order by LastName asc



/*
9.	Write a SELECT statement that returns these column names and data from the Students table:
		LastName	The LastName column
		FirstName	The FirstName column
		EnrollmentDate	The EnrollmentDate column
		GraduationDate	The GraduationDate column
	Return only the rows where the EnrollmentDate column is greater than 12-01-2019 and the GraduationDate column contains a null value.
 */

 select LastName, FirstName, EnrollmentDate, GraduationDate
 from Students
 where EnrollmentDate > convert(datetime, '12-01-2019') and GraduationDate is null


/*
10.	Write a SELECT statement that returns these columns and data from the Tuition table, along with a constant value and two calculated values:
		FullTimeCost		The FullTimeCost column
		PerUnitCost			The PerUnitCost column
		Units				12
		TotalPerUnitCost	A column that’s calculated by multiplying the per unit cost by the units
		TotalTuition		A column that’s calculated by adding the full time cost to the total per unit cost
*/

select FullTimeCost, PerUnitCost, 12 as Units, 12 * PerUnitCost as TotalPerUnitCost, FullTimeCost + (12 * PerUnitCost) as TotalTuition
from Tuition

