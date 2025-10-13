SELECT CONCAT(p.FirstName, ' ', p.LastName) FullName, 
	sod.ProductID,
	prod.Name
FROM Person.Person p
	INNER JOIN Person.EmailAddress em
		ON em.BusinessEntityID = p.BusinessEntityID
	INNER JOIN Sales.Customer c
		ON c.CustomerID = p.BusinessEntityID
	INNER JOIN Sales.SalesOrderHeader soh
		ON soh.CustomerID = c.CustomerID
	INNER JOIN Sales.SalesOrderDetail sod
		ON sod.SalesOrderID = soh.SalesOrderID
	INNER JOIN Production.Product prod
		ON prod.ProductID = sod.ProductID
WHERE c.CustomerID = 11037	