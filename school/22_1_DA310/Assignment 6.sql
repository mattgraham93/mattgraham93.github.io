
    --Out of Country Transfers

	--What are the top five countries that people have moved from? 
	select [PriorCountry], count(*) LicensesTransferredFrom
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1
	group by PriorCountry
	order by 2 desc

	-- Top 5: 

	--Canada
	--Mexico
	--South Korea
	--India
	--Guam


    --What are the top five countries that people moved from to KING County? 
	select [PriorCountry], count(*) LicensesTransferredFrom
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1 and County like 'King'
	group by PriorCountry
	order by 2 desc

	--Canada
	--India
	--South Korea
	--Taiwan
	--Brazil


    --What are the top five countries that people moved from to Snohomish County? 
	select [PriorCountry], count(*) LicensesTransferredFrom
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1 and County like 'Snohomish'
	group by PriorCountry
	order by 2 desc

	--Canada
	--South Korea
	--Mexico
	--Brazil
	--Japan


    --What are the top five countries that people moved from to Pierce County? 
	select [PriorCountry], count(*) LicensesTransferredFrom
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1 and County like 'Pierce'
	group by PriorCountry
	order by 2 desc

	--Guam
	--American Samoa
	--South Korea
	--Puerto Rico
	--Mexico


    --What percentage of people from out of the country moved to KING County?
    --Example: Let's say 10,000 people from out of the country moved to Washington state and 5,000 of them moved to King County - that would be 50%. 
	
	--select count(*)
	--from Driver_Licenses
	--where OutOfCountryLicenseTransfer = 1 

	-- total out of country license transfers: 33769

	select County, cast((sum(OutOfCountryLicenseTransfer) / 33769.0) * 100 as decimal(6,4)) PercentTransferredTo
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1
	group by County
	order by 2 desc

	-- Out of country transfers to King County = 58.6781%
	
    --Other than King, Snohomish and Pierce County, what are the next 3 most popular counties that people from out of the country register for a new license? 
		
		--Clark		4.3679%
		--Whatcom	2.2980%
		--Thurston	2.2062%


    --Which month and year have the most people transferred licenses/ids from out of the country? the least?
	
	select Month, Year, count(*) LicensesTransferredFrom
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1
	group by Month, Year
	order by 3 desc

		--Most = October 2021 at 1329
		--Least = June 2020 at 57
	

	--Out of State Transfers
 --   What are the top five states that people have moved from? 
	 select PriorState, count(*) LicensesTransferredFrom
	 from Driver_Licenses
	 where OutOfCountryLicenseTransfer = 0
	 group by PriorState
	 order by 2 desc

	--California
	--Oregon
	--Texas
	--Arizona
	--Florida


 --   What are the top five states that people moved from to KING County? 
 	 select PriorState, count(*) LicensesTransferredFrom
	 from Driver_Licenses
	 where OutOfCountryLicenseTransfer = 0 and County like 'King'
	 group by PriorState
	 order by 2 desc

	--California
	--Texas
	--Florida
	--Oregon
	--New York

 --   What are the top five states that people moved from to Snohomish County? 
  	 select PriorState, count(*) LicensesTransferredFrom
	 from Driver_Licenses
	 where OutOfCountryLicenseTransfer = 0 and County like 'Snohomish'
	 group by PriorState
	 order by 2 desc

	--California
	--Texas
	--Oregon
	--Arizona
	--Florida


 --   What are the top five states that people moved from to Pierce County? 
  	 select PriorState, count(*) LicensesTransferredFrom
	 from Driver_Licenses
	 where OutOfCountryLicenseTransfer = 0 and County like 'Pierce'
	 group by PriorState
	 order by 2 desc
	 
	--California
	--Texas
	--Oregon
	--Florida
	--Arizona


 --   What percentage of people from out of state moved to KING County?
 --   Example: Let's say 10,000 people from out of state moved to Washington state and 5,000 of them moved to King County - that would be 50%. 
	
	--select count(*)
	--from Driver_Licenses
	--where OutOfCountryLicenseTransfer = 0  = 528381

	select County, cast((count(*) / 528381.0) * 100 as decimal(6,4)) PercentTransferredTo 
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 0
	group by County
	order by 2 desc

	-- Out of state transfers to King County = 35.3582%

 --   Other than King, Snohomish and Pierce County, what are the next 3 most popular counties that people from out of state register for a new license? 
 --   Which month and year have the most people transferred licenses/ids from out of the state? the least?

		--Clark		10.7468%
		--Spokane	7.0871%
		--Thurston	4.1082%


--	Which month and year have the most people transferred licenses/ids from out of the state? the least?

	select Month, Year, count(*) LicensesTransferredFrom
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 0
	group by Month, Year
	order by 3 desc

	--Most = August 2021 at 18099
	--Least = May 2020 at 24


	select count(*) LicensesTransferred, County, PriorCountry
	from Driver_Licenses
	where OutOfCountryLicenseTransfer = 1
	group by County, PriorCountry
	order by 1 desc