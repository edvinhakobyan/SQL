/*Пользовательские функции возвращаемые скалярное значение (не табличное)*/
USE ShopDB
GO

CREATE FUNCTION Hello() -- создать функцию
RETURNS varchar(30)     -- обьявляем тип возвращаемого значения
AS
BEGIN --начало тела ф-ции
DECLARE @MyVar varchar(20) ='Hello World!';
RETURN @MyVar; --возвращаемое значение ф-ции
END; -- конец тела ф-ции
GO

PRINT dbo.Hello();

DROP TABLE TestTable;
GO

CREATE TABLE TestTable
(
	id int identity not null,
	name varchar(25) not null,
	CDate smalldatetime not null
)
GO

-------------------------------------------------------

DECLARE @MyVar int =1;
DECLARE @MyVcVar varchar(10);

WHILE @MyVar < 20
BEGIN
	SET @MyVcVar = 'Test ' + CAST(@MyVar as varchar);
	-- заносим данные в таблицу
	INSERT TestTable
	( name, CDate )
	VALUES (@MyVcVar, DATEADD(MI, @MyVar, GETDATE()));
	
	SET @MyVar = @MyVar + 1;
END
GO

/* данная выборка будет пустая, так как функция GETDATE() 
 возвращает значение типа datetime (возвращает не только 
 дату но и текущее время до 3-х сотых секунды)*/
SELECT * FROM TestTable
WHERE CDate = GETDATE(); 
GO
---------------------------------------------------------

CREATE FUNCTION DateOnly (@Date datetime) -- создаем функцию вводя ее имя и аргумент
RETURNS date --обявляем возвращаемый тип
AS
BEGIN --тело функции
 RETURN CAST(@Date as date); -- приводим к типу date возвращаемое значение
END
GO

SELECT * FROM TestTable -- данная выборка вернет 19 записей(все за сегодняшний день
WHERE dbo.DateOnly(CDate)= dbo.DateOnly(GETDATE()); --нужно явно указывать схему при вызове пользовательской функции
----------------------------------------
USE AdventureWorks2012
GO

/* Делаем выбоку для просмотра цены каждого горного велосипеда,
в данной выборке используются запросы внутри запросов их назы-
вают вложеными запросами*/

SELECT	Name,
		ListPrice,
		(SELECT AVG(ListPrice) FROM Production.Product WHERE ProductSubcategoryID = 1) as Average, -- используем вложеный запрос, мы помним что функция AVG - возвращаемая среднее значение
		ListPrice - (SELECT AVG(ListPrice) FROM Production.Product WHERE ProductSubcategoryID = 1) as DifferencePrice
FROM Production.Product 
WHERE ProductSubcategoryID = 1; -- делаем выборку для Mountain Bikers
GO

DROP FUNCTION AvgPrice
DROP FUNCTION DfrncPrice
GO

-- вложенный запрос (SELECT AVG(ListPrice)FROM Production.Product) можно оформить в виде функции, 
-- так как он возвращает выборку из одного значения
CREATE FUNCTION AvgPrice()
RETURNS money
WITH SCHEMABINDING    -- Запрещает удаление таблицы.
AS
BEGIN
	RETURN (SELECT AVG(ListPrice)FROM Production.Product WHERE ProductSubcategoryID = 1);
END
GO

--- использование вложенных функций
CREATE FUNCTION DfrncPrice(@Price money)
RETURNS money
AS
BEGIN
	RETURN @Price - dbo.AvgPrice(); -- возможно создавать вложенные функции
END;
GO

-- выполним тот же запрос для просмотра цены каждого горного велосипеда
SELECT  Name,
		ListPrice,
		dbo.AvgPrice() as AvgPrice,
		dbo.DfrncPrice(ListPrice) as DifferencePrice
FROM Production.Product
WHERE ProductSubcategoryID = 1;
GO

/*Пользвательские функции возвращемые таблицу*/

USE AdventureWorks2012;
GO

DROP FUNCTION fnContactList

CREATE FUNCTION fnContactList() -- создаем функцию
RETURNS TABLE -- возвращаемый тип TABLE указывает на то что возвращаться будет таблица
AS
RETURN (SELECT LastName, FirstName, ModifiedDate 
		FROM Person.Person); 
GO

SELECT * FROM dbo.fnContactList(); -- выводим всю информацию из таблицы сформированой при помощи функции fnContactList();
GO

--ЗАДАНИЕ: повторите предыдущий пример с помощью представления

DROP FUNCTION fnContactSearch

CREATE FUNCTION fnContactSearch(@LastName varchar(30)) --передаем один аргумент типа varchar (Фамилия или часть фамилии)
RETURNS TABLE
AS
RETURN (SELECT FirstName , LastName, ModifiedDate 
		FROM Person.Person
		WHERE LastName LIKE @LastName + '%'); -- выборка по фамилии
GO

SELECT * FROM dbo.fnContactSearch('Berry'); -- выводим всю информацию о сторудниках часть фамилии или фамилия которых 'Berry' из таблицы сформированой при помощи fnContactSearch();

SELECT * FROM dbo.fnContactSearch('Ber'); -- выводим всю информацию о сторудниках часть фамилии или фамилия которых 'Ber' из таблицы сформированой при помощи fnContactSearch();