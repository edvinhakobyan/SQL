USE ShopDB
GO

-- Показать статистику по количеству проданых единиц товара.
SELECT Products.ProdID, [Description], SUM(Qty) AS Qty, SUM(TotalPrice) AS TotalSold -- Ошибки нет.
   	  FROM Products
INNER JOIN OrderDetails
      ON Products.ProdID = OrderDetails.ProdID
	  GROUP BY Products.ProdID, [Description]


-- Если в используемых таблицах, имеются столбцы с одинаковыми именами, 
-- то нужно явно указать к какой таблице относится данный столбец.
SELECT ProdID, [Description], Qty, TotalPrice FROM Products  -- Ошибка!
			   JOIN OrderDetails
			   ON Products.ProdID = OrderDetails.ProdID
	  
	  
-- Вывести общую суму продаж по сотрудикам.
SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] FROM Employees -- Алиас [Total Sold]
	     JOIN Orders
			ON Employees.EmployeeID	= Orders.EmployeeID
	     JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
GROUP BY  Employees.FName,
		  Employees.LName,  
		  Employees.MName

-- Вывести общую суму продаж по каждому из сотрудиков
		  
SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] FROM Employees -- Алиас [Total Sold]
	     LEFT JOIN Orders
			ON Employees.EmployeeID	= Orders.EmployeeID
	     LEFT JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
GROUP BY  Employees.FName,
		  Employees.LName,  
		  Employees.MName
	   
-- Вывести план подченения сотрудников (Кто кому подчиняется)
SELECT Emp1.FName, Emp1.MName, Emp1.LName, Emp2.FName, Emp2.MName, Emp2.LName  
       FROM Employees	Emp1 -- Алиас Emp1
		 JOIN Employees	Emp2 -- Алиас Emp2
		 ON Emp1.EmployeeID = Emp2.ManagerEmpID	  

