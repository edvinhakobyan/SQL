USE ShopDB 
GO

DROP TABLE Customers;
GO

-------------------------------------------------------------------------
--                  Создание первичного ключа
-------------------------------------------------------------------------
-- PRIMARY KEY (первичный ключ, ограничение первичного ключа)


-- Значения ячеек столбца(-ов) с ограничением PRIMARY KEY 
-- однозначно определяет (-ют) каждую строку в таблице.

CREATE TABLE Customers					
(                                      
	CustomerNO int NOT NULL PRIMARY KEY, -- На столбце CustomerNO  задаем первичный ключ
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
(1,'Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
(2,'Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

-- Попытка нарушить уникальность.
INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'Сидоров Семен Семенович', 'Драйзера 12', 'Харьков', 'SemSem@mail.ru', '(063)4533272'); -- Ошибка!

SELECT * FROM Customers;

DROP TABLE Customers;
GO

-- Если первичный ключ состоит из двух и более столбцов,
-- его называют составным первичный ключом. 
-- Попытка вставить второй Первичный ключ в таблицу приводит к ошибке.
-- Первичный ключ в таблице может быть только один (простой или составной)
CREATE TABLE Customers                
(                                      
	CustomerNo int NOT NULL,    
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) NOT NULL,
	PRIMARY KEY (CustomerNo, CustomerName) -- задаем составной первичный ключ на столбцах CustomerNo, CustomerName
)
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
(2,'Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'Сидоров Семен Семенович', 'Драйзера 12', 'Харьков', 'SemSem@mail.ru', '(063)4533272'); 

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(2,'Иваненко Иван Иванович', 'Янгеля 32', 'Киев', 'IvanenkoIvan@mail.ru', '(050)1752124'); -- Ошибка!

SELECT * FROM Customers;

-- Создание ограничения первичного ключа на существующей таблице
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

-- Изменяем таблицу	Customers задав ограничение первичного ключа на столбце	CustomerNo
ALTER TABLE Customers
ADD CONSTRAINT PK_Customers
PRIMARY KEY (CustomerNo)

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
('Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
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
ADD  -- Имя ограничения не является обязательным.
PRIMARY KEY (CustomerNo,Address1)

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'Петренко Петр Петрович', 'Луганская 25', 'Конотоп', 'PetrPetrenko@mail.ru', '(093)1231212'),
(2,'Иваненко Иван Иванович', 'Дихтяревская 5', 'Чернигов', 'IvanenkoIvan@gmail.com', '(095)2313244'); 
GO

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(1,'Сидоров Семен Семенович', 'Драйзера 12', 'Харьков', 'SemSem@mail.ru', '(063)4533272'); 

INSERT INTO Customers																			   
(CustomerNO, CustomerName, Address1, City, Contact, Phone)
VALUES
(2,'Иваненко Иван Иванович', 'Янгеля 32', 'Киев', 'IvanenkoIvan@mail.ru', '(050)1752124'); 

SELECT * FROM Customers;

