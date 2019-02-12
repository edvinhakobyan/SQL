USE AdventureWorks2012
GO
--------------------------------------------------------------------------
--				������������� ������. ����������� GROUP BY
--------------------------------------------------------------------------

-- ���������� ������� ������ �� �������� SalesOrderID � OrderQty, 
-- ������� Sales.SalesOrderDetail, ��� �������� ����� ������� SalesOrderID
-- ��������� ������ �� �������� ���� (43666, 43660, 43664)
SELECT SalesOrderID, OrderQty 
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43666, 43660, 43664);

-- ���������� ������� ������ �� ������� SalesOrderID 
-- � ������������� �������� �������������� ������� SUM �� ������� OrderQty, 
-- ������� Sales.SalesOrderDetail, ��� �������� ����� ������� SalesOrderID
-- ��������� ������ �� �������� ���� (43666, 43660, 43664),
-- ��� ���� ������������ ����������� �� ��������� ������� SalesOrderID. 
-- ������������� - ������� ����������� ���������

SELECT SalesOrderID, SUM(OrderQty) -- �������������� ������� SUM()
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43666, 43660, 43664)
GROUP BY SalesOrderID; 


SELECT SalesOrderID AS ID, SUM(OrderQty) AS Total -- ����� ��������� ����� AS ������ ���������(alias) ��� ���������� ������� SUM().
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43666, 43660, 43664)
GROUP BY SalesOrderID; -- ������������� ������.


-- ����������  ������� ������������� �������� �������������� ������� COUNT ������� HumanResources.Employee.
SELECT COUNT(*) AS Emp
FROM HumanResources.Employee; -- �������������� ������� COUNT() ������� ���������� ����� � �������

-- ���������� ������� ������ �� ������� ProductID � ������������� �������� �������������� ������� COUNT,
-- ������� Sales.SalesOrderDetail, ��� ���� ������������ ����������� �� ��������� ������� ProductID.
SELECT ProductID AS Product, COUNT(*) AS [Count] 
FROM Sales.SalesOrderDetail
GROUP BY ProductID;
--------------------------------------------------------------------------

-- ���������� ������� ������ �� ������� ProductID � ������������� �������� �������������� ������� COUNT,
-- ������� Sales.SalesOrderDetail, ��� ���� ������������ ����������� �� ��������� ������� ProductID,
-- ��� ������������ �������� �������������� ������� COUNT ������ 3300-��.
SELECT ProductID AS Product, COUNT(*) AS [Count] 
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) > 3300;	-- HAVING - ������ �������������� ��������� � GROUP BY (HAVING ���������� WHERE).
						-- HAVING - ������� ����������� ������ � �������.
--------------------------------------------------------------------------

-- ������. HAVING - ������ �������������� ��������� � GROUP BY.
SELECT ProductID AS Product
FROM Sales.SalesOrderDetail
HAVING ProductID > 10; -- ������������ ������������� HAVING (��� GROUP BY)

-- WHERE �������� �� �����������, � HAVING �������� ������ � ������������.
SELECT SalesOrderID, COUNT(*) AS TOTAL
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43666, 43660, 43664)
GROUP BY SalesOrderID
HAVING COUNT(*) > 5;