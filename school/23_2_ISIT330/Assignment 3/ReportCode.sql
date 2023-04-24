
USE Courses;

SELECT DIV.Division, CourseID, CourseTitle, Year_Qtr
FROM FallCourse AS Fall
	INNER JOIN Division AS DIV
	ON DIV.DivisionKEY=Fall.DivisionKey
		INNER JOIN Term
		ON TERM.YRQ=Fall.YRQ
UNION
SELECT DIV2.Division, CourseID, CourseTitle, Year_Qtr
FROM WinterCourse AS Winter
	INNER JOIN Division AS DIV2
	ON DIV2.DivisionKEY=Winter.DivisionKey
		INNER JOIN Term
		ON Term.YRQ=Winter.YRQ
ORDER BY Division ASC;
