USE AdventureWorks2012;
GO
-------------------------------------------------------------------

CREATE PROC spEmployee -- Создание хранимой процедуры.
AS
  SELECT * FROM HumanResources.Employee;
GO 

EXEC spEmployee; --Вызов хранимой процедуры.
GO
--------------------------------------------------------------------

ALTER PROC spEmployee -- Изменение хранимой процедуры
AS
  SELECT he.BirthDate,he.BusinessEntityID FROM HumanResources.Employee he; 
GO
  
EXEC spEmployee; -- Вызов измененной хранимой процедуры.
   
DROP PROC spEmployee; -- Удаление хранимой процедуры.

EXEC spEmployee; -- ОШИБКА, так как данная процедура удалена.
GO

----------------------------------------------------------------------

/*Хранимая процедура с параметрами*/

DROP PROC spEmployeeByName

CREATE PROC spEmployeeByName 
	@LastName nvarchar(25)   -- При инициализации параметра значение по умолчанию не задано.
AS

	SELECT pc.BusinessEntityID, pc.FirstName, pc.LastName, pc.ModifiedDate 
	FROM Person.Person pc
	WHERE pc.LastName = @LastName;
GO


EXEC spEmployeeByName 'Abel' -- передаем процедуре обязательное значение

EXEC spEmployeeByName -- ОШИБКА если не передать обязательное значение по умолчанию

------------------------------------------------------------------------

DROP PROC spEmployeeByName;
GO

CREATE PROC spEmployeeByName
	@LastName nvarchar(25) = NULL -- чтобы указать что параметр является не обязательным, при инициализации необходимо ввести для него значение по умолчанию.

AS
IF @LastName IS NOT NULL  -- условная конструкция IF где @LastName IS NOT NULL является проверочным выражением возвращающим TRUE или FALSE 
	
	SELECT pc.BusinessEntityID, pc.FirstName, pc.LastName, pc.ModifiedDate
	FROM Person.Person pc
	WHERE pc.LastName LIKE @LastName + '%'
	
ELSE				
	
	SELECT pc.BusinessEntityID, pc.FirstName, pc.LastName, pc.ModifiedDate
	FROM Person.Person pc;
	
GO

EXEC spEmployeeByName     -- вызов без параметра.

EXEC spEmployeeByName 'Ca' --вызов с параметром

EXEC spEmployeeByName 'Cao' 
GO
------------------------------------------------------------------------------

/*Выходные параметры в хранимых процедурах*/
DROP PROC spEmployeeCount;
GO

CREATE PROC spEmployeeCount
	@Info int = null OUTPUT -- Для обьявления выходного парметра используется ключевое слово OUTPUT
AS
BEGIN
	SET @Info =(SELECT Count(*) From Person.Person);
END
GO

DECLARE @MyInfo int;

EXEC  spEmployeeCount @MyInfo OUTPUT; -- при вызове хранимой прроцедуры ключевое слово OUTPUT должно использоваться так же как и при обьявлении, обратите внимание как присваивается значение внешней переменной

PRINT CAST (@MyInfo as varchar);
GO
---------------------------------------------

---   Оператор возврата значения RETURN   --- 

DROP PROC TestProc

CREATE PROC TestProc
AS
BEGIN
	DECLARE @MyVar int = 10;
	RETURN @MyVar; -- оператор RETURN в процедурах возвращает ТОЛЬКО целочисленное значение!
END;
GO

DECLARE @MyRTN int;
EXEC @MyRTN = TestProc;
PRINT CAST(@MyRTN as varchar);
GO

-------------------------------------------
DROP PROC TestProc;
GO

CREATE PROC TestProc
AS
BEGIN
	DECLARE @MyVar int = 10;
	RETURN 'Done' -- оператор RETURN в процедурах возвращает ТОЛЬКО ЦЕЛОЧИСЛЕННОЕ ЗНАЧЕНИЕ!!!
END;
GO

DECLARE @MyRTN2 varchar(5);
EXEC @MyRTN2 = TestProc;
PRINT @MyRTN2;
GO
-------------------------------------------
DROP PROC spTestProc
GO

CREATE PROC spTestProc
AS
BEGIN
	PRINT 'Сейчас выполнится первый RETURN';
	RETURN; -- по умлочанию оператор RETURN возвращает 0
	PRINT 'Сейчас не выполнится второй RETURN';
	RETURN 5; -- после выполнения первого оператора RETURN, процедура прекращает свое выполнение
END;
GO

DECLARE @MyVar3 int;
EXEC @MyVar3 = spTestProc;
PRINT @MyVar3;
GO
------------------------------------------
--- Рекурсия ----
-- МАКСИМАЛЬНАЯ ГЛУБИНА РЕКУРСИИ 32 УРОВНЕЙ

DROP PROC spFactorial

CREATE PROC spFactorial
@ValueIn int,
@ValueOut int OUTPUT
AS
BEGIN
	DECLARE @InWorking int;
	DECLARE @OutWorking int;
	IF (@ValueIn != 1)
	BEGIN
		SET @InWorking = @ValueIn -1;
		EXEC spFactorial @InWorking, @OutWorking OUTPUT; -- вызов процедуры из самой себя (рекурсия)
		SET @ValueOut = @ValueIn * @OutWorking;
	END
	ELSE
		SET @ValueOut = 1;
END;
GO
-------------------------------------------

DECLARE @MyVarOut int,
		@MyVARIn int;

SET @MyVARIn = 7;
EXEC spFactorial @MyVarIn, @MyVarOut OUTPUT; -- 7!= 1*2*3*4*5*6*7 
PRINT CAST(@MyVARIn as varchar) + ' факториал: ' + CAST(@MyVarOut as varchar);
GO

----------------------
-- Ошибка. Не хватает диапазона значений типа использованного для переменных!

DECLARE @MyVarOut int,
		@MyVARIn int;

SET @MyVARIn = 13;
EXEC spFactorial @MyVarIn, @MyVarOut OUTPUT; -- 13!= 1*2*3*4*5*6*7*8*9*10*11*12*13
PRINT CAST(@MyVARIn as varchar) + ' факториал: ' + CAST(@MyVarOut as varchar);


----Процедура регистрации ошибок в таблице -----
DROP PROC uspLogError;
GO

DROP TABLE ErrorLog2

CREATE TABLE ErrorLog2
(
	ErrorId int IDENTITY,
	ErrorLine int,
	ErrorMessage varchar(200)
)
GO

-- Создаем процедуру регистрации ошибок

CREATE PROC uspLogError
	@ErrorLogId int = 0 OUTPUT
AS
BEGIN
	INSERT dbo.ErrorLog2 -- Запись данных об ошибке.
		(
			ErrorLine,
			ErrorMessage
		)	
		VALUES
		(
			ERROR_LINE(),
			ERROR_MESSAGE()
		)
	SET @ErrorLogId = @@IDENTITY; -- @@IDENTITY возвращает номер последнего идентификатора записанного в таблицу.
END;
------------------------------------------------

BEGIN TRY
	
	CREATE TABLE OurTest
	(
		col int
	)
	
END TRY
BEGIN CATCH
	
	DECLARE @OutIdError int;
	
	IF ERROR_NUMBER() = 2714
	BEGIN
		PRINT 'Попытка создать существующую таблицу';
		EXEC uspLogError @OutIdError OUTPUT;
		PRINT 'Ошибка записана в журнал Номер записи: ' + CAST(@OutIdError as varchar);
	END
	
	ELSE
	  PRINT 'Не известная ошибка ';
	  
END CATCH

SELECT * FROM ErrorLog2
GO
