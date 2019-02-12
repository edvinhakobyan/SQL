USE master

DROP DATABASE ShopDB;

CREATE DATABASE ShopDB;

USE ShopDB

CREATE TABLE Orders
(
	Customer varchar(200),
	OrderDate date,
	OrderDetails varchar(100),
	Employee varchar(150),
)


INSERT Orders
VALUES
(
 '������� �������� �������; �������, ������ 15; (092)3212211;',
 '2009-12-28',
 'LV231 ������, 45$, 5, 225$; DG30 ������, 30$, 5, 145$; LV12 �����, 26$, 5, 125$;',
 '���� �������� ��������'),
 
 ('������� ��������� ������; ����, ������������ 5; (092)7612343;',
 '2010-09-01',
 'GC11 �����, 32$, 10, 320#$; GC111 ��������, 20$, 15, 300$;',
 '�������� �������� ���������'),
 
 
 ('���� ����������� ��������; ��������, �������� 5; (044)2134212;',
 '2010-09-18',
 'LV12 �����, 26$, 20, 520$; GC11 �����, 32$, 18, 576$;',
 '�������� �������� ���������'
 )


 SELECT * FROM Orders

 -------------------------------------------------------------------------
--								������ ��
-------------------------------------------------------------------------

-- ������ ���������� �����(1NF) � ������������� ���������� ������������� 
-- ����� � �������, � ��� �� ��������� ������� �������� ��������� ������ 
-- � ������ �� ����� ������� ���������  ������. 

DROP TABLE Orders

