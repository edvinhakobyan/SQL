USE ShopDB;	 
GO
--IF OBJECT_ID('MyUserName') IS NOT NULL
--	DROP TABLE MyUserName;
--GO
-- Удаляем, если существуют такие таблицы...
DROP TABLE MyUserName;
GO
DROP TABLE MyUserTell;
GO
DROP TABLE MyUserInfo;
GO
-- ... ошибка, какая и как исправить?

--- создать таблицу ---
CREATE TABLE MyUserName
(
	IdTest int IDENTITY PRIMARY KEY,
	FName varchar(25),
	LName varchar(25)
)
GO

CREATE TABLE MyUserTell
(
	IdTest int IDENTITY PRIMARY KEY,
	IdUser int FOREIGN KEY REFERENCES MyUserName(IdTest) UNIQUE,
	TellN char(12) 
	CHECK (TellN LIKE ('([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')) -- Что это значит?
)
GO

CREATE TABLE MyUserInfo
(
	IdTest int IDENTITY PRIMARY KEY,
	IdUser int FOREIGN KEY REFERENCES MyUserName(IdTest),
	Bdate date
)
GO

--------------------------------------------------------------------
-------------------------- Транзакции ------------------------------
--------------------------------------------------------------------

---------------------------------------------------------
-- Мы уже использовали транзакции (неявно)
 BEGIN TRANSACTION; -- начало транзакции
 INSERT MyUserName
 VALUES('TestName0','TestLName0')
 COMMIT TRANSACTION; -- успешное завершение транзакции   
 
 SELECT * FROM MyUserName;
---------------------------------------------------------
 -- откат транзакции
 
 BEGIN TRANSACTION  -- начало транзакции

 INSERT MyUserName
 VALUES
	('RollTest1','RollTestL1')
	
 ROLLBACK TRANSACTION; -- происходит откат транзакции, наша вставка не выполнится, тоесть: 
					   -- INSERT MyUserName VALUES ('TestName1','RollTestL1') ,- не произойдет 

SELECT * FROM MyUserName;

---------------------------------------------------------
 
-- в одной транзакции можно выполнять несколько действий

BEGIN TRANSACTION; -- начало транзакции
 
DECLARE @Id int;

INSERT MyUserName
VALUES
	('TestName0','TestLName0')
	
SET @Id = @@IDENTITY;
		
INSERT MyUserTell
VALUES 
(@Id,'(097)2224455');
		
INSERT MyUserInfo
VALUES (@Id,'01/02/1990');

COMMIT TRANSACTION; -- успешное завершение транзакции   
 
SELECT * FROM MyUserName;
SELECT * FROM MyUserInfo;
SELECT * FROM MyUserTell;
GO

---------------------------------------------------------

-- В одной транзакции можно "откатить" несколько действий.

BEGIN TRANSACTION; -- Начало транзакции.
 
DECLARE @Id int;

INSERT MyUserName
VALUES
	('RollBackTest','TestLName0')
	
SET @Id = @@IDENTITY; 
		
INSERT MyUserTell
VALUES 
(@Id,'(097)2224455');
		
INSERT MyUserInfo
VALUES (@Id,'01/02/1990');

ROLLBACK TRANSACTION; -- Откат последовательности дейсвий.

SELECT * FROM MyUserName;
SELECT * FROM MyUserInfo;
SELECT * FROM MyUserTell;
---------------------------------------------------------
-- Точка сохранения транзакции (промежуточное сохранение транзакции)

BEGIN TRAN 

INSERT MyUserName
VALUES
	('SavePoinTest1','TestLName0')
SAVE TRAN SavePointTran; -- Точка сохранения транзакции (промежуточное сохранение транзакции)
PRINT 'SAVE POINT';
INSERT MyUserName
VALUES
	('SavePointTest2','TestLName0')

ROLLBACK TRAN SavePointTran; -- Откат к точке востановления.

COMMIT TRAN -- Снять комментарий после выполнения транзакции ниже по коду.

SELECT * FROM MyUserName;
GO

---------------------------------------------------------
-- Точка сохранения транзакции (промежуточное сохранение транзакции)

BEGIN TRAN 

INSERT MyUserName
VALUES
	('SavePoinTest3','TestLName0')
SAVE TRAN SavePointTran; -- Точка сохранения транзакции (промежуточное сохранение транзакции)
PRINT 'SAVE POINT';
INSERT MyUserName
VALUES
	('SavePointTest4','TestLName0')

ROLLBACK TRAN -- если не указана точка сохранения к которой нужно произвести откат, 
			  -- то откат происходит к началу транзакции

SELECT * FROM MyUserName;
GO

---------------------------------------------------------

DROP PROC MyTransactProc;
GO

-- Процедура записи данных о пользователе (имя, фамилия, номер телефона, дата рождения) , есть мальнькая ошибка, исправте пожалуйста...
CREATE PROC MyTransactProc
	@FName varchar(25),
	@LName varchar(25),
	@TellN char(12),
	@BDate date
AS
BEGIN
DECLARE @Id int;
BEGIN TRAN -- Начало транзакции.
			
		INSERT MyUserName
		VALUES (@FName,@LName);
		SET @Id = @@IDENTITY;
		
		INSERT MyUserTell
		VALUES (@Id,@TellN);
		
		INSERT MyUserInfo
		VALUES (@Id,@BDate);
		
IF EXISTS (SELECT * FROM MyUserName WHERE @FName = FName AND @LName = LName AND IdTest != @Id) -- Проверка на наличие данных об этом человеке.
			BEGIN
				ROLLBACK TRAN; -- Откат транзакции если человек существует.
				RETURN 1;
			END;	
			
		COMMIT TRAN ; -- Успешное завершение транзкции если данный пользователь еще не записан в БД.
END;	

 -- Проверка результатов работы процедуры. --
EXEC MyTransactProc			  -- Запись данных.
	 @Fname = 'Name1',
	 @LName = 'LName1', 
	 @TellN = '(097)7775566',
	 @BDate = '01/02/2010';
GO

EXEC MyTransactProc			  -- Повторная попытка ввести эти же данные.
	 @Fname = 'Name1',
	 @LName = 'LName1', 
	 @TellN = '(097)7775566' ,
	 @BDate = '01/02/2010';
GO

EXEC MyTransactProc				
	 @Fname = 'TestName2',
	 @LName = 'TestLName2', 
	 @TellN = '(097)7775566' ,
	 @BDate = '01/02/2010';
GO

SELECT * FROM MyUserName;
SELECT * FROM MyUserInfo;
SELECT * FROM MyUserTell;