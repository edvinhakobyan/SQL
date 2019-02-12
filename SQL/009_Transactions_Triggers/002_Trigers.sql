USE AdventureWorks2012;
GO
-- Блок настроек для успешной работы триггеров.
SET ANSI_NULLS ON  --  Если SET ANSI_NULLS установлено в ON, любая инструкция SELECT, использующая предложение WHERE column_name = NULL, не вернет ни одной записи, даже если в столбце column_name есть значения NULL.
GO
-- Если параметры SET ARITHABORT и SET ANSI WARNINGS установлены в значение ON, 
-- эти условия ошибок приведут к завершению запроса. Если параметр SET ARITHABORT установлен в значение ON, 
-- а параметр SET ANSI WARNINGS установлен в значение OFF, то эти условия ошибок приведут к завершению пакета.
SET ARITHABORT ON -- Если при исполнении транзакции произошли ошибки, то для этой транзакции выполняется откат.
GO
SET CONCAT_NULL_YIELDS_NULL ON -- Когда параметр SET CONCAT_NULL_YIELDS_NULL установлен в ON, объединение значения NULL со строкой дает в результате NULL. 
GO
SET QUOTED_IDENTIFIER ON -- Если параметру SET QUOTED_IDENTIFIER присвоено значение ON, то идентификаторы можно заключать в двойные кавычки и литералы должны быть разделены одинарными кавычками.
GO
SET ANSI_PADDING ON -- Столбцы, определенные типами данных char, varchar, binary и varbinary, имеют определенный размер.
GO
SET ANSI_WARNINGS ON -- Если значения NULL появляются в агрегатных функциях, таких как SUM, AVG, MAX, MIN, STDEV, STDEVP, VAR, VARP или COUNT, то при установке значения ON формируется предупреждающее сообщение. 
GO
-- Если параметр SET NUMERIC_ROUNDABORT имеет значение ON, после потери точности в выражении формируется ошибка.
-- Если задано значение OFF, потери точности не приводят к формированию сообщений об ошибках, а результат округляется с точностью столбца или переменной, в которых будет сохранен. 
SET NUMERIC_ROUNDABORT OFF 
GO
-- http://msdn.microsoft.com/ru-ru/library/ms188048.aspx
--------------------------------------------------------------------------
DROP TRIGGER Sales.SaleaOrderDetailNotDiscontinued; -- Удаление тригеров.
GO
--------------------------------------------------------------------------
-- Триггер - это обработчик который можно выполнить во время выполнения операций - INSERT, UPDATE, DELETE.
-- Вместе с созданием триггера постоянно создаются две служебные таблицы: Inserted и deleted

CREATE TRIGGER Sales.SaleaOrderDetailNotDiscontinued
	ON Sales.SalesOrderDetail
	FOR INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT *
		FROM Inserted as i -- Данные вставляемые пользователем в таблицу Sales.SalesOrderDetail(inserted - внутренняя таблица тригера где хранятся строки которые буду проверяться и при хорошем результате проверки потом вставляться в таблицу Sales.SalesOrderDetail)
		JOIN Production.Product p
		ON i.ProductID = p.ProductID
		  WHERE p.DiscontinuedDate IS NOT NULL -- проверяем есть ли дата снятия с продажи
	)
BEGIN
	RAISERROR('Товар отсутсвует на складе!', 1, 16); -- выводим ошибку если товар уже снят с продажи
	ROLLBACK TRAN
END
GO

SELECT * FROM Production.Product WHERE ProductID = 706;

UPDATE Production.Product -- создаем проверочную строку где указана дата снятия с продажи так как в таблице Production.Product таковых данных нету
SET DiscontinuedDate = '01-03-2011'
WHERE ProductID = 940;

SELECT * FROM Sales.SalesOrderDetail;

INSERT INTO Sales.SalesOrderDetail -- попытаемся добавить этот заказ c товаром ID которого 940
VALUES
(43659,'4911-403C-98',1,940,1,6.45,0.00,NEWID(),GETDATE());