CREATE TABLE Orders
(
	CustFName varchar(15) NOT NULL,
	CustMName varchar(15) NOT NULL,
	CustLName varchar(15) NOT NULL,
	CustomerCity varchar(15),
	CustomerAddress varchar(25),
	Phone varchar(12) NOT NULL,
	OrderDate date NOT NULL,
	ProductID char(5) NOT NULL,
	ProductDescription varchar(15),
	UnitPrice smallmoney NOT NULL,
	Qty int NOT NULL,
	TotalPrice money,
	EmpFName varchar(15) NOT NULL,
	EmpMName varchar(15) NOT NULL,
	EmpLName varchar(15) NOT NULL,

	CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

INSERT Orders
VALUES
('�������', '��������', '�������', '�������', '������ 15', '(092)3212211',
 '2009-12-28',
 'LV231', '������', 45, 5, 225,
 '����', '��������', '��������'),
  
('�������', '��������', '�������', '�������', '������ 15', '(092)3212211',
 '2009-12-28', 
 'DG30', '������', 30, 5, 145,
 '����', '��������', '��������'),
 
 ('�������', '��������', '�������', '�������', '������ 15', '(092)3212211',
 '2009-12-28', 
 'LV12', '�����', 26, 5, 125,
 '����', '��������', '��������'),
 
 ('�������', '���������', '������', '����', '������������ 5', '(092)7612343',
 '2010-09-01',
 'GC11', '�����', 32, 10, 320, 
 '��������', '��������', '���������'),
 
 ('�������', '���������', '������', '����', '������������ 5', '(092)7612343',
 '2010-09-01',
 'GC111', '��������', 20, 15, 300,
 '��������', '��������', '���������'),

 ('����', '�����������', '��������', '��������', '�������� 5', '(044)2134212',
 '2010-09-18',
 'LV12', '�����', 26, 20, 520, 
 '��������', '��������', '���������'
 ),
 
 ('����', '�����������', '��������', '��������', '�������� 5', '(044)2134212',
 '2010-09-18',
 'GC11', '�����', 32, 18, 576,
 '��������', '��������', '���������'
 )

 SELECT * FROM Orders

-- ����� ��� ��� ���������� � ������������ ������ � ������� ���������� ����� ������� ���������� ���������� ����������� 
-- ��� ������� Orders(���������� ��������� ����)
 
DROP TABLE Orders

CREATE TABLE Orders
(
	OrderID int NOT NULL,
	LineItem int NOT NULL,
	OrderDate date NOT NULL,
	CustFName varchar(15) NOT NULL,
	CustMName varchar(15) NOT NULL,
	CustLName varchar(15) NOT NULL,
	CustomerCity varchar(15),
	CustomerAddress varchar(25),
	Phone varchar(12) NOT NULL,
	ProductID char(5) NOT NULL,
	ProductDescription varchar(15),
	UnitPrice smallmoney NOT NULL,
	Qty int NOT NULL,
	TotalPrice money,
	EmpFName varchar(15) NOT NULL,
	EmpMName varchar(15) NOT NULL,
	EmpLName varchar(15) NOT NULL,

	CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	PRIMARY KEY (OrderId, LineItem)
)

INSERT Orders
VALUES
( 1,1,'2009-12-28',
 '�������', '��������', '�������', '�������', '������ 15', '(092)3212211',
 'LV231', '������', 45, 5, 225,
 '����', '��������', '��������'),
  
( 1,2,'2009-12-28', 
 '�������', '��������', '�������', '�������', '������ 15', '(092)3212211',
 'DG30', '������', 30, 5, 145,
 '����', '��������', '��������'),
 
( 1,3, '2009-12-28', 
 '�������', '��������', '�������', '�������', '������ 15', '(092)3212211',
 'LV12', '�����', 26, 5, 125,
 '����', '��������', '��������'),
 
( 2,1,'2010-09-01',
 '�������', '���������', '������', '����', '������������ 5', '(092)7612343',
 'GC11', '�����', 32, 10, 320, 
 '��������', '��������', '���������'),
 
( 2,2, '2010-09-01',
 '�������', '���������', '������', '����', '������������ 5', '(092)7612343',
 'GC111', '��������', 20, 15, 300,
 '��������', '��������', '���������'),

( 3,1,'2010-09-18',
 '����', '�����������', '��������', '��������', '�������� 5', '(044)2134212',
 'LV12', '�����', 26, 20, 520, 
 '��������', '��������', '���������'
 ),
 
( 3,2, '2010-09-18',
 '����', '�����������', '��������', '��������', '�������� 5', '(044)2134212',
 'GC11', '�����', 32, 18, 576,
 '��������', '��������', '���������'
 )

SELECT * FROM Orders

-------------------------------------------------------------------------
--								������ ��
-------------------------------------------------------------------------

-- ������ ���������� �����(2NF) � ������������� ������ ���������� �����, 
-- � ������ �������  ������ �������� �� ����� �����.

-- � ������� Orders d�� ���� ����� ProductID, ProductDescription, UnitPrice, Qty, TotalPrice ������� �� �� ����� �����.

DROP TABLE Orders
DROP TABLE Employees
DROP TABLE Customers
DROP TABLE OrderDetails

CREATE TABLE Employees
	(
		EmployeeID int NOT NULL IDENTITY 
			PRIMARY KEY,
		FName nvarchar(15) NOT NULL,
		LName nvarchar(15) NOT NULL,
		MName nvarchar(15) NOT NULL,
		Salary money NOT NULL,
		PriorSalary money NOT NULL,
		HireDate date NOT NULL,
		TerminationDate date NULL,
		ManagerEmpID int NULL
	)  
GO

CREATE TABLE Customers
	(
	CustomerNo int NOT NULL IDENTITY
		PRIMARY KEY,
	FName nvarchar(15) NOT NULL,
	LName nvarchar(15) NOT NULL,
	MName nvarchar(15) NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL UNIQUE,
	DateInSystem date NULL,

	CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	)  
GO

CREATE TABLE Orders
(
	OrderID int NOT NULL IDENTITY PRIMARY KEY,
	OrderDate date NOT NULL,
	CustomerNo int,
	EmployeeID int,

	FOREIGN KEY(CustomerNo) REFERENCES Customers(CustomerNo),
	FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID),
)

CREATE TABLE OrderDetails
(
	OrderID int NOT NULL,
	LineItem int NOT NULL,
	ProductID char(5) NOT NULL,
	ProductDescription varchar(15),
	UnitPrice smallmoney NOT NULL,
	Qty int NOT NULL,
	TotalPrice as Qty * UnitPrice,

    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
	PRIMARY KEY (OrderId, LineItem)
)

INSERT Employees
(FName, MName, LName, Salary, PriorSalary, HireDate, TerminationDate, ManagerEmpID)
VALUES
('�������', '��������', '�������', 5000, 800, '11/20/2009', NULL, NULL),
('����', '��������', '��������', 2000, 0, '11/20/2009', NULL, 1),
('����', '�����������', '�������', 1000, 0, '11/20/2009', NULL, 2),
('��������', '��������', '���������', 800, 0, '11/20/2009', NULL, 2);
GO

