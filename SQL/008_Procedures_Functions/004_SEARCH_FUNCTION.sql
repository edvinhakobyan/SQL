USE ShopDB
GO	
---------- Создаем таблицу сотрудников. ----------
CREATE TABLE MyEmployee
(
  EmployeeID int NOT NULL,
  ManagerID int NULL REFERENCES MyEmployee(EmployeeID), -- Показвает кому подченяется данный сотрудник.
  JobTitle nvarchar(50) NOT NULL,
  LastName nvarchar(50) NOT NULL,
  FirstName nvarchar(50) NOT NULL,
    CONSTRAINT PK_Employee2_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
);
GO

-- Иерархические данные (так как таблица содержит информацию о сторудниках подчиняющихся сотрудникам информация о которых так же хранится в этой таблице)
INSERT INTO MyEmployee(EmployeeID,ManagerID,JobTitle,LastName,FirstName)
VALUES
  (1, NULL, 'Генеральный директор','Сидоров', 'Виктор'),
  (2, 1, 'Финансовый директор', 'Левченко', 'Людмила'),	
  (3, 1, 'Кадровая поддержка','Стипанов','Григорий'),		
  (4, 1, 'Исполнительный директор', 'Самойленко', 'Виктор'),
  (5, 4, 'Инженер', 'Тимченко', 'Виталий'),			
  (8, 5, 'Инженер', 'Хабиб', 'Эльдар'),			
  (9, 5, 'Программист', 'Дулев', 'Павел'),				
  (10 ,5, 'Data Architect', 'Черчев', 'Робнрт'),			
  (11 ,5, 'Програмист', 'Залозный', 'Михаил'),				
  (6, 4, 'Персональный секретарь', 'Радченко', 'Вика'),	
  (7, 4, 'Начальник охраны','Стельмах','Игорь');				

SELECT * FROM MyEmployee;

-- Узнаем кто подчиняется исполнительному директору.
SELECT  sub.EmployeeID,
		sub.FirstName,
		sub.LastName
FROM
	MyEmployee as boss
	JOIN
	MyEmployee as sub
	ON boss.EmployeeID = sub.ManagerID
WHERE boss.JobTitle LIKE 'Исполнительный директор';
GO

-- Рекурсивная функция вывода всех подчиненных.

CREATE FUNCTION fnGetSub (@EmployeeId int) -- Создаем функцию с одним аргументом.
RETURNS @Sub TABLE  -- Обявляем возвращаемую таблицу.
		(
			EmployeeId int,
			SubId int,
			Name varchar (90)
		)
AS
BEGIN
	DECLARE @EmpId int;

INSERT @Sub -- Добаляем запись о руководителе в выходную таблицу.
	SELECT EmployeeID, ManagerID ,FirstName+' '+LastName
	FROM MyEmployee
	WHERE EmployeeID = @EmployeeId;

SET @EmpId = (SELECT MIN(EmployeeID) -- Определяем первого подчеенного.
			  FROM MyEmployee
			  WHERE ManagerID = @EmployeeId);
			  
-- Если такой есть то заходим в циклическую конструкцию WHILE			  
WHILE @EmpId IS NOT NULL -- Пока есть подчиненные выполняем цикл.
BEGIN
	INSERT @Sub -- Добавляем запись о подчененных относительно выше выбраного руководителя.
		SELECT * FROM dbo.fnGetSub(@EmpId) -- Рекурсия.

	SET @EmpId =(SELECT MIN(EmployeeID) -- Определяем следующего подчиненного.
				 FROM MyEmployee
				 WHERE EmployeeID > @EmpId
					   AND
					   ManagerID = @EmployeeId);
END;
RETURN; -- Если мы обявили возвращаемую таблицу то в RETURN не подставляем никакого значения, иначе возникнет ошибка.
END;
GO

SELECT * FROM dbo.fnGetSub(4); -- Воспользуемся для поиска функцией - fnGetSub.
SELECT * FROM MyEmployee;
drop function fnGetSub 