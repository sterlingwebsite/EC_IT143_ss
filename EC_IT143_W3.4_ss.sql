/*****************************************************************************************************************
NAME:    My Script Name
PURPOSE: My script purpose...

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     05/23/2022   JJAUSSI       1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/

/*
Example:
SELECT p.PersonId,
       p.FirstName,
       p.LastName,
       p.Name
  FROM Person AS p
 WHERE p.Name = 'New York'
    OR p.Name = 'Chicago';
*/

-- Q1 Business User question—Marginal complexity: What are our top ten most expensive products in terms of list price? Author: Sterling Steele
SELECT		TOP 10 Name, 
			ListPrice
FROM		Production.Product
ORDER BY	ListPrice DESC;

-- Q2 Business User question—Marginal complexity: What is the total number of products we currently have in stock? Author: Sterling Steele
SELECT		SUM(Quantity) AS TotalStock
FROM		Production.ProductInventory;

-- Q3 Business User question—Moderate complexity: Retrieve the first 10 LoginID values from the HumanResources.Employee table along with the corresponding FirstName and LastName from the Person.Person table, 
-- sorted by BusinessEntityID. Author: Ariel Sanchez
SELECT		TOP 10 
			e.LoginID, 
			p.FirstName, 
			p.LastName
FROM		HumanResources.Employee e
JOIN		Person.Person p
ON			e.BusinessEntityID = p.BusinessEntityID
ORDER BY	e.BusinessEntityID;
-- I don't know whay Ariel wanted me to sort by BusinessEntityID, but I did it anyway. I would rather sort by First or Last name, so I could more easily find the ID for a specific person.

-- Q4 Business User question—Moderate complexity: Based on the hire date, which top five employees have been hired for the longest period? Author: Catherine Kivindu
SELECT		TOP 5 
			FirstName, 
			LastName, 
			HireDate
FROM		HumanResources.Employee e
JOIN		Person.Person p
ON			e.BusinessEntityID = p.BusinessEntityID
ORDER BY	HireDate ASC;

-- Q5 Business User question—Increased complexity: We are trying to decide if it is worth it to ship our product over seas. We think that we might have a market in Europe but we do not know if it 
-- will be profitable. Is there a way to see how much we will be making by shipping items to Europe and selling products at the same price? Author: Ethan Silva
SELECT		p.ProductID, 
			p.Name, 
			p.ListPrice, 
			(p.ListPrice - p.StandardCost - s.ShippingCost) AS EstimatedNetRevenue
FROM		Production.Product p
JOIN		Sales.SalesOrderDetail sod 
ON			p.ProductID = sod.ProductID
JOIN		Sales.SalesOrderHeader soh 
ON			sod.SalesOrderID = soh.SalesOrderID
JOIN		(SELECT ProductID, AVG(ShippingCost) AS ShippingCost
			FROM ShippingCosts
			WHERE Destination = 'Europe'
			GROUP BY ProductID) s 
			ON p.ProductID = s.ProductID
WHERE		soh.TerritoryID 
IN			(SELECT TerritoryID 
			FROM Sales.SalesTerritory 
			WHERE Name = 'Europe');
/*	This is how the script would look if I had the required information to solve this question: Table named "ShippingCosts", column "ShippingCost", "Destination", and "ProductID", but they aren't in this 
	database. I need this information to determine the cost of shipping product to Europe. After obtaining the information, I could use the above query to compare the costs between shipping to Europe and 
	where we are currently shipping.*/

-- Q6 Business User question—Increased complexity: Can you provide a report detailing the sales performance of red mountain bikes for 2017-2019? I need to know the monthly sales quantity, total revenue, 
-- and the average price paid by customers for each model. Author: Joseph Karimu
SELECT		YEAR(soh.OrderDate) AS Year,
			MONTH(soh.OrderDate) AS Month,
			p.Name AS Model,
			SUM(sod.OrderQty) AS MonthlySalesQuantity,
			SUM(sod.LineTotal) AS TotalRevenue,
			AVG(sod.UnitPrice) AS AveragePricePaid
FROM		Sales.SalesOrderDetail sod
JOIN		Sales.SalesOrderHeader soh 
ON			sod.SalesOrderID = soh.SalesOrderID
JOIN		Production.Product p 
ON			sod.ProductID = p.ProductID
JOIN		Production.ProductSubcategory ps 
ON			p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN		Production.ProductCategory pc 
ON			ps.ProductCategoryID = pc.ProductCategoryID
WHERE		pc.Name = 'Bikes' AND 
			ps.Name LIKE '%Mountain%' AND 
			p.Color = 'Red' AND 
			soh.OrderDate BETWEEN '2017-01-01' AND '2019-12-31'
GROUP BY	YEAR(soh.OrderDate), 
			MONTH(soh.OrderDate), 
			p.Name
ORDER BY	Year, 
			Month, 
			Model;
-- This returns no data, because there were no red mountain bikes sold between 2017 and 2019. The database's latest date for selling a mountain bike was May of 2014, and the only colors of mountain bikes
-- sold were black and silver. If I wanted to find a report detailing the sales performace of black mountain bikes for 2013-2014, I would change the associated dates and color in the WHERE clause to
-- 2013-01-01 and 2014-12-31 and Black.

-- Q7 Metadata question—Using the Sales.vSalesPerson veiw, can you list the FirstName, LastName, and JobTitle where the TerritoryName is NULL or Empty? Author: Justin Hemmert
SELECT		FirstName, 
			LastName, 
			JobTitle
FROM		Sales.vSalesPerson
WHERE		TerritoryName IS NULL OR TerritoryName = '';

-- Q8 Metadata question—What are the names of all views in the AdventureWorks database that provide sales statistics? Author: Collins Ntow
SELECT 
    TABLE_SCHEMA, 
    TABLE_NAME 
FROM 
    INFORMATION_SCHEMA.VIEWS 
WHERE 
    TABLE_NAME LIKE '%Sales%' OR
	TABLE_SCHEMA LIKE '%Sales%';

SELECT GETDATE() AS my_date;
