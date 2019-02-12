USE ShopDB
GO

-------------------------------------------------------------------------
						/* �������� ������� */
-------------------------------------------------------------------------

DROP TABLE Customers; -- DROP TABLE - �������� �������� �������                 
GO

CREATE TABLE Customers                 
(	-- �������� ����� IDENTITY ������� ������� �������������.(seed = 1, step = 2)                                      
	CustomerNo int IDENTITY(1, 2) NOT NULL,  
	CustomerName varchar(25) NOT NULL,   
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) DEFAULT 'Unknown', -- �������� ����� DEFAULT ����������� �������� �� ���������.
	City varchar(15) NOT NULL,
	[State] char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(10) NOT NULL,
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
);
GO

DROP TABLE Customers;
GO

CREATE TABLE Customers                 
(	-- �������� ����� IDENTITY ������� ������� �������������.(seed = 1, step = 2)                                      
	CustomerNo int IDENTITY(1, 2) NOT NULL,  
	CustomerName varchar(25) NOT NULL,   
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) DEFAULT 'Unknown', -- �������� ����� DEFAULT ����������� �������� �� ���������.
	City varchar(15) NOT NULL,
	[State] char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(10) NOT NULL,
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
WITH (DATA_COMPRESSION = ROW); -- ������� � ������� �� ������� (�� �������� � SQL Express)
GO

INSERT INTO Customers 
(CustomerName, Address1, City, [State], Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
('Jeremy', 'new str', 'NewCity', 'ds', 'newZIP', 'newContact', '0567878932', 'NewIDNO', GETDATE());
GO

SELECT * FROM Customers;
GO

-------------------------------------------------------------------------
						/* ��������� ������� */
-------------------------------------------------------------------------

-- �������� ������� Customers, 
-- ������� ������� NewFild

ALTER TABLE Customers -- �������� ALTER TABLE �������� �������
ADD                   -- ADD - ��������� 
NewFild int NULL      -- �������.
GO


SELECT * FROM Customers;
GO

-- �������� ������� Customers, 
-- ������ ������� NewFild		

ALTER TABLE Customers -- �������� ALTER TABLE �������� �������
DROP COLUMN           -- DROP COLUMN - �������
NewFild               -- �������.
GO

SELECT * FROM Customers;
GO

ALTER TABLE Customers 
ADD					 
NewFild2 varchar(10) NOT NULL 
-- ���������� �������� ������� � ������������ NOT NULL �� ��������� �������� �� ���������.
GO

ALTER TABLE Customers 
ADD						
NewFild2 varchar(10) NOT NULL 
DEFAULT 'Unknown'
GO

SELECT * FROM Customers
GO
