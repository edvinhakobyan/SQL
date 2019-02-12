USE ShopDB
GO

DROP TABLE BTree;
GO

CREATE TABLE BTree
(
numbers int ,
word varchar(25)
)
GO

INSERT BTree
VALUES
(1,'one'),
(2,'two'),
(3,'three'),
(4,'four'),
(6,'six'),
(7,'seven'),
(8,'eight'),
(9,'nine');

SELECT * FROM BTree;

INSERT BTree
VALUES (5,'five');

SELECT * FROM BTree WHERE numbers IN (5,6);
--------------------------------------------------

DROP TABLE BTree;
GO

CREATE TABLE BTree
(
numbers int primary key, -- ��������� ����, ��������� ��������������� ������
word varchar(25)
)
--SET STATISTICS IO ON
INSERT BTree
VALUES
(1,'one'),
(2,'two'),
(3,'three'),
(4,'four'),
(6,'six'),
(7,'seven'),
(8,'eight'),
(9,'nine');

SELECT * FROM BTree WHERE word = 'one';

SELECT * FROM sys.indexes
WHERE object_id = (SELECT object_id FROM sys.tables
				   WHERE name = 'BTree')

INSERT BTree
VALUES (5,'five');

SELECT * FROM BTree;

--------------------------------------------------

DROP TABLE BTree;
GO

CREATE TABLE BTree
(
numbers int ,
word varchar(25)primary key -- ������������������ ������
)

INSERT BTree
VALUES
(1,'one'),
(2,'two'),
(3,'three'),
(4,'four'),
(6,'six'),
(7,'seven'),
(8,'eight'),
(9,'nine');

SELECT * FROM BTree;

INSERT BTree
VALUES (5,'five');

SELECT * FROM BTree;

--------------------------------------------------

DROP TABLE BTree;
GO

CREATE TABLE BTree
(
numbers int unique, -- �������������������� ������ �� �� ������������ ������� (������ �������� �� �� �������� ������ ������)
word varchar(25)
)

INSERT BTree
VALUES
(1,'one'),
(2,'two'),
(3,'three'),
(4,'four'),
(6,'six'),
(7,'seven'),
(8,'eight'),
(9,'nine');

SELECT * FROM BTree;

INSERT BTree
VALUES (5,'five');

SELECT * FROM BTree where word = 'one';

--------------------------------------------------

DROP TABLE BTree;
GO

CREATE TABLE BTree
(
numbers int primary key, -- ����������������� ������
word varchar(25)unique   -- �������������������� ������ �� ��������������� �������
)

INSERT BTree
VALUES
(1,'one'),
(2,'two'),
(3,'three'),
(4,'four'),
(6,'six'),
(7,'seven'),
(8,'eight'),
(9,'nine');

SELECT * FROM BTree;

INSERT BTree
VALUES (5,'five');

SELECT * FROM BTree where word in ('five', 'one'); -- ����� �� ������������������� �������
SELECT * FROM BTree where numbers in (3,5);   -- ����� �� ����������������� �������
--------------------------------------------------
DROP TABLE OrderDetails;
GO
DROP TABLE Orders;
GO
DROP TABLE Customers
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE());
GO

SELECT * FROM Customers;

-----------------------------------------------------------------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL PRIMARY KEY,    -- ���������������� ������
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE());

SELECT * FROM Customers; -- ��� ������ ���������� ���������������� ������

-----------------------------------------------------------------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) UNIQUE, -- ������������������ ������
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE());
GO

SELECT * FROM Customers;

SELECT Phone FROM Customers			  
	WHERE Phone = '(093)2221212'; -- ��� ������ ���������� ������������������
	
-----------------------------------------------------------------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int IDENTITY NOT NULL
		PRIMARY KEY,    -- ���������������� ������
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) UNIQUE, -- ������������������ ������
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