INSERT Customers 
(LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
('����������','��������','��������','������ 15',NULL,'�������','(092)3212211','11/20/2009'),
('������','������','����������','��������� 10',NULL,'����','(067)4242132','08/03/2010'),
('������','�������','���������','������������ 5',NULL,'����','(092)7612343','08/17/2010'),
('��������','�������','����������','�������� 5','�������� 12','����','(053)3456788','08/20/2010'),
('��������','����','�����������','�������� 3','�������� 8','��������','(044)2134212','09/18/2010');
GO

INSERT Orders
VALUES
( '2009-12-28', 1, 2),
( '2010-09-01', 3, 4),
( '2010-09-18', 5, 4)

INSERT OrderDetails
VALUES
( 1, 1, 'LV231', '������', 45, 5 ),
( 1, 2, 'DG30', '������', 30, 5 ),
( 1, 3, 'LV12', '�����', 26, 5 ),
( 2, 1, 'GC11', '�����', 32, 10 ),
( 2, 2, 'GC111', '��������', 20, 15 ),
( 3, 1, 'LV12', '�����', 26, 20 ),
( 3, 2, 'GC11', '�����', 32, 18 )


SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM OrderDetails

-------------------------------------------------------------------------
--								������ ��
-------------------------------------------------------------------------

-- ������ ���������� �����(3NF) � ������������� 2NF, � �� � ����� �� 
-- �������� ������� �� ����� ���� ����������� �� ������� �� ��������� 
-- �������. ������� � ������� ����������� ������ �� �����������.

DROP TABLE OrderDetails
DROP TABLE Products

CREATE TABLE Products
(
	ProductID char(5) NOT NULL PRIMARY KEY,
	[Description] varchar(15),
	UnitPrice smallmoney NOT NULL,
	[Weight] numeric(18, 0) NULL
)


CREATE TABLE OrderDetails
(
	OrderID int NOT NULL,
	LineItem int NOT NULL,
	ProductID char(5) NOT NULL,
	Qty int NOT NULL,

    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY(ProductID) REFERENCES Products(ProductID),
	PRIMARY KEY (OrderId, LineItem)
)

INSERT Products
VALUES
( 'LV231', '������', 45, 2),
( 'DG30', '������', 30,  1),
( 'GC111', '��������', 20,  2),
( 'LV12', '�����', 26,  2),
( 'GC11', '�����', 32,  1)


INSERT OrderDetails
VALUES
( 1, 1, 'LV231', 5 ),
( 1, 2, 'DG30', 5 ),
( 1, 3, 'LV12', 5 ),
( 2, 1, 'GC11', 10 ),
( 2, 2, 'GC111', 15 ),
( 3, 1, 'LV12', 20 ),
( 3, 2, 'GC11', 18 )


SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM Products

-------------------------------------------------------------------------
--							��������������
-------------------------------------------------------------------------

-- �������������� � ������� ��������� ���������� �����. 
-- �������������� ���� ����������� ������ ����� �������� 
-- � ��������� ������������� �������������

DROP TABLE OrderDetails

CREATE TABLE OrderDetails
(
	OrderID int NOT NULL,
	LineItem int NOT NULL,
	ProductID char(5) NOT NULL,
	Qty int NOT NULL,
	TotalPrice money,

    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY(ProductID) REFERENCES Products(ProductID),
	PRIMARY KEY (OrderId, LineItem)
)


INSERT OrderDetails
VALUES
( 1, 12, 'LV231', 5, 5 * (select UnitPrice FROM Products where ProductID = 'LV231')),
( 1, 2, 'DG30', 5, 5 * (select UnitPrice FROM Products where ProductID = 'DG30')),
( 1, 3, 'LV12', 5, 5 * (select UnitPrice FROM Products where ProductID = 'LV12')),
( 2, 1, 'GC11', 10, 10 * (select UnitPrice FROM Products where ProductID = 'GC11') ),
( 2, 2, 'GC111', 15, 15 * (select UnitPrice FROM Products where ProductID = 'GC111') ),
( 3, 1, 'LV12', 20, 20 * (select UnitPrice FROM Products where ProductID = 'LV12') ),
( 3, 2, 'GC11', 18, 18 * (select UnitPrice FROM Products where ProductID = 'GC11') )


SELECT * FROM OrderDetails 