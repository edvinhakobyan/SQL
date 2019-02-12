USE ShopDB 
GO

DROP TABLE Customers;
GO

CREATE TABLE Customers					
(                                      
	CustomerNO int IDENTITY NOT NULL 
		PRIMARY KEY,				  
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12)
)
GO


-------------------------------------------------------------------------
--                  �������� �������� �����
-------------------------------------------------------------------------
-- FOREIGN KEY (������� ����, ����������� �������� �����)

DROP TABLE Orders;
GO

-- �������� ����� ������� �������� ������� � ������������ FOREIGN KEY 
-- ������ ��������� � ����� �� ��������� �������� � ������������ �������.

CREATE TABLE Orders
( 
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL						      -- ������� �������� ������� ��� ������� ����� FOREIGN KEY                   
    	FOREIGN KEY REFERENCES Customers(CustomerNo), -- ������������ ������� Customers �� ������� CustomerNo.
	OrderDate date NOT NULL,
	Goods varchar(30) NOT NULL 
)
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Petrenko Petr Petrovich', 'Luganskaya 25', 'Konotop', 'PetrPetrenko@mail.ru', '(093)1231212'),
('Ivanenko Ivan Ivanovich', 'Dehtarivska 5', 'Chernigov', 'IvanenkoIvan@gmail.com', '(095)2313244');	

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(1, GETDATE(), 'KeyBoard'),
(2, GETDATE(), 'Mouse'),
(2, GETDATE(), 'WebCam'),
(1, GETDATE(), 'Mouse');

SELECT CustomerNO, CustomerName, Address1, City FROM Customers;
SELECT * FROM Orders;

-- �� ����������� ������ � ��������� ������� (������� � FOREIGN KEY) �������� �������, 
-- �������� �������������� � ��������� ������� (������� � PRIMARY KEY) ������������ �������.

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(3, GETDATE(), 'Mouse'); -- ������! 

DROP TABLE Orders;
GO

-- �������� ����������� �������� ����� �� ������������ �������
CREATE TABLE Orders
(
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL,
	OrderDate date NOT NULL,
	Goods varchar(30) NOT NULL 
)

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo);

DROP TABLE Customers -- ���������� ������� ������� �� ������� ��������� �������� �������.

-- ������� ��������� �������� ������� ����� ���� ��������� ������������ �������.

DROP TABLE Orders;
DROP TABLE Customers;


USE ShopDB 
GO

CREATE TABLE Customers					
(                                      
	CustomerNO int IDENTITY NOT NULL 
		PRIMARY KEY,				  
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12)
)
GO										

CREATE TABLE Orders
(
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL,
	OrderDate date NOT NULL,
	Goods varchar(30) NOT NULL 
)
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo);										
GO

-- �������� ����������� �������� �����. FK_CustomersCustomerNo - ��� �� ���������
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomersCustomerNo;
GO

DROP TABLE Customers; -- ������� Customers �������.
GO