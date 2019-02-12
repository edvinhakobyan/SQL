USE ShopDB
GO

-------------------------------------------------------------------------
--					Связанные вложенные запросы
-------------------------------------------------------------------------

--  Связанные вложенные запросы
--	1. Внешний запрос получает строку и она передается во внутренний запрос.
--	2. Внутренний запрос выполняется с учетом полученных значений.
--	3. Внутренний запрос передает во внешний результируещее значение.
--	4. Внешний запрос использует эти значения для завершения намеченной обработки.

SELECT * FROM SubTest1 AS ST1					  
WHERE name /* 4 */ = /* 3 */(SELECT name					   --|(2)
							 FROM SubTest2 AS ST2			   --|(2)
							 WHERE ST1.id1 = ST2.id2); -- (1)  --|(2)

SELECT * FROM SubTest1 AS ST1					  
WHERE name=(SELECT name				
			FROM SubTest2 AS ST2			 
			WHERE ST1.id1 = ST2.id2);
			  
-- Более быстро выполняется следующим образом:

-- EXISTS - возвращает true, если выборка возвращает хотя бы одно значение.
-- после нахождения нужного значения EXISTS, не продолжает поиск по таблице.
SELECT * FROM SubTest1  AS ST1
WHERE EXISTS
    (SELECT * FROM SubTest2	ST2
     WHERE ST1.id1 = ST2.id2);
     								


--  Cвязанный вложенный запрос в списке выборки
-- , (запятая)
SELECT * ,(SELECT name	FROM SubTest2 AS ST2 WHERE ST1.id1 = ST2.id2) AS Name2 
FROM SubTest1 AS ST1;


SELECT *,
	   (SELECT id2 FROM SubTest2 AS ST2	WHERE ST1.id1 = ST2.id2) AS Id2,
	   (SELECT name	FROM SubTest2 AS ST2 WHERE ST1.id1 = ST2.id2) AS Name2
FROM SubTest1 AS ST1;
 
SELECT *,
	   (SELECT id2 FROM SubTest2 AS ST2	WHERE ST1.id1 = ST2.id2) AS Id2,
	   (SELECT name	FROM SubTest2 AS ST2 WHERE ST1.id1 = ST2.id2) AS Name2
FROM SubTest1 AS ST1
WHERE ST1.id1 = (SELECT id2 FROM SubTest2 AS ST2 
                  WHERE ST1.id1 = ST2.id2);


-- Показать статистику по количеству проданных единиц товара.

SELECT Products.ProdID, [Description], Qty, TotalPrice 
   	  FROM Products
INNER JOIN OrderDetails
      ON Products.ProdID = OrderDetails.ProdID
      
--------------------------------------------------------------------
      
SELECT (SELECT  ProdID FROM Products 
	    WHERE Products.ProdID = OrderDetails.ProdID) AS ProdID,
	   (SELECT  [Description] FROM Products 
	    WHERE Products.ProdID = OrderDetails.ProdID) AS [Description], Qty, TotalPrice 
FROM OrderDetails
	  
-- Вывести общую сумму продаж по сотрудникам

SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] 
		FROM Employees
	     JOIN Orders
			ON Employees.EmployeeID	= Orders.EmployeeID
	     JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
GROUP BY  Employees.FName,
		  Employees.LName,  
		  Employees.MName
		  
-- Создание временной таблицы CREATE TABLE #TableName:
-- #TableName  - локальная таблица, данной таблицей может пользоваться только
--               текущий пользователь
-- ##TableName - глобальная таблица, данной таблицей может пользоваться любой
--				 пользователь

CREATE TABLE #TmpTable
(FName varchar(50),
 LName varchar(50),
 MName varchar(50),
 TotalPrice money);
 GO
 
SELECT (SELECT FName FROM Employees 
		WHERE EmployeeID = (SELECT EmployeeID FROM Orders
							WHERE Orders.OrderID = OrderDetails.OrderID)
		) AS FName,
	    (SELECT LName FROM Employees 
		 WHERE EmployeeID = (SELECT EmployeeID FROM Orders
							 WHERE Orders.OrderID = OrderDetails.OrderID)
		) AS LName,
		(SELECT MName FROM Employees 
		 WHERE EmployeeID = (SELECT EmployeeID FROM Orders
							 WHERE Orders.OrderID = OrderDetails.OrderID)
		) AS MName,   
		TotalPrice
INTO TmpTable 
FROM OrderDetails;
GO		

SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] FROM TmpTable
GROUP BY FName, LName, MName;
GO	  

-- WITH ... AS - Обобщенные табличные выражения - используются вместо временных таблиц,
-- тем самым избегая хранения дублирующихся данных.

WITH Managers (FName, LName, MName, TotalPrice) AS	-- не алиас!
(
SELECT (
        SELECT FName FROM Employees 
		WHERE EmployeeID = (
		                    SELECT EmployeeID FROM Orders
							WHERE Orders.OrderID = OrderDetails.OrderID
							)
		),
		(
		 SELECT LName FROM Employees 
		 WHERE EmployeeID = (
		                     SELECT EmployeeID FROM Orders
							 WHERE Orders.OrderID = OrderDetails.OrderID
							 )
		),
		(
		 SELECT MName FROM Employees 
		 WHERE EmployeeID = (
		                     SELECT EmployeeID FROM Orders
							 WHERE Orders.OrderID = OrderDetails.OrderID
							 )
		),   
		TotalPrice 
FROM OrderDetails
)
         SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] 
         FROM Managers GROUP BY FName, LName, MName;
GO	  	

			