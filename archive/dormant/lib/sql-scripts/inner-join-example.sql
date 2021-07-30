use [SalesOrdersExample]

-- assign table C to Customer for CustomerID; assign table O to Customer for CustomerID

select C.[CustFirstName] + ' ' + C.[CustLastName] as FullName, CAST(O.OrderDate as DATE) as OrderDate
FROM [dbo].[Customers] AS C
	INNER JOIN Orders as O
		ON C.CustomerID = O.CustomerID;

SELECT *
from [dbo].[Customers];
select * 
from [dbo].[Orders];

--JOIN THREE TABLES ON: ORDER NUMBER AND PRODUCT NUMBER
SELECT O.[OrderNumber], O.[OrderDate], P.[ProductName], OD.[ProductNumber], OD.[QuotedPrice], OD.[QuantityOrdered],
CAST(OD.QuotedPrice * OD.QuantityOrdered AS MONEY) AS AmountOwed
FROM [dbo].[Orders] AS O
	INNER JOIN [dbo].[Order_Details] AS OD
	ON O.[OrderNumber] = OD.OrderNumber
	INNER JOIN [dbo].[Products] AS P
	ON OD.ProductNumber = P.ProductNumber
-- SORT BY BIKE AND AMOUNT OWED GREATER THAN 2400
	WHERE od.ProductNumber IN (1, 2, 6, 11) AND CAST(OD.QuotedPrice * OD.QuantityOrdered AS MONEY) > 2400
	ORDER BY AmountOwed