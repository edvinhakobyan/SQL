USE ShopDB
GO

DROP TABLE SubTest1;
DROP TABLE SubTest2;

CREATE TABLE SubTest1
(id1 int,
 name varchar(50));
 GO

CREATE TABLE SubTest2
(id2 int,
 name varchar(50));
GO

INSERT SubTest1
VALUES  (1,'one'),
		(2,'two'),
		(3,'three'),
		(4,'four'),
		(5,'five'),
		(9,'nine'),
		(10,'ten');
GO

INSERT SubTest2
VALUES  (1,'one'),
		(2,'two'),
		(3,'three'),
		(4,'four'),
		(5,'five'),
		(6,'six'),
		(7,'seven'),
		(8,'eight');
GO
SELECT * FROM SubTest1;
SELECT * FROM SubTest2;
-------------------------------------------------------------------------------------------
--							        ��������� �������
-------------------------------------------------------------------------------------------

-- �������� ������ - ���������� ��������� ����� ������ ������� (������ ������ �������)
	
SELECT * FROM SubTest1
WHERE id1 IN	  
			(SELECT id2 FROM SubTest2); -- ��������� ������
			
-- ���� ��������� ������ ���������� ������ ������ ��������, �� ������������ ������� ��������� IN;
-- ����	��������� ������ ���������� ���� ��������, �� ������������ ������� ��������� =;
	
SELECT * FROM SubTest1
WHERE id1 =	  -- ������
			(SELECT id2 FROM SubTest2); -- ��������� ������
			
-- ��������� ������ ����� ����� ��������� ����������� WHERE

SELECT * FROM SubTest1
WHERE id1 =	  
			(SELECT id2 FROM SubTest2 WHERE name = 'four'); 

-----------------------------------------------------------------------------------------

USE AdventureWorks2012;
GO

SELECT FirstName + ' ' + LastName as Name, BirthDate
FROM Person.Person as pc   -- Person - ����� (������ ������������ ����)   
JOIN HumanResources.Employee as he 
ON pc.BusinessEntityID = he.BusinessEntityID
WHERE BirthDate = '1945-11-17' 

-- ��������� ������� ����� ��������� ��������� � JOIN's

SELECT FirstName + ' ' + LastName as Name, BirthDate 
FROM Person.Person as pc       
JOIN HumanResources.Employee as he 
ON pc.BusinessEntityID = he.BusinessEntityID
WHERE BirthDate = (SELECT MIN(BirthDate) FROM HumanResources.Employee ); 	