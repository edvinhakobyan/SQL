USE ShopDB 
GO

DROP TABLE Customers;

DROP TABLE Orders;

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
	CustomerNo int NULL DEFAULT 2 ,
	OrderDate date NOT NULL,
	EmployeeId int NULL 
)
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo);

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Petrenko Petr Petrovich', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212'),
('Ivanenko Ivan Ivanovich', '������������ 5', '��������', 'IvanenkoIvan@gmail.com', '(095)2313244');	

INSERT INTO Orders
(CustomerNo, OrderDate,	EmployeeId)
VALUES
(1, GETDATE(), 1);

SELECT * FROM Customers;
SELECT * FROM Orders;

-- ���������� ������� ������ �� ������������ �������, ��� ��� �� ��� ������� ������ �� �������� �������.
DELETE Customers
WHERE CustomerName = 'Petrenko Petr Petrovich';

-------------------------------------------------------------------------
--              ����������� ��������� �����������
-------------------------------------------------------------------------

-- � ������� ����������� ��������� ����������� (ON DELETE, ON UPDATE) 
-- ����� ���������� ��������, ������� SQL Server ����� �����������
-- ��� �������� �������� �������, ����� ������������ ����������
-- ������� ��� �������� �������� ������� ������������ �������.

-- ��������:

-- 1. CASCADE -	��� UPDATE, DELETE � ������������ ������� ��������� ��������,
--				� �������� ������� ����� �����������  UPDATE �� ����� ��������, 
--				��� DELETE	����� �� �������� ������� ��������������
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomersCustomerNo;
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo)
	ON DELETE CASCADE 
GO

DELETE Customers
WHERE CustomerName = 'Petrenko Petr Petrovich';

SELECT * FROM Customers;
SELECT * FROM Orders;

DBCC CHECKIDENT("Customers",RESEED,0); -- ���������� �������� IDENTITY = 0
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('�������� ���� ��������', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212')

DBCC CHECKIDENT("Customers",RESEED,2) -- ���������� �������� IDENTITY = 2
GO
DBCC CHECKIDENT("Orders",RESEED,0); -- ���������� �������� IDENTITY = 0
GO

INSERT INTO Orders
(CustomerNo, OrderDate,	EmployeeId)
VALUES (1,GETDATE(),1);
GO

SELECT * FROM Customers;
SELECT * FROM Orders;

-- 2. SET NULL - ��� UPDATE, DELETE � ������������ ������� ��������� ��������,
--				 � �������� ������� ��� ��������, ������������ ��� ������� �����, 
--				 ����� �������� �� NULL

ALTER TABLE Orders
DROP CONSTRAINT FK_CustomersCustomerNo;
GO
 
ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo)
	ON DELETE SET NULL 
GO

DELETE Customers
WHERE CustomerName = '�������� ���� ��������';
GO

SELECT * FROM Customers;
SELECT * FROM Orders;

DBCC CHECKIDENT("Customers",RESEED,0); -- ���������� �������� IDENTITY = 0
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Petrenko Petr Petrovich', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212')

DBCC CHECKIDENT("Customers",RESEED,2) -- ���������� �������� IDENTITY = 2
GO

DELETE Orders WHERE OrderID = 1;
GO

DBCC CHECKIDENT("Orders",RESEED,0); -- ���������� �������� IDENTITY = 0
GO

INSERT INTO Orders
(CustomerNo, OrderDate,	EmployeeId)
VALUES (1,GETDATE(),1);
GO

SELECT * FROM Customers;
SELECT * FROM Orders;

-- 3. SET DEFAULT - ��� UPDATE, DELETE � ������������ ������� ��������� ��������,
--					� �������� ������� ��� ��������, ������������ ��� ������� �����, 
--					����� �������� �� �������� �� ���������.
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomersCustomerNo;
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo)
	ON DELETE SET DEFAULT  
GO

DELETE Customers
WHERE CustomerName = 'Petrenko Petr Petrovich';
GO

SELECT * FROM Customers;
SELECT * FROM Orders;

DBCC CHECKIDENT("Customers",RESEED,0); -- ���������� �������� IDENTITY = 0
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Petrenko Petr Petrovich', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212')

DBCC CHECKIDENT("Customers",RESEED,2) -- ���������� �������� IDENTITY = 2
GO

DELETE Orders WHERE OrderID = 1;
GO

DBCC CHECKIDENT("Orders",RESEED,0); -- ���������� �������� IDENTITY = 0
GO

INSERT INTO Orders
(CustomerNo, OrderDate,	EmployeeId)
VALUES (1,GETDATE(),1);
GO

SELECT * FROM Customers;
SELECT * FROM Orders;

-- 4. NO ACTION (�� ���������) - ��������� ���������� UPDATE, DELETE!
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomersCustomerNo;
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomersCustomerNo
FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo)
	ON DELETE NO ACTION 
GO

DELETE Customers
WHERE CustomerName = 'Petrenko Petr Petrovich';

SELECT * FROM Customers;
SELECT * FROM Orders;