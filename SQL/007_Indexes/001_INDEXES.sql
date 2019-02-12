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
numbers int primary key, -- Первичный ключ, добавляет кластеризованый индекс
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
word varchar(25)primary key -- кластеризированный индекс
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
numbers int unique, -- некластеризированный индекс на не упорядоченой таблице (данные хранятся не на листевом уровне дерева)
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
numbers int primary key, -- кластеризированый индекс
word varchar(25)unique   -- некластеризированный индекс на клатеризованной таблице
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

SELECT * FROM BTree where word in ('five', 'one'); -- поиск по некластеризованному индексу
SELECT * FROM BTree where numbers in (3,5);   -- поиск по кластеризованному индексу
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
	CustumerNo int NOT NULL PRIMARY KEY,    -- кластеризованный индекс
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

SELECT * FROM Customers; -- для поиска используем кластеризованный индекс

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
	Phone char(12) UNIQUE, -- некластеризованный индекс
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
	WHERE Phone = '(093)2221212'; -- Для поиска используем некластеризованный
	
-----------------------------------------------------------------------------------------------------------------

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustumerNo int IDENTITY NOT NULL
		PRIMARY KEY,    -- кластеризованный индекс
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) UNIQUE, -- некластеризованный индекс
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem smalldatetime NOT NULL 
)
GO

INSERT INTO Customers
( CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
('Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
('Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE());

SELECT * FROM Customers; -- для поиска используем только кластеризованный индекс

SELECT * FROM Customers			  -- Для поиска используем кластеризованный
	WHERE Phone = '(093)2221212'; -- и не кластеризированный индексы !!!
	
------------------------- Кластеризованный индекс -------------------------------------------------------

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

CREATE CLUSTERED INDEX PK_IND1 -- создание собственного кластеризованного индекса
ON Customers(CustumerNo);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(1,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- CustumerNo = 1 как и в первой строке
GO

SELECT * FROM Customers;-- для поиска используем кластеризованный индекс

-----------------------Кластеризованный индекс -----------------------------------------------------------

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

CREATE UNIQUE CLUSTERED INDEX PK_IND1 -- создание собственного кластеризованного индекса 
ON Customers(CustumerNo);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(1,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- CustumerNo = 1 будет ошибка
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); --CustumerNo должен быть уникальным для каждой строки если CREATE UNIQUE CLUSTERED INDEX
GO

SELECT * FROM Customers; --для поиска используем кластеризованный индекс

------------------ Создание некластеризованного индекса на неупорядоченой таблице -------------------------------------------------

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

CREATE UNIQUE NONCLUSTERED INDEX NC_IND1 -- создание собственного некластеризованного  индекса на неупорядоченной таблице
ON Customers(Phone);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1111111', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2222222', 'qwq2', GETDATE()); --CustumerNo должен быть уникальным для каждой строки если CREATE UNIQUE CLUSTERED INDEX
GO

SELECT * FROM Customers;

SELECT * FROM Customers			  
	WHERE Phone = '(093)2222222'; 
	

----------------Создание некластеризованного индекса на кластеризованной таблице--------------------------------------

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

CREATE UNIQUE CLUSTERED INDEX PK_IND1 -- создание собственного кластеризованного индекса
ON Customers(CustumerNo);
GO

CREATE UNIQUE NONCLUSTERED INDEX NC_IND1 -- создание собственного некластеризованного  индекса на кластеризованной таблице
ON Customers(Phone);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'Alex2', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); --CustumerNo должен быть уникальным для каждой строки если CREATE UNIQUE CLUSTERED INDEX
GO

SELECT * FROM Customers; -- Для поиска используем кластеризованный индекс

SELECT * FROM Customers			  -- Для поиска используем кластеризованный
	WHERE Phone = '(093)2221212'; --  и не кластеризированный индексы !!!
	


-----------------------------------------------------------
        /* Изменения индекса ALTER INDEX */
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

CREATE UNIQUE INDEX PK_IND1 --если включена опция IGNORE_DUP_KEY и нету ограничения UNIQUE будет предупреждение (возможна вставка одинаковых индексов Alex и alex)
ON Customers(CustumerName)
WITH 
(
IGNORE_DUP_KEY = ON -- включаем игнорирование различия между строчными и заглавными
);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'alex', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- Не будет ошибки
GO

SELECT * FROM Customers


ALTER INDEX PK_IND1 -- изменение индекса PK_IND1 
ON Customers		-- заданого на таблице Customers
REBUILD WITH
	(
		IGNORE_DUP_KEY = OFF
	);

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'alex', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- Не будет ошибки
GO

SELECT * FROM Customers;

----------------------------УДАЛЕНИЕ ИНДЕКСОВ---------------------------------------------------------------------
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

CREATE UNIQUE INDEX PK_IND1 -- если включена опция IGNORE_DUP_KEY и нет ограничения UNIQUE будет предупреждения (возможна вставка одинаковых индексов Alex и alex)
ON Customers(CustumerName)
WITH 
(
IGNORE_DUP_KEY = ON -- включаем игнорирование различия между строчными и заглавными символами
);
GO

INSERT INTO Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'qweq', GETDATE()),
(2,'alex', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'qwq2', GETDATE()); -- если включена опция IGNORE_DUP_KEY и есть ограничения UNIQUE данная строка не запишется
GO

SELECT * FROM Customers WHERE CustumerName = 'alex'; -- для поиска используем не кластеризованный индекс

DROP INDEX Customers.PK_IND1;

SELECT * FROM Customers WHERE CustumerName = 'alex'; -- для поиска не используем индекс

