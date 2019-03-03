--1
SELECT 
	SUM((si.UnitPrice * ol.Quantity) * (1 + (si.TaxRate/100))) as TotalSales2015
FROM sales.orderlines ol INNER JOIN Warehouse.stockitems si
	ON ol.StockItemID = si.StockItemID
	INNER JOIN sales.invoices i
	ON ol.OrderID = i.OrderID
WHERE si.StockItemName = 'USB food flash drive - donut' and
	i.InvoiceDate LIKE '2015%';

--2
SELECT 
	states.StateProvinceName,
	ISNULL(t1.NumCustomers, 0)
FROM Application.StateProvinces states LEFT JOIN (
	SELECT sp.StateProvinceName,
		COUNT(sp.StateProvinceID) NumCustomers
	FROM sales.customers cus INNER JOIN Application.Cities cit
	ON cus.DeliveryCityID = cit.CityID
	INNER JOIN Application.StateProvinces sp
	ON cit.StateProvinceID = sp.StateProvinceID	
	GROUP BY sp.StateProvinceName
) t1
ON states.StateProvinceName = t1.StateProvinceName
ORDER BY NumCustomers;

--3
SELECT 
	p.personID,
	p.preferredName as FirstName,
	RIGHT(p.FullName, LEN(p.Fullname) - CHARINDEX(' ', p.Fullname)) as LastName,
	p.EmailAddress,
	p.PhoneNumber
FROM (
	SELECT EmailAddress,
		COUNT(personID) CountOfEmails
	FROM Application.People
	GROUP BY EmailAddress
	HAVING COUNT(emailaddress) > 1
) t1
INNER JOIN Application.People p
	ON p.EmailAddress = t1.EmailAddress