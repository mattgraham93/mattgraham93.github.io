USE master
GO

DROP DATABASE IF EXISTS Courses;
GO

CREATE DATABASE Courses;
GO

USE Courses;
GO

CREATE TABLE FallCourse
(
	CourseKEY int IDENTITY(1,1) NOT NULL,
	CourseID varchar(50) NOT NULL,
	CourseTitle varchar(50) NOT NULL,
	YRQ varchar(4) NOT NULL,
	DivisionKey int
)
GO

CREATE TABLE WinterCourse
(
	CourseKEY int IDENTITY(1,1) NOT NULL,
	CourseID varchar(50) NOT NULL,
	CourseTitle varchar(50) NOT NULL,
	YRQ varchar(4) NOT NULL,
	DivisionKey int
)
GO

CREATE TABLE Division
(
	DivisionKEY int IDENTITY(1,1) NOT NULL,
	Division varchar(50) NOT NULL,
	DivisionName varchar(50) NOT NULL
)
GO

CREATE TABLE Term
(
	TermKEY int IDENTITY(1,1) NOT NULL,
	YRQ varchar(4) NOT NULL,
	Year_Qtr varchar(50) NOT NULL
)
GO
