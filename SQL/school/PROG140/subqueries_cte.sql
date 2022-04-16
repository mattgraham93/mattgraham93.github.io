--*  PROG 140           Chapter 6 Exercise              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the way subqueries can be used in the WHERE, HAVING, FROM and SELECT clauses of a SELECT statement.
•	Describe the difference between a correlated subquery and a noncorrelated subquery.
•	Describe the use of common table expressions (CTEs).

Skills:

	•	Code SELECT statements that require subqueries.
	•	Code SELECT statements that use common table expressions (CTEs) to define the subqueries.

TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap06.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap06.sql

		Xxxxx-PROG140-Exercise-Chap06.sql

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


    For this Exercise, we will use the MurachCollege database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

--- CHAPTER 6 - HOW TO CODE SUBQUERIES ---

USE MurachCollege;


--1.	Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. 
--		Instead, use a subquery in a WHERE clause that uses the IN keyword.
			--SELECT DISTINCT LastName, FirstName
			--FROM Instructors i 
			--	JOIN Courses c
			--	ON i.InstructorID = c.InstructorID
			--ORDER BY LastName, FirstName

		select i.LastName, i.FirstName
		from Instructors i
		where i.InstructorID in 
			(select c.InstructorID
			from Courses c
			where c.InstructorID = i.InstructorID);


--2.	Write a SELECT statement that answers this question: 
--			Which instructors have an annual salary that’s greater than the average annual salary for all instructors?
--		Return the LastName, FirstName, and AnnualSalary columns for each Instructor.
--		Sort the result set by the AnnualSalary column in descending sequence.

select i.LastName, i.FirstName, i.AnnualSalary
from Instructors i
where AnnualSalary > 
	(select AVG(AnnualSalary)
	from Instructors)
order by AnnualSalary desc;
			

--3.	Write a SELECT statement that returns the LastName and FirstName columns from the Instructors table.
--		Return one row for each instructor that doesn’t have any courses in the Courses table. 
--		To do that, use a subquery introduced with the NOT EXISTS operator.
--		Sort the result set by LastName and then by FirstName.

select i.LastName, i.FirstName
from Instructors i
where not exists 
	(select c.InstructorID
	from Courses c
	where i.InstructorID = c.InstructorID)
order by LastName, FirstName;

 
--4.	Write a SELECT statement that returns the LastName and FirstName columns from the Instructors table, along with a count of the number of courses each student is taking from the StudentCourses table.
--		Return one row for each instructor that is teaching more than one class.
--		To do that, use a subquery with the IN class that groups the student course by StudentID.
--		Group and sort the result set by the LastName and then by the FirstName.

select LastName, FirstName, COUNT(c.CourseID) as NumberOfCourses
from Instructors i
	join Courses c
		on i.InstructorID = c.InstructorID
where i.InstructorID in
	(select i.InstructorID
	from Instructors i 
	join StudentCourses sc
		on sc.CourseID = c.CourseID
	group by InstructorID
	having COUNT(sc.CourseID) > 1)
group by LastName, FirstName
order by LastName, FirstName;

 
--5.	Write a SELECT statement that returns the LastName, FirstName, and AnnualSalary columns of each instructor that has a unique annual salary. 
--		In other words, don’t include instructors that have the same annual salary as another instructor.
--		Sort the results by LastName and then by FirstName.

select LastName, FirstName, AnnualSalary
from Instructors
where AnnualSalary not in
	(select AnnualSalary
	from Instructors
	group by AnnualSalary
	having count(AnnualSalary) >1)
order by LastName, FirstName;

 
--6.	Write a SELECT statement that returns one row for each course with these columns:
--			The CourseID column from the Courses table
--			The most recent enrollment date for that course from the Students table
--		Change the SELECT statement to a CTE. Then, write a SELECT statement that returns one row per course that shows the CourseDescription for the course and the LastName, FirstName, and EnrollmentDate for the student with the most recent enrollment data.

with CourseEnrollment as
(
select c.CourseID, c.CourseDescription, max(s.EnrollmentDate) as LastEnrollmentDate
from Students s
	join StudentCourses sc 
		on s.StudentID = sc.StudentID
	join Courses c
		on sc.CourseID = c.CourseID
group by c.CourseID, c.CourseDescription
)
select distinct ce.CourseID, LastEnrollmentDate, CourseDescription
, LastName, FirstName
from CourseEnrollment ce
	inner join StudentCourses sc
		on ce.CourseID = sc.CourseID
	inner join Students s
		on sc.StudentID = s.StudentID
