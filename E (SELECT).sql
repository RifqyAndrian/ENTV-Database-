USE ENTV
GO

--1
SELECT s.StaffID, StaffName, VendorName, [Total Transaction] = COUNT(PurchaseTransactionID)
FROM Staff s JOIN PurchaseTransaction pt ON s.StaffID = pt.StaffID
JOIN Vendor v ON pt.VendorID = v.VendorID
WHERE MONTH(TransactionDate) > 8 AND StaffName LIKE 'B%'
GROUP BY s.StaffID, StaffName, VendorName

--2
SELECT [CustomerID] = RIGHT(c.CustomerID,3), CustomerName, [Total Spending] = SUM(TelevisionPrice * Quantity)
FROM Customer c JOIN SalesTransaction st ON c.CustomerID = st.CustomerID
JOIN SalesTransactionDetail std ON st.SalesTransactionID = std.SalesTransactionID
JOIN Television t ON std.TelevisionID = t.TelevisionID
WHERE c.CustomerName LIKE '%a%' AND TelevisionName LIKE '%LED%'
GROUP BY c.CustomerID, CustomerName

--3
SELECT [StaffName] = SUBSTRING(StaffName, 1, CHARINDEX(' ', StaffName)-1), TelevisionName, [Total Price] = SUM(TelevisionPrice*Quantity)
FROM Staff s JOIN SalesTransaction st ON s.StaffID = st.StaffID
JOIN SalesTransactionDetail std ON st.SalesTransactionID = std.SalesTransactionID
JOIN Television t ON std.TelevisionID = t.TelevisionID
WHERE TelevisionName LIKE '%UHD%'
GROUP BY StaffName, TelevisionName
HAVING COUNT(st.SalesTransactionID) > 2

--4
SELECT 
TelevisionName = UPPER(TelevisionName), 
[Max Television Sold] = CAST(MAX(Quantity) AS VARCHAR) +' Pc(s)',
[Total Television Sold] = CAST(SUM(Quantity) AS VARCHAR) + ' Pc(s)'
FROM Television t JOIN SalesTransactionDetail std ON t.TelevisionID = std.TelevisionID
JOIN SalesTransaction st ON std.SalesTransactionID = st.SalesTransactionID
WHERE TelevisionPrice > 3000000 AND MONTH(st.TransactionDate) > 2 
GROUP BY TelevisionName
ORDER BY SUM(Quantity) ASC

--5
SELECT VendorName, [VendorPhone] = REPLACE(VendorPhoneNumber,'+62', '0'), TelevisionName, [Television Price] = 'Rp. ' + CAST(TelevisionPrice AS VARCHAR)
FROM Vendor v JOIN PurchaseTransaction pt ON v.VendorID = pt.VendorID
JOIN PurchaseTransactionDetail ptd ON pt.PurchaseTransactionID = ptd.PurchaseTransactionID
JOIN Television t ON ptd.TelevisionID = t.TelevisionID,
	(SELECT AvgTvPrice = AVG(TelevisionPrice)
	FROM Vendor v JOIN PurchaseTransaction pt ON v.VendorID = pt.VendorID
	JOIN PurchaseTransactionDetail ptd ON pt.PurchaseTransactionID = ptd.PurchaseTransactionID
	JOIN Television t ON ptd.TelevisionID = t.TelevisionID
	) AS alias
WHERE TelevisionPrice > alias.AvgTvPrice AND VendorName LIKE '% %'

--6
SELECT s.StaffID, StaffName, StaffEmail = SUBSTRING(StaffEmail, 1, CHARINDEX('@', StaffEmail)-1), StaffSalary, CustomerName
FROM Staff s JOIN SalesTransaction st ON s.StaffID = st.StaffID
JOIN Customer c ON st.CustomerID = c.CustomerID,
	(SELECT AvgSalary = AVG(StaffSalary) 
	FROM Staff s JOIN SalesTransaction st ON s.StaffID = st.StaffID
	JOIN Customer c ON st.CustomerID = c.CustomerID
	) AS alias
WHERE StaffSalary > alias.AvgSalary AND CustomerName LIKE '%o%'

