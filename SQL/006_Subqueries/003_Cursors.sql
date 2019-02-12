
-- Внимание!!! Используйте курсоры только при крайней необходимости!
-- Курсор - набор записей вместе с указателем, который идентифицирует текущую строку.

USE AdventureWorks2012;
GO

--------------------------- Определение курсора -------------------------------------

DECLARE contact_cursor CURSOR		   -- объявление курсора
FOR
		SELECT * FROM Person.Person   -- отбор строк для курсора
		
OPEN contact_cursor	                   -- открытие курсора
CLOSE contact_cursor                   -- закрытие курсора
DEALLOCATE contact_cursor              -- удаление курсора
GO

-- FETCH извлекает данные из курсора 

DECLARE contact_cursor CURSOR 
	SCROLL	             -- устанавливаем ограничение, SCROLL(позволяет двигаться курсору в любом направлении) 
	FOR
	SELECT FirstName, LastName FROM Person.Person
	
OPEN contact_cursor

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '1 NEXT'		
FETCH NEXT FROM contact_cursor       -- NEXT - извлечь строку
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName 

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '2 NEXT'			
FETCH NEXT FROM contact_cursor       -- NEXT - извлечь строку
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '3 PRIOR'	
FETCH PRIOR FROM contact_cursor      -- PRIOR - извлечь предыдущую строку
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '4 LAST'	
FETCH LAST FROM contact_cursor       -- LAST - извлечь последнюю строку
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '5 FIRST'	
FETCH FIRST FROM contact_cursor      -- FIRST - извлечь первую строку 
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '6 ABSOLUTE'	
FETCH ABSOLUTE 5 FROM contact_cursor -- ABSOLUTE n - извлечь строку номер n
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '7 RELATIVE'	
FETCH RELATIVE 5 FROM contact_cursor -- RELATIVE n - извлечь n-ную строку после текущей
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

CLOSE contact_cursor 
DEALLOCATE contact_cursor
GO


-- LOCAL - позволяет автоматически закрывать и удалять курсор после выполнения скрипта.

DECLARE contact_cursor CURSOR 
	LOCAL             -- устанавливаем ограничение LOCAL
	FOR
	SELECT FirstName, LastName FROM Person.Person
	
OPEN contact_cursor

DECLARE @FirstName nvarchar(50), @LastName nvarchar(50);

FETCH NEXT FROM contact_cursor       -- NEXT - извлечь строку
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName 
GO 

DEALLOCATE contact_cursor -- Ошибка, так как LOCAL удалил курсор.
GO