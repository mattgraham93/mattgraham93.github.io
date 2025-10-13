--*  PROG 140           Chapter 16 Exercise				             DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the use of implicit transactions.
•	Describe the use of explicit transactions.
•	Describe the use of the COMMIT TRAN statement and the @@TRANCOUNT function within nested transactions.
•	Describe the use of save points.
•	Define these types of concurrency problems: lost updates, dirty reads, nonrepeatable reads, and phantom reads.
•	Describe the way locking and the transaction isolation level help to prevent concurrency problems.
•	Describe the way SQL Server manages locking in terms of granularity, lock escalation, shared locks, exclusive locks, and lock promotion.
•	Describe deadlocks and the way SQL Server handles them.
•	Describe four coding techniques that can reduce deadlocks.


Skills:

•	Given a set of statements to be combined into a transaction, insert the Transact-SQL statements to explicitly begin, commit, and roll back the transaction.


TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Exercise-Chap16.sql, where Xxxxx is your last and first name. 
	For example, I would rename this file FreebergCarl-PROG140-Exercise-Chap16.sql.

		Xxxxx-PROG140-Exercise-Chap16.sql

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


--- CHAPTER 16 - TRANSACTIONS AND LOCKING
1.	Write a script that includes two SQL statements coded as a transaction to delete the row with a student ID of 10 from the Students table. 
	To do this, you must first delete all courses for that student from the StudentCourses table.
	If these statements execute successfully, commit the changes. Otherwise, roll back the changes.
*/

use MurachCollege


begin tran;

delete StudentCourses where StudentID = 10
delete Students where StudentID = 10

if @@ROWCOUNT > 1
begin
	rollback tran
	print 'Student was not removed.'
end
else
begin
	commit tran;
	print 'Deletion committed to the database.'
end


/*
2.	Write a script that includes these statements coded as a transaction:
		  INSERT Students 
		  VALUES ('Smith', 'John', GETDATE(), NULL);

		  SET @StudentID = @@IDENTITY;

		  INSERT StudentCourses 
		  VALUES (@StudentID, @CourseID);
	Here, the @@IDENTITY variable is used to get the student ID value that’s automatically generated when the first INSERT statement inserts a student.
	If these statements execute successfully, commit the changes. Otherwise, roll back the changes.
*/


declare @StudentID int;
declare @CourseID int;
begin try
	begin tran;
		set nocount on;
		insert Students values ('Smith', 'John', GETDATE(), NULL);

		  set @StudentID = @@IDENTITY;
		  set @CourseID = 7

		  INSERT StudentCourses 
		  VALUES (@StudentID, @CourseID);
    commit tran;
end try
begin catch
	print 'Transaction not committed'
    rollback tran;
END CATCH;






