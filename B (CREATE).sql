CREATE DATABASE ENTV
GO
USE ENTV
GO

CREATE TABLE Staff(
	StaffID CHAR(5) PRIMARY KEY CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(255),
	StaffEmail VARCHAR(255) CHECK(StaffEmail LIKE '%@yahoo.com' OR StaffEmail LIKE '%gmail.com'),
	StaffGender VARCHAR(6) CHECK(StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),
	StaffPhoneNumber CHAR(14) CHECK(StaffPhoneNumber LIKE '+62%'),
	StaffAddress VARCHAR(255),
	StaffSalary INT,
	StaffDOB DATE CHECK(YEAR(StaffDOB) <= 2000)
);


CREATE TABLE Customer(
	CustomerID CHAR(5) PRIMARY KEY CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(255) CHECK(LEN(CustomerName) >= 3),
	CustomerEmail VARCHAR(255) CHECK(CustomerEmail LIKE '%@yahoo.com' OR CustomerEmail LIKE '%gmail.com'),
	CustomerGender VARCHAR(255) CHECK(CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female'),
	CustomerPhoneNumber VARCHAR(14) CHECK(CustomerPhoneNumber LIKE '+62%'),
	CustomerAddress VARCHAR(255),
	CustomerDOB DATE
);


CREATE TABLE Vendor(
	VendorID CHAR(5) PRIMARY KEY CHECK(VendorID LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(255) CHECK(LEN(VendorName) > 3),
	VendorEmail VARCHAR(255),
	VendorPhoneNumber CHAR(14),
	VendorAddress VARCHAR(255)
);

CREATE TABLE TelevisionBrand(
	TelevisionBrandID CHAR(5) PRIMARY KEY CHECK(TelevisionBrandID LIKE 'TB[0-9][0-9][0-9]'),
	TelevisionBrandName VARCHAR(255)
);

CREATE TABLE Television(
	TelevisionID CHAR(5) PRIMARY KEY CHECK(TelevisionID LIKE 'TE[0-9][0-9][0-9]'),
	TelevisionBrandID CHAR(5) FOREIGN KEY REFERENCES TelevisionBrand(TelevisionBrandID),
	TelevisionName VARCHAR(255),
	TelevisionPrice INT CHECK(TelevisionPrice BETWEEN 1000000 AND 20000000)
);


CREATE TABLE PurchaseTransaction(
	PurchaseTransactionID CHAR(5) PRIMARY KEY CHECK(PurchaseTransactionID LIKE 'PE[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID),
	VendorID CHAR(5) FOREIGN KEY REFERENCES Vendor(VendorID),
	TransactionDate DATE
);

CREATE TABLE PurchaseTransactionDetail(
	PurchaseTransactionID CHAR(5) FOREIGN KEY REFERENCES PurchaseTransaction(PurchaseTransactionID),
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES Television(TelevisionID),
	Quantity INT,
	PRIMARY KEY(PurchaseTransactionID, TelevisionID)
);

CREATE TABLE SalesTransaction(
	SalesTransactionID CHAR(5) PRIMARY KEY CHECK(SalesTransactionID LIKE 'SA[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID),
	CustomerID CHAR(5) FOREIGN KEY REFERENCES Customer(CustomerID),
	TransactionDate DATE,
);

CREATE TABLE SalesTransactionDetail(
	SalesTransactionID CHAR(5) FOREIGN KEY REFERENCES SalesTransaction(SalesTransactionID),
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES Television(TelevisionID),
	Quantity INT,
	PRIMARY KEY(SalesTransactionID, TelevisionID)
);

SELECT * FROM Staff
SELECT * FROM PurchaseTransaction
SELECT * FROM PurchaseTransactionDetail
SELECT * FROM SalesTransaction
SELECT * FROM SalesTransactionDetail
SELECT * FROM Television
SELECT * FROM TelevisionBrand
SELECT * FROM Customer
SELECT * FROM Vendor

