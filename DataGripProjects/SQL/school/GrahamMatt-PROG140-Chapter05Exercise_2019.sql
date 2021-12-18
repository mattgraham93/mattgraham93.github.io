--*  PROG 140           Exercise   #4 (Chapter 5)              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

    o Understand the SQL syntax for creating summary queries

Skills:

    o Interpret questions to understand how to answer the questions
    o Write SQL queries to answer questions by coding summary queries

TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-04, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-04.sql.

		Xxxxx-PROG140-Exercise-04.sql

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

 --- CHAPTER 5 - SUMMARY QUERIES ---
 USE MurachCollege;

/*
1.	Write a SELECT statement that returns these columns:
		The count of the number of instructors in the Instructors table
		The average of the AnnualSalary column in the Instructors table
	Include only those rows where the Status column is equal to “F” (Fulltime).
*/

select COUNT(InstructorID) as NumberOfInstructors, AVG(AnnualSalary) as AvgAnnualSalary
from Instructors
where Status = 'F'


/*
2.	Write a SELECT statement that returns one row for each department that has instructors with these columns:
		The DepartmentName column from the Departments table
		The count of the instructors in the Instructors table
		The annual salary of the highest paid instructor in the Instructors table
	Sort the result set so the department with the most instructors appears first.
*/

select DepartmentName, COUNT(InstructorID) as NumberOfInstructors, MAX(AnnualSalary) as TopSalary
from Departments d
	inner join Instructors i
		on d.DepartmentID = i.InstructorID
group by DepartmentName
order by 3 desc


/*
3.	Write a SELECT statement that returns one row for each instructor that has courses with these columns:
		The instructor first and last names from the Instructors table in this format: John Doe (Note: If the instructor first name has a null value, the concatenation of the first and last name will result in a null value.)
		A count of the number of courses in the Courses table
		The sum of the course units in the Courses table
	(Hint: You will need to concatenate the instructor first and last names again in the GROUP BY clause.)
	Sort the result set in descending sequence by the total course units for each instructor.
*/

select CONCAT(FirstName, ' ', LastName) as FullName, COUNT(CourseID) as NumberOfCourses, SUM(CourseUnits) as TotalCourseUnits
from Instructors i
	inner join Courses c
		on i.InstructorID = c.InstructorID
group by FirstName, LastName
order by 3 desc


/*
4.	Write a SELECT statement that returns one row for each course that has students enrolled with these columns:
		The DepartmentName column from the Departments table
		The CourseDescription from the Courses table
		A count of the number of students from the StudentCourses table
	Sort the result set by DepartmentName, then by the enrollment for each course.
*/

select DepartmentName, CourseDescription, COUNT(sc.StudentID) as StudentsEnrolled
from Courses c
	inner join Departments d
		on c.DepartmentID = d.DepartmentID
	inner join StudentCourses sc
		on c.CourseID = sc.CourseID
	inner join Students s
		on sc.StudentID = s.StudentID
group by DepartmentName, CourseDescription


/*
5.	Write a SELECT statement that returns one row for each student that has courses with these columns:
		The StudentID column from the Students table
		The sum of the course units in the Courses table
	Sort the result set in descending sequence by the total course units for each student.
*/

select s.StudentID, sum(CourseUnits) as CourseUnitsEnrolled
from StudentCourses sc
	inner join Students s
		on sc.StudentID = s.StudentID
	inner join Courses c
		on sc.CourseID = c.CourseID
group by s.StudentID
order by 2 desc


/*
6.	Modify the solution to exercise 5 so it only includes students who haven’t graduated and who are taking more than nine units.
*/

select s.StudentID, sum(CourseUnits) as CourseUnitsEnrolled
from StudentCourses sc
	inner join Students s
		on sc.StudentID = s.StudentID
	inner join Courses c
		on sc.CourseID = c.CourseID
where GraduationDate is null
group by s.StudentID
having SUM(CourseUnits) > 9
order by 2 desc


/*
7.	Write a SELECT statement that answers this question: What is the total number of courses taught by parttime instructors? Return these columns:
The instructor last name and first name from the Instructors table in this format: Doe, John (Note: If the instructor first name has a null value, the concatenation of the first and last name will result in a null value.)
The total number of courses taught for each instructor in the Courses table
Use the ROLLUP operator to include a row that gives the grand total.
*/

select CONCAT(LastName, ', ', FirstName) as FullName, COUNT(CourseID) as CoursesTaught
from Courses c
	inner join Instructors i
		on c.InstructorID = i.InstructorID
group by rollup (LastName, FirstName)
