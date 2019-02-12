USE ShopDB
GO

-------------------------------------------------------------------------
--					��������� ��������� �������
-------------------------------------------------------------------------

--  ��������� ��������� �������
--	1. ������� ������ �������� ������ � ��� ���������� �� ���������� ������.
--	2. ���������� ������ ����������� � ������ ���������� ��������.
--	3. ���������� ������ �������� �� ������� �������������� ��������.
--	4. ������� ������ ���������� ��� �������� ��� ���������� ���������� ���������.

SELECT * FROM SubTest1 AS ST1					  
WHERE name /* 4 */ = /* 3 */(SELECT name					   --|(2)
							 FROM SubTest2 AS ST2			   --|(2)
							 WHERE ST1.id1 = ST2.id2); -- (1)  --|(2)

SELECT * FROM SubTest1 AS ST1					  
WHERE name=(SELECT name				
			FROM SubTest2 AS ST2			 
			WHERE ST1.id1 = ST2.id2);
			  
-- ����� ������ ����������� ��������� �������:

-- EXISTS - ���������� true, ���� ������� ���������� ���� �� ���� ��������.
-- ����� ���������� ������� �������� EXISTS, �� ���������� ����� �� �������.
SELECT * FROM SubTest1  AS ST1
WHERE EXISTS
    (SELECT * FROM SubTest2	ST2
     WHERE ST1.id1 = ST2.id2);
     								


--  C�������� ��������� ������ � ������ �������
-- , (�������)
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


-- �������� ���������� �� ���������� ��������� ������ ������.

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
	  
-- ������� ����� ����� ������ �� �����������

SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] 
		FROM Employees
	     JOIN Orders
			ON Employees.EmployeeID	= Orders.EmployeeID
	     JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
GROUP BY  Employees.FName,
		  Employees.LName,  
		  Employees.MName
		  
-- �������� ��������� ������� CREATE TABLE #TableName:
-- #TableName  - ��������� �������, ������ �������� ����� ������������ ������
--               ������� ������������
-- ##TableName - ���������� �������, ������ �������� ����� ������������ �����
--				 ������������

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

-- WITH ... AS - ���������� ��������� ��������� - ������������ ������ ��������� ������,
-- ��� ����� ������� �������� ������������� ������.

WITH Managers (FName, LName, MName, TotalPrice) AS	-- �� �����!
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

			