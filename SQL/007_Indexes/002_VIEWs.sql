USE ShopDB
GO
-- Представления это способ вывода ограниченного набора столбцов из реальной таблицы в виде виртуальной таблицы. 
DROP TABLE InfoPerson
GO

CREATE TABLE InfoPerson
(
	FirstName nvarchar(50) null,
	LastName nvarchar(50)null,
	BirthDate date null,
	AddressLine1 nvarchar(50)  null,
	AddressLine2 nvarchar(50) null,
	EmailAddress nvarchar(50) null,
)
GO

INSERT InfoPerson  -- пререносим данные из одной таблицы в другую
SELECT pc.FirstName, pc.LastName, CAST(he.BirthDate as DATE), pa.AddressLine1, pa.AddressLine2, pea.EmailAddress
		FROM AdventureWorks2012.Person.Person as pc  -- базаДанных.Схема.Таблица AS алиас
		 JOIN AdventureWorks2012.HumanResources.Employee as he 
			ON pc.BusinessEntityID = he.BusinessEntityID
		 JOIN AdventureWorks2012.Person.BusinessEntityAddress as hea 
			ON he.BusinessEntityID = hea.BusinessEntityID
		 JOIN AdventureWorks2012.Person.Address as pa 
			ON hea.AddressID = pa.AddressID
		 JOIN AdventureWorks2012.Person.EmailAddress as pea
			ON pea.BusinessEntityID = pc.BusinessEntityID
GO

SELECT * FROM InfoPerson;
GO
-----------------------------------------------------------
        /* Создание представления - CREATE VIEW */
-----------------------------------------------------------

CREATE VIEW BthPerson   -- Создание представления
AS SELECT FirstName, LastName, BirthDate, EmailAddress
FROM InfoPerson;
GO

SELECT * FROM BthPerson; -- выборка из представления

SELECT * FROM InfoPerson; -- выборка из таблицы
GO

------------------------------------------------------------

CREATE VIEW BthPerson2  
WITH SCHEMABINDING     -- Запрещает удаление таблицы для которой создано представление.
AS SELECT FirstName, LastName, BirthDate, EmailAddress
FROM dbo.InfoPerson;   -- Двухкомпонентная структура имени таблицы с которой связано представление.
GO

SELECT * FROM BthPerson2;
DROP TABLE InfoPerson; -- Будет ошибка.
GO

------------------------------------------------------------

CREATE VIEW BthPrsn2Addres   -- Создаем представление для выборки данных по условию.
AS SELECT FirstName, LastName, BirthDate, AddressLine1, AddressLine2
FROM InfoPerson
WHERE AddressLine2 is not null; -- Представление будет выводить информацию о тех людях которые имеют 2 адреса
GO

SELECT * FROM BthPrsn2Addres; -- выборка из представления

SELECT FirstName, LastName, BirthDate, AddressLine1 FROM BthPrsn2Addres; -- как и при выборке из таблицы можно задавать определенный набор столбоцов для вывода
GO


-- Вместо таблицы InfoPerson, в которую записана информация из других таблиц 
-- можно создать представление, при этом будет сэкономленна физическая память базы данных.

CREATE VIEW InfoPerson2 AS 
SELECT pc.FirstName, pc.LastName, he.BirthDate, pa.AddressLine1, pa.AddressLine2, pea.EmailAddress
		FROM AdventureWorks2012.Person.Person as pc  -- базаДанных.Схема.Таблица AS алиас
		 JOIN AdventureWorks2012.HumanResources.Employee as he 
			ON pc.BusinessEntityID = he.BusinessEntityID
		 JOIN AdventureWorks2012.Person.BusinessEntityAddress as hea 
			ON he.BusinessEntityID = hea.BusinessEntityID
		 JOIN AdventureWorks2012.Person.Address as pa 
			ON hea.AddressID = pa.AddressID
		 JOIN AdventureWorks2012.Person.EmailAddress as pea
			ON pea.BusinessEntityID = pc.BusinessEntityID
			
SELECT * FROM InfoPerson;

SELECT * FROM InfoPerson2;


-------------- Вставка данных с помощю представления.
SELECT * FROM BthPerson;

INSERT INTO BthPerson 
(BirthDate, EmailAddress, FirstName, LastName)
VALUES 
('02/03/1990', 'adgkj@mail.ru', 'Andrew', 'Test1');

-- Выборка из представления.
SELECT * FROM BthPerson WHERE LastName = 'Test1';

-- Выборка из таблицы.
-- На самом деле данные записались в таблицу InfoPerson.
SELECT * FROM InfoPerson WHERE LastName = 'Test1';

------------------------------------------------------------
	
-- Обновление данных с помощью представления.

UPDATE BthPerson 
	SET EmailAddress = 'testmail1@mail.ru'
	WHERE LastName = 'Test1';
	
SELECT * FROM BthPerson 
	WHERE LastName = 'Test1';
	
SELECT * FROM InfoPerson
	WHERE LastName = 'Test1';

-- Так же данные возможно обновлять и в таблице
UPDATE InfoPerson
SET EmailAddress = 'testmail2@mail.ru'
	WHERE LastName='Test1';
	
SELECT * FROM BthPerson 
	WHERE LastName='Test1';
	
SELECT * FROM InfoPerson
	WHERE LastName='Test1';
	
-----------------------ИЗМЕНЕНИЕ ПРЕДСТАВЛЕНИЙ--------------

SELECT * FROM BthPerson;

ALTER VIEW BthPerson  -- Изменение представления.
AS  SELECT FirstName, LastName, BirthDate, EmailAddress , AddressLine1
FROM InfoPerson;
GO

SELECT * FROM BthPerson;	

----------------------- УДАЛЕНИЕ ПРЕДСТАВЛЕНИЙ ---------------

DROP VIEW BthPerson;

-- Представления больше нет.
SELECT * FROM BthPerson 
	WHERE LastName = 'Test1';
	
-- Данные которые добавлялись через представление остаются в таблице.
SELECT * FROM InfoPerson
	WHERE LastName = 'Test1';
