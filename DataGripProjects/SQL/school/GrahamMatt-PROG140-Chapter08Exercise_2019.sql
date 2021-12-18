--*  PROG 140           Chapter 8 Exercise              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the data that can be stored in any of the string, numeric, date/time, and large value data types.
•	Describe the difference between standard character data and Unicode character data.
•	Describe the differences between implicit and explicit data type conversion.

Skills:

•	Code queries that use the data conversion functions to work with the data types presented in this chapter.

TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap08.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap08.sql

		Xxxxx-PROG140-Exercise-Chap08.sql

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

--- CHAPTER 8 - HOW TO WORK WITH DATA TYPES ---

USE MurachCollege;

--1.	Write a SELECT statement that returns these columns from the Instructors table:
--			The monthly salary (the AnnualSalary column divided by 12)
--			A column that uses the CAST function to return the monthly salary with 1 digit to the right of the decimal point
--			A column that uses the CONVERT function to return the monthly salary as an integer
--			A column that uses the CAST function to return the monthly salary as an integer

select 
	cast(AnnualSalary/12 as decimal(10,2)) as MonthlySalary,
	cast(AnnualSalary/12 as decimal(10,1)) as MonthlyOneDec,
	convert(int, AnnualSalary/12) as MonthlySalaryConvertInt,
	Cast(AnnualSalary/12 as int) as MonthlySalaryCastInt
from Instructors;


--2.	Write a SELECT statement that returns these columns from the Students table:
--			The EnrollmentDate column
--			A column that uses the CAST function to return the EnrollmentDate column with its date only (year, month, and day)
--			A column that uses the CAST function to return the EnrollmentDate column with its full time only (hour, minutes, seconds, and milliseconds) 
--			A column that uses the CAST function to return the EnrollmentDate column with just the year and month

select EnrollmentDate,
	cast(EnrollmentDate as date) EnrollmentDateOnly,
	cast(EnrollmentDate as time) EnrollmentTimeOnly,
	right(CONVERT(varchar, EnrollmentDate, 103), 7) as EnrollmentMMYYY
from Students;

--3.	Write a SELECT statement that returns these colums from the Students table:
--			A column that uses the CONVERT function to return the EnrollmentDate column in this format: MM/DD/YYYY. In other words, use 2-digit months and  days and a 4-digit year, and separate each date component with slashes.
--			A column that uses the CONVERT function to return the EnrollmentDate column with the date, and the hours and minutes on a 12-hour clock with an am/pm indicator.
--			A column that uses the CONVERT function to return the EnrollmentDate column with just the time in a 24-hour format, including the milliseconds.
--			A column that uses the CONVERT function to return the EnrollmentDate column with just the month and day.

select 
	CONVERT(varchar, EnrollmentDate, 101) EnrollmentDate,
	CONVERT(varchar, EnrollmentDate, 109) EnrollmentTimeAMPM,
	CONVERT(varchar, EnrollmentDate, 114) EnrollmentTime24H,
	left(CONVERT(varchar, EnrollmentDate, 101), 5) EnrollmentMMDD
from Students












