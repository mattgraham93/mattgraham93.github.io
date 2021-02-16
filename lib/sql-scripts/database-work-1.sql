-------------------------------------------------------------------
------------- BUSIT 103 Midterm 1		---------------------------
------------- Part 2 of 2				---------------------------
------------- Due as posted in Canvas	---------------------------
-------------------------------------------------------------------

-- Use WideWorldImporters for all questions.

use [WideWorldImporters];

-- Note that the Midterm Part 1 of 2 is worth 10 points
-- This midterm file, Part 2 of 2, is worth 20 points.
-- Together both parts are worth 30 points, as posted.  


---------------------------------------------------------------------------------
-- 1.	Write a SELECT statement that displays all fields and records for the Sales.Customer table. 
--		In your SELECT list each of the fields in the table (i.e. do NOT simply use SELECT *).
--		1 point.

SELECT 
	CustomerCategoryID, 
	CustomerName, 
	BillToCustomerID, 
	CustomerCategoryID, 
	BuyingGroupID, 
	PrimaryContactPersonID, 
	AlternateContactPersonID, 
	DeliveryMethodID, 
	DeliveryCityID, 
	PostalCityID, 
	CreditLimit, 
	AccountOpenedDate,
	StandardDiscountPercentage,
	IsStatementSent,
	IsOnCreditHold,
	PaymentDays,
	PhoneNumber,
	FaxNumber,
	DeliveryRun,
	RunPosition,
	WebsiteURL,
	DeliveryAddressLine1,
	DeliveryAddressLine2,
	DeliveryPostalCode,
	DeliveryLocation,
	PostalAddressLine1,
	PostalAddressLine2,
	PostalPostalCode,
	LastEditedBy,
	ValidFrom,
	ValidTo
FROM [Sales].[Customers];

---------------------------------------------------------------------------------
-- 2.	Develop a display message for customers, displayed all in one column, 
--		structured as follows:
--
--			Welcome back, Aakriti Byrraju. Your credit limit is: 3500.00
--
--		If a customer has no credit limit, use the ISNULL() function to 
--		display (Pending) instead, as in this example:
--
--			Welcome back, Wingtip Toys (Yaak, MT). Your credit limit is: (Pending)

--		4 points.

SELECT CONCAT('Welcome back, ' + CustomerName + '. Your credit limit is: ', ISNULL(CAST(CreditLimit as nvarchar),'(Pending)')) as DisplayMessage
FROM [Sales].[Customers];

---------------------------------------------------------------------------------
-- 3.	Display a list of all of the products supplied by Fabrikam, Inc.
--
--		Note: Though you will need to view several tables to research this,
--		your final answer should be one SQL statement based on one table.
--		I do NOT intend	for your to create a join as we have not yet covered joins.

--		3 points.

SELECT SupplierID, [StockItemName] as AllFabrikamProductsInWarehouse
FROM [Warehouse].[StockItems]
WHERE SupplierID = 4;

---------------------------------------------------------------------------------
-- 4.	Using the Sales.Orders table, display 3 columns:
--			the order date,
--			the expected delivery date,
--			and then write an equation that displays the order date minus the 
--			expected delivery date and name this new column DeliveryDays.

--		3 points.


SELECT OrderDate, ExpectedDeliveryDate, DateDiff(day,OrderDate,ExpectedDeliveryDate) as DeliveryDays
FROM [Sales].[Orders]
--ORDER BY DeliveryDays DESC;

---------------------------------------------------------------------------------
-- 5.	Show all of the J,K, and L stock bin locations that have 
--		reorder levels at 5 or less.

--		4 points.

SELECT BinLocation, ReorderLevel
FROM [Warehouse].[StockItemHoldings]
WHERE ReorderLevel <= 5 AND (BinLocation like ('J%') or BinLocation like ('K%') or BinLocation like ('L%'));

----------------------------------------------------------------------------------------
-- 6.	Though Wide World Importers has over 600 customers, they have multiple customers
--		in the same delivery zip code. Display the list of each of the customer 
--		delivery zip codes without showing the duplicates.

--		2 points.

SELECT DISTINCT [PostalPostalCode] as UniqueCustomerZipCodes
FROM [Sales].[Customers];

-----------------------------------------------------------------------------------------
-- 7.	Show the sales orders that were placed in the month of January in 2014 and 2015.
--		This should be displayed with one SQL statement.

--		3 points.

SELECT [OrderDate]
FROM [Sales].[Orders]
WHERE (OrderDate BETWEEN '2014-01-01' AND '2014-01-31') or (OrderDate BETWEEN '2015-01-01' AND '2015-01-31');

------------------------------------------------------------------------------------------
----- End of Assignment ------------------------------------------------------------------
------------------------------------------------------------------------------------------