USE ShopDB 
GO

-------------------------------------------------------------------------
					 /*Пользовательские ограничения*/
-------------------------------------------------------------------------
	
DROP TABLE Orders;
GO
DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustomerNO int IDENTITY NOT NULL, 
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	-- Пользовательское ограничение	            
	Phone char(12) CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]') 
)
GO

INSERT INTO Customers																			   
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)1231212');

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******'); -- Ошибка.

SELECT * FROM Customers;

DROP TABLE Customers;
GO

CREATE TABLE Customers                
(                                      
	CustomerNO int IDENTITY NOT NULL, 
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12) UNIQUE -- UNIQUE (алтернативный ключ), значение в ячейке должно быть уникальное
)
GO

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******');

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)1231213'); 

SELECT * FROM Customers;

DROP TABLE Customers;
GO

-- Возможно задать сразу несколько ограничений в произвольном порядке 
CREATE TABLE Customers                
(                                      
	CustomerNO int IDENTITY NOT NULL, 
	CustomerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	City     varchar(15) NOT NULL,
	Contact  varchar(25) NOT NULL,
	Phone char(12) UNIQUE CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')		            
)
GO


INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)1231212');

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******'); -- Ошибка (Не соответствие шаблону).

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)1231212'); -- Ошибка (Повторяющееся значение).

SELECT * FROM Customers;

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


-- Создание пользовательского ограничения на существующей таблице	 
ALTER TABLE Customers
ADD CONSTRAINT CN_CustomersPhoneNo 
-- Ограничение CHECK
CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')	 
GO

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)1231212');

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******'); -- Ошибка (Не соответствие шаблону).

-------------------------------------------------------------------------

ALTER TABLE Customers
NOCHECK CONSTRAINT CN_CustomersPhoneNo;		-- Отключение работы ограничения CHECK

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******');

-------------------------------------------------------------------------

ALTER TABLE Customers
CHECK CONSTRAINT CN_CustomersPhoneNo;		--  Включение работы ограничения CHECK


INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******'); -- Ошибка (Не соответствие шаблону).

--------------------------------------------------------------------------
ALTER TABLE Customers
DROP CONSTRAINT	CN_CustomersPhoneNo;		--  Удаление ограничения CHECK

INSERT INTO Customers
(CustomerName, Address1, City, Contact, Phone)
VALUES
('Alex', 'NewSTR', 'City', 'dfgjs@mail.ru', '(093)*******');


--  После удаления не возможен возврат ограничения CHECK
ALTER TABLE Customers
CHECK CONSTRAINT CN_CustomersPhoneNo;		