-------------------------------------------------------------------------
--                 Связь Один к Одному
-------------------------------------------------------------------------

USE ShopDB 
GO

DROP TABLE Orders;
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

CREATE TABLE Orders
( 
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL	UNIQUE 
    	FOREIGN KEY REFERENCES Customers(CustomerNo), -- Связь Один к Одному.
	OrderDate date NOT NULL,
	Goods varchar(30) NOT NULL 
)
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
('Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244');	

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(1, GETDATE(), 'KeyBoard'),
(2, GETDATE(), 'Mouse');


SELECT CustomerNO, CustomerName, Address1, City FROM Customers;
SELECT * FROM Orders;

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(2, GETDATE(), 'WebCam'),
(1, GETDATE(), 'Mouse');  -- Ошибка

-------------------------------------------------------------------------
--                 Связь Один ко Многим
-------------------------------------------------------------------------


DROP TABLE Orders;
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

CREATE TABLE Orders
( 
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL						                        
    	FOREIGN KEY REFERENCES Customers(CustomerNo), -- Связь Один ко Многим.
	OrderDate date NOT NULL,
	Goods varchar(30) NOT NULL 
)
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
('Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244');	

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(1, GETDATE(), 'KeyBoard'),
(2, GETDATE(), 'Mouse'),
(2, GETDATE(), 'WebCam'),
(1, GETDATE(), 'Mouse');

SELECT CustomerNO, CustomerName, Address1, City FROM Customers;
SELECT * FROM Orders;

-------------------------------------------------------------------------
--                 Связь Многие ко Многим
-------------------------------------------------------------------------

DROP TABLE Orders;
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

CREATE TABLE Orders
( 
	OrderID int IDENTITY NOT NULL
		PRIMARY KEY,
	CustomerNo int NOT NULL						                        
    	FOREIGN KEY REFERENCES Customers(CustomerNo), -- Связь Один ко Многим.
	OrderDate date NOT NULL,
	Goods varchar(30) NOT NULL 
)
GO

DROP TABLE CreditCards
GO

CREATE TABLE CreditCards
(
	 CardID bigint UNIQUE NOT NULL,
	 CVV int NOT NULL,
	 CustomerNo int NOT NULL
	 FOREIGN KEY REFERENCES Customers(CustomerNo)     -- Связь Один ко Многим.
)

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
('Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244');	

INSERT INTO Orders
(CustomerNo, OrderDate,	Goods)
VALUES
(1, GETDATE(), 'KeyBoard'),
(2, GETDATE(), 'Mouse'),
(2, GETDATE(), 'WebCam'),
(1, GETDATE(), 'Mouse');

INSERT INTO CreditCards
VALUES
(1233431241,232,1),
(2312312349,097,2),
(4323456732,876,2),
(5372168424,937,1),
(7643354521,526,1);


SELECT * FROM Orders;
SELECT CustomerNO, CustomerName, Address1, City FROM Customers;
SELECT * FROM CreditCards;