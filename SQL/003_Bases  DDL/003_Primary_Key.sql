USE ShopDB 
GO

DROP TABLE Customers;
GO

-------------------------------------------------------------------------
--                  �������� ���������� �����
-------------------------------------------------------------------------
-- PRIMARY KEY (��������� ����, ����������� ���������� �����)


-- �������� ����� �������(-��) � ������������ PRIMARY KEY 
-- ���������� ���������� (-��) ������ ������ � �������.

CREATE TABLE Customers					
(                                      
	CustomerNO int NOT NULL PRIMARY KEY, -- �� ������� CustomerNO  ������ ��������� ����
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12)
)
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'�������� ���� ��������', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212'),
(2,'�������� ���� ��������', '������������ 5', '��������', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

-- ������� �������� ������������.
INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'������� ����� ���������', '�������� 12', '�������', 'SemSem@mail.ru', '(063)4533272'); -- ������!

SELECT * FROM Customers;

DROP TABLE Customers;
GO

-- ���� ��������� ���� ������� �� ���� � ����� ��������,
-- ��� �������� ��������� ��������� ������. 
-- ������� �������� ������ ��������� ���� � ������� �������� � ������.
-- ��������� ���� � ������� ����� ���� ������ ���� (������� ��� ���������)
CREATE TABLE Customers                
(                                      
	CustomerNo int NOT NULL,    
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) NOT NULL,
	PRIMARY KEY (CustomerNo, CustomerName) -- ������ ��������� ��������� ���� �� �������� CustomerNo, CustomerName
)
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'�������� ���� ��������', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212'),
(2,'�������� ���� ��������', '������������ 5', '��������', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'������� ����� ���������', '�������� 12', '�������', 'SemSem@mail.ru', '(063)4533272'); 

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(2,'�������� ���� ��������', '������ 32', '����', 'IvanenkoIvan@mail.ru', '(050)1752124'); -- ������!

SELECT * FROM Customers;

-- �������� ����������� ���������� ����� �� ������������ �������
DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustomerNO int IDENTITY NOT NULL, 
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12)             
)
GO

-- �������� �������	Customers ����� ����������� ���������� ����� �� �������	CustomerNo
ALTER TABLE Customers
ADD CONSTRAINT PK_Customers
PRIMARY KEY (CustomerNo)

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('�������� ���� ��������', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212'),
('�������� ���� ��������', '������������ 5', '��������', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

SELECT * FROM Customers;

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustomerNO int NOT NULL, 
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12)             
)
GO

ALTER TABLE Customers
ADD  -- ��� ����������� �� �������� ������������.
PRIMARY KEY (CustomerNo,Address1)

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'�������� ���� ��������', '��������� 25', '�������', 'PetrPetrenko@mail.ru', '(093)1231212'),
(2,'�������� ���� ��������', '������������ 5', '��������', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'������� ����� ���������', '�������� 12', '�������', 'SemSem@mail.ru', '(063)4533272'); 

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(2,'�������� ���� ��������', '������ 32', '����', 'IvanenkoIvan@mail.ru', '(050)1752124'); 

SELECT * FROM Customers;

