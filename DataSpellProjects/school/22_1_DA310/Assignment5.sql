--create table Driver_Licenses_Original (
--	CountOfIDs int,
--	Year int,
--	Month int,
--	IssueDate date,
--	CardType varchar(50),
--	County varchar(50),
--	PriorUSAState varchar(50),
--	PriorCountry varchar(50),
--	ISO2 varchar(10),
--	ISO3 varchar(10),
--	ISONum int,
--	IRSCountryCode varchar(10),
--	CardOrigin varchar(150)
--)

--create table Driver_Licenses (
--	Year int,
--	Month int,
--	IssueDate date,
--	CardType varchar(50),
--	County varchar(50),
--	PriorState varchar(50),
--	PriorCountry varchar(50),
--	OutOfCountryLicenseTransfer int
--)

--insert into Driver_Licenses (
--	Year,
--	Month,
--	IssueDate,
--	CardType,
--	County,
--	PriorState,
--	PriorCountry,
--	OutOfCountryLicenseTransfer
--)
--select
--	Year,
--	Month,
--	IssueDate,
--	CardType,
--	County,
--	PriorUSAState,
--	PriorCountry,
--	case 
--		when PriorUSAState like 'Not Applicable'
--			then 1
--		else
--			0
--	end OutOfCountryLicenseTransfer
--from Driver_Licenses_Original


--select * from Driver_Licenses


create procedure sp_Select_By_County @county varchar(50)
as
select * from [dbo].[Driver_Licenses]
where County like @county;

exec sp_Select_By_County @county = 'King';

create procedure sp_Select_By_State @state varchar(50)
as
select * from [dbo].[Driver_Licenses]
where PriorState like @state;

exec sp_Select_By_State @state = 'California';

create procedure sp_Select_By_Country @country varchar(50)
as
select * from [dbo].[Driver_Licenses]
where PriorCountry like @country;

exec sp_Select_By_Country @country = 'Argentina';