--7
SELECT 
TelevisionID = REPLACE(t.TelevisionID, 'TE', 'Television'), 
TelevisionName, 
TelevisionBrand = UPPER(TelevisionBrandName),
[TotalSold] = CAST(SUM(Quantity) AS VARCHAR) + ' Pc(s)'
FROM Television t JOIN TelevisionBrand tb ON t.TelevisionBrandID = tb.TelevisionBrandID
JOIN SalesTransactionDetail std ON t.TelevisionID = std.TelevisionID,
	(SELECT [AvgTotalSold] = AVG(Quantity)
	FROM Television t JOIN TelevisionBrand tb ON t.TelevisionBrandID = tb.TelevisionBrandID
	JOIN SalesTransactionDetail std ON t.TelevisionID = std.TelevisionID) AS alias
WHERE TelevisionName LIKE '%LED%'
GROUP BY t.TelevisionID, TelevisionName, TelevisionBrandName,alias.AvgTotalSold
HAVING SUM(Quantity) > alias.AvgTotalSold
ORDER BY SUM(Quantity) ASC 

--8
SELECT
VendorName, 
VendorEmail, 
VendorPhone =  STUFF(VendorPhoneNumber,1,3,'+62'),
[Total Quantity] = COUNT(Quantity)
FROM Vendor v JOIN PurchaseTransaction pt ON v.VendorID = pt.VendorID
JOIN PurchaseTransactionDetail ptd ON pt.PurchaseTransactionID = ptd.PurchaseTransactionID
JOIN Television t ON ptd.TelevisionID = t.TelevisionID,
	(SELECT [MaxPriceBetween] = MAX(TelevisionPrice)
	FROM Vendor v JOIN PurchaseTransaction pt ON v.VendorID = pt.VendorID
	JOIN PurchaseTransactionDetail ptd ON pt.PurchaseTransactionID = ptd.PurchaseTransactionID
	JOIN Television t ON ptd.TelevisionID = t.TelevisionID
	WHERE MONTH(TransactionDate) BETWEEN 3 AND 6
	) AS alias
WHERE TelevisionPrice > alias.MaxPriceBetween AND VendorName LIKE('% %')
GROUP BY VendorName, VendorEmail,VendorPhoneNumber

SELECT [MaxPriceBetween] = MAX(TelevisionPrice)
	FROM Vendor v JOIN PurchaseTransaction pt ON v.VendorID = pt.VendorID
	JOIN PurchaseTransactionDetail ptd ON pt.PurchaseTransactionID = ptd.PurchaseTransactionID
	JOIN Television t ON ptd.TelevisionID = t.TelevisionID
	WHERE MONTH(TransactionDate) BETWEEN 3 AND 6

--9
CREATE VIEW CustomerTransaction AS
SELECT 
CustomerName, 
CustomerEmail,
[Maximum Quantity Television] = CAST(MAX(Quantity) AS VARCHAR) + ' Pc(s)',
[Minimum Quantity Television] = CAST (MIN(Quantity) AS VARCHAR) + ' Pc(s)'
FROM Customer c JOIN SalesTransaction st ON c.CustomerID = st.CustomerID
JOIN SalesTransactionDetail std ON st.SalesTransactionID = std.SalesTransactionID
WHERE CustomerName LIKE '%b%' 
GROUP BY CustomerName, CustomerEmail
HAVING MAX(Quantity) != MIN(Quantity)

SELECT * FROM CustomerTransaction
DROP VIEW CustomerTransaction

--10
CREATE VIEW StaffTransaction AS
SELECT 
StaffName,
StaffEmail,
[StaffPhone] = StaffPhoneNumber,
[Count Transaction] = COUNT(pt.PurchaseTransactionID),
[Total Television] = SUM(Quantity)
FROM Staff s JOIN PurchaseTransaction pt ON s.StaffID = pt.StaffID
JOIN PurchaseTransactionDetail ptd ON pt.PurchaseTransactionID = ptd.PurchaseTransactionID
WHERE DAY(TransactionDate) > 10 AND StaffEmail LIKE '%@gmail.com'
GROUP BY StaffName, StaffEmail, StaffPhoneNumber

SELECT * FROM StaffTransaction
DROP VIEW StaffTransaction