--Matt Graham; clock start: 3:46pm PST

--How many active voters in Noble County have a first name that has ever appeared among the most popular names?
--2,192 active voters

SELECT COUNT(*) as TotalPeopleWithACertifiedPopularName
FROM NobleOhioVoters
WHERE EXISTS
	(SELECT *
	from ssa_baby_names
	WHERE 
	(
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 1]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 2])) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 3]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 4]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 5]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 1]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 2]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 3]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 4]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 5]) AND
	NobleOhioVoters.VOTER_STATUS like 'ACTIVE'
	)

--How many active voters in Noble County have a first name that was among the most popular names in the year they were born?
--1,972 active voters

SELECT COUNT(*) AS VotersWithCertifiedMostPopularNameFromBirthYear
FROM NobleOhioVoters
WHERE EXISTS
	(SELECT *
	from ssa_baby_names
	WHERE 
	(
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 1]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 2])) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 3]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 4]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 5]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 1]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 2]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 3]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 4]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 5]) AND
	NobleOhioVoters.VOTER_STATUS like 'ACTIVE' AND
	ssa_baby_names.Year = Year(NobleOhioVoters.DATE_OF_BIRTH)
	)

--How many households in Noble County with at least one registered voter also contain at least one voter with a first name among the most popular in the year they were born?
-- 1,663 households with active voters, 1,972 active voters

SELECT COUNT(DISTINCT RESIDENTIAL_ADDRESS1) as TotalHouseholdsWithActiveVoters, COUNT(NobleOhioVoters.FIRST_NAME) as NumberOfActiveVotersWithNamesInYearBornInHousehold
FROM NobleOhioVoters
WHERE EXISTS
	(SELECT *
	from ssa_baby_names
	WHERE 
	(
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 1]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 2])) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 3]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 4]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 5]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 1]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 2]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 3]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 4]) OR
	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 5]) AND
	NobleOhioVoters.VOTER_STATUS like 'ACTIVE' AND
	ssa_baby_names.Year = Year(NobleOhioVoters.DATE_OF_BIRTH)
	)

--End clock: 4:21pm PST, taking out the pup!
--PowerBI clock start: 4:50pm

--Visualize this data in an interesting way. Your visualization can relate to one of the previous questions, or can touch on something else you want to explore in the data. 
--Feel free to use any tools you’re comfortable with and bring in additional data. The goal here is to give you a chance to show us your strengths. Be creative.

	--Provide a couple sentences summarizing your visualization/analysis.
	--If you run out of time to fully implement your idea or have additional ideas for things you’d like to do with this data if given more time, describe them.

--To view the list of voters in Noble County who have a first name that has ever appeared among the most popular names, uncomment this query:
--SELECT SOS_VOTERID, CONCAT(FIRST_NAME, ' ',LAST_NAME) as FULL_NAME, DATE_OF_BIRTH, VOTER_STATUS, REGISTRATION_DATE, PARTY_AFFILIATION, RESIDENTIAL_ZIP, RESIDENTIAL_ZIP_PLUS4, CONGRESSIONAL_DISTRICT
--FROM NobleOhioVoters
--WHERE EXISTS
--	(SELECT *
--	from ssa_baby_names
--	WHERE 
--	(
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 1]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 2])) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 3]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 4]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 5]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 1]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 2]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 3]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 4]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 5]) AND
--  NobleOhioVoters.VOTER_STATUS like 'ACTIVE'
--	)
--ORDER BY DATE_OF_BIRTH DESC


--To view the list of active voters in Noble County who have a first name that was among the most popular names in the year they were born, uncomment this query
--SELECT SOS_VOTERID, CONCAT(FIRST_NAME, ' ',LAST_NAME) as FULL_NAME, DATE_OF_BIRTH, VOTER_STATUS, REGISTRATION_DATE, PARTY_AFFILIATION, RESIDENTIAL_ZIP, RESIDENTIAL_ZIP_PLUS4, CONGRESSIONAL_DISTRICT
--FROM NobleOhioVoters
--WHERE EXISTS
--	(SELECT *
--	from ssa_baby_names
--	WHERE 
--	(
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 1]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 2])) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 3]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 4]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 5]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 1]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 2]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 3]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 4]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 5]) AND
--	NobleOhioVoters.VOTER_STATUS like 'ACTIVE' AND
--  ssa_baby_names.Year = Year(NobleOhioVoters.DATE_OF_BIRTH)
--	)


--To view the list of members in households in Noble County with at least one registered voter also contain at least one voter with a first name among the most popular in the year they were born
--SELECT DISTINCT RESIDENTIAL_ADDRESS1 as HOUSEHOLD_ADDRESS, SOS_VOTERID, CONCAT(FIRST_NAME, ' ',LAST_NAME) as FULL_NAME, DATE_OF_BIRTH, VOTER_STATUS, REGISTRATION_DATE, PARTY_AFFILIATION, RESIDENTIAL_ZIP, RESIDENTIAL_ZIP_PLUS4, CONGRESSIONAL_DISTRICT
--FROM NobleOhioVoters
--WHERE EXISTS
--	(SELECT *
--	from ssa_baby_names
--	WHERE 
--	(
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 1]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 2])) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 3]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 4]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Female Rank 5]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 1]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 2]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 3]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 4]) OR
--	NobleOhioVoters.FIRST_NAME like (ssa_baby_names.[Male Rank 5]) AND
--	NobleOhioVoters.VOTER_STATUS like 'ACTIVE' AND
--	ssa_baby_names.Year = Year(NobleOhioVoters.DATE_OF_BIRTH)
--	)
--ORDER BY 1