INSERT INTO Customers
( CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
('Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
('Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE());

SELECT * FROM Customers; -- ��� ������ ���������� ������ ���������������� ������

SELECT * FROM Customers			  -- ��� ������ ���������� ����������������
	WHERE Phone = '(093)2221212'; -- � �� ������������������ ������� !!!
	
------------------------- ���������������� ������ -------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

CREATE CLUSTERED INDEX PK_IND1 -- �������� ������������ ����������������� �������
ON Customers(CustumerNo);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(1,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- CustumerNo = 1 ��� � � ������ ������
GO

SELECT * FROM Customers;-- ��� ������ ���������� ���������������� ������

-----------------------���������������� ������ -----------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers               
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) Primary key,
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

CREATE UNIQUE CLUSTERED INDEX PK_IND1 -- �������� ������������ ����������������� ������� 
ON Customers(CustumerNo);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(1,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- CustumerNo = 1 ����� ������
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); --CustumerNo ������ ���� ���������� ��� ������ ������ ���� CREATE UNIQUE CLUSTERED INDEX
GO

SELECT * FROM Customers; --��� ������ ���������� ���������������� ������

------------------ �������� ������������������� ������� �� �������������� ������� -------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

CREATE UNIQUE NONCLUSTERED INDEX NC_IND1 -- �������� ������������ �������������������  ������� �� ��������������� �������
ON Customers(Phone);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1111111', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2222222', 'qwq2', GETDATE()); --CustumerNo ������ ���� ���������� ��� ������ ������ ���� CREATE UNIQUE CLUSTERED INDEX
GO

SELECT * FROM Customers;

SELECT * FROM Customers			  
	WHERE Phone = '(093)2222222'; 
	

----------------�������� ������������������� ������� �� ���������������� �������--------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

CREATE UNIQUE CLUSTERED INDEX PK_IND1 -- �������� ������������ ����������������� �������
ON Customers(CustumerNo);
GO

CREATE UNIQUE NONCLUSTERED INDEX NC_IND1 -- �������� ������������ �������������������  ������� �� ���������������� �������
ON Customers(Phone);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); --CustumerNo ������ ���� ���������� ��� ������ ������ ���� CREATE UNIQUE CLUSTERED INDEX
GO

SELECT * FROM Customers; -- ��� ������ ���������� ���������������� ������

SELECT * FROM Customers			  -- ��� ������ ���������� ����������������
	WHERE Phone = '(093)2221212'; --  � �� ������������������ ������� !!!
	


-----------------------------------------------------------
        /* ��������� ������� ALTER INDEX */
-----------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

CREATE UNIQUE INDEX PK_IND1 --���� �������� ����� IGNORE_DUP_KEY � ���� ����������� UNIQUE ����� �������������� (�������� ������� ���������� �������� Alex � alex)
ON Customers(CustumerName)
WITH 
(
IGNORE_DUP_KEY = ON -- �������� ������������� �������� ����� ��������� � ����������
);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'alex', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- �� ����� ������
GO

SELECT * FROM Customers


ALTER INDEX PK_IND1 -- ��������� ������� PK_IND1 
ON Customers		-- �������� �� ������� Customers
REBUILD WITH
	(
		IGNORE_DUP_KEY = OFF
	);

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'alex', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- �� ����� ������
GO

SELECT * FROM Customers;

----------------------------�������� ��������---------------------------------------------------------------------
DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

CREATE UNIQUE INDEX PK_IND1 -- ���� �������� ����� IGNORE_DUP_KEY � ��� ����������� UNIQUE ����� �������������� (�������� ������� ���������� �������� Alex � alex)
ON Customers(CustumerName)
WITH 
(
IGNORE_DUP_KEY = ON -- �������� ������������� �������� ����� ��������� � ���������� ���������
);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'alex', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- ���� �������� ����� IGNORE_DUP_KEY � ���� ����������� UNIQUE ������ ������ �� ���������
GO

SELECT * FROM Customers WHERE CustumerName = 'alex'; -- ��� ������ ���������� �� ���������������� ������

DROP INDEX Customers.PK_IND1;

SELECT * FROM Customers WHERE CustumerName = 'alex'; -- ��� ������ �� ���������� ������

