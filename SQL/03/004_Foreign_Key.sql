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
--                  Создание внешнего ключа
-------------------------------------------------------------------------
-- FOREIGN KEY (внешний ключ, ограничение внешнего ключа)

DROP TABLE Orders;
GO

-- Значения ячеек столбца дочерней таблицы с ограничением FOREIGN KEY 
-- должно совпадать с одним из имеющихся значений в родительской таблице.

CREATE TABLE Orders
( 
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL						      -- Столбец дочерней таблицы для которой задан FOREIGN KEY                   
    	FOREIGN KEY REFERENCES Customers(CustomerNo), -- Родительская таблица Customers ее столбец CustomerNo.
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

-- Не допускается запись в ссылаемый столбец (столбец с FOREIGN KEY) дочерней таблици, 
-- значений несуществующих в ссылочном столбце (столбец с PRIMARY KEY) родительской таблицы.

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(3, GETDATE(), 'Mouse'); -- Ошибка! 

DROP TABLE Orders;
GO

-- Создание ограничения внешнего ключа на существующей таблице
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

DROP TABLE Customers -- Невозможно удалить таблицу на которую ссылается дочерняя таблица.

-- Первыми удаляются дочерние таблицы после чего удаляются родительские таблицы.

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

-- Удаление ограничения внешнего ключа. FK_CustomersCustomerNo - имя по умолчанию
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomersCustomerNo;
GO

DROP TABLE Customers; -- Таблица Customers удалена.
GO