INSERT INTO Sales.SalesOrderDetail -- попытаемся добавить этот заказ c товаром ID которого 706
VALUES
(43659,'4911-403C-98',1,706,1,6.45,0.00,NEWID(),GETDATE());

------------------------------------------------------------------------------------------------------
--- Приминение тригеров для проверки дельты (изменения) обновления ---
--Дельта обновления - велечина изменения обновленного значения относительно предыдущего.
SELECT * FROM Production.ProductInventory
GO

DROP TRIGGER Production.ProductIsRationed
GO

CREATE TRIGGER Production.ProductIsRationed
	ON Production.ProductInventory
	FOR UPDATE
AS
IF EXISTS
(
	SELECT * 
	FROM inserted i
	JOIN deleted d
		ON d.ProductID = i.ProductID 
		 AND d.LocationID=i.LocationID
	WHERE (d.Quantity - i.Quantity) > d.Quantity/2 --вычисляем дельта обновление (разница между текущим количеством товара и сколько останется после продажи)
		 AND d.Quantity - i.Quantity > 0
)
BEGIN
	RAISERROR('Не возможно покупать больше 50 процентов от оставшегося количества товаров ',1,2)	
	ROLLBACK TRAN
END
GO

SELECT * FROM Production.ProductInventory WHERE ProductID = 4 AND LocationID = 6

UPDATE Production.ProductInventory
SET Quantity = 200 -- Пытаемся продать 422-200 = 222-больше 50% процентов
WHERE ProductID = 4
	AND LocationID = 6
	
UPDATE Production.ProductInventory
SET Quantity = 222 -- Пытаемся продать 422-222 = 200- меньше 50% процентов
WHERE ProductID = 4
	AND LocationID = 6
	
UPDATE Production.ProductInventory
SET Quantity = 422 
WHERE ProductID = 4
	AND LocationID = 6
GO
---------------------------------------------------------------------
---отмена действия тригеров на таблице без его удаления---
ALTER TABLE Production.ProductInventory
DISABLE TRIGGER ALL ; -- отключаем тригеры
GO

UPDATE Production.ProductInventory
SET Quantity = 200 --пытаемся продать 422-200 = 222-больше 50% процентов
WHERE ProductID = 4
	AND LocationID = 6
GO
	
UPDATE Production.ProductInventory
SET Quantity = 422 
WHERE ProductID = 4
	AND LocationID = 6
GO

ALTER TABLE Production.ProductInventory
ENABLE TRIGGER ALL ; -- включаем тригер
GO

UPDATE Production.ProductInventory
SET Quantity = 200 --пытаемся продать 422-200 = 222-больше 50% процентов
WHERE ProductID = 4
	AND LocationID = 6
GO
---Production.ProductIsRationed - реализован правильно но не оптимизирован! --
------------------------------------------------------------------------------

---- Правильно так: -----
ALTER TRIGGER Production.ProductIsRationed -- ALTER TRIGGER позволяет изменить существующий тригер не удаляя его
		ON Production.ProductInventory
	FOR UPDATE 
AS
	IF UPDATE(Quantity) -- Функция UPDATE() - возвращает TRUE или FALSE в зависимости от того осуществляется ли обновление конкретного столбца.
	BEGIN
		IF EXISTS
		(
			SELECT * 
			FROM inserted i
			JOIN deleted d
				ON d.ProductID = i.ProductID 
				 AND d.LocationID=i.LocationID
			WHERE (d.Quantity - i.Quantity) > d.Quantity/2 --вычисляем дельта обновление (разница между текущим количеством товара и сколько останется после продажи)
				 AND d.Quantity - i.Quantity > 0
		)
		BEGIN
			RAISERROR('Не возможно покупать больше 50 процентов от оставшегося количества товаров ',1,16)	
			ROLLBACK TRAN
		END
	END
GO
