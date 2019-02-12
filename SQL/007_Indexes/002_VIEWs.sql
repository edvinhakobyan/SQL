USE ShopDB
GO
-- ������������� ��� ������ ������ ������������� ������ �������� �� �������� ������� � ���� ����������� �������. 
DROP TABLE InfoPerson
GO

CREATE TABLE InfoPerson
(
	FirstName nvarchar(50) null,
	LastName nvarchar(50)null,
	BirthDate date null,
	AddressLine1 nvarchar(50)  null,
	AddressLine2 nvarchar(50) null,
	EmailAddress nvarchar(50) null,
)
GO

INSERT InfoPerson  -- ���������� ������ �� ����� ������� � ������
SELECT pc.FirstName, pc.LastName, CAST(he.BirthDate as DATE), pa.AddressLine1, pa.AddressLine2, pea.EmailAddress
		FROM AdventureWorks2012.Person.Person as pc  -- ����������.�����.������� AS �����
		 JOIN AdventureWorks2012.HumanResources.Employee as he 
			ON pc.BusinessEntityID = he.BusinessEntityID
		 JOIN AdventureWorks2012.Person.BusinessEntityAddress as hea 
			ON he.BusinessEntityID = hea.BusinessEntityID
		 JOIN AdventureWorks2012.Person.Address as pa 
			ON hea.AddressID = pa.AddressID
		 JOIN AdventureWorks2012.Person.EmailAddress as pea
			ON pea.BusinessEntityID = pc.BusinessEntityID
GO

SELECT * FROM InfoPerson;
GO
-----------------------------------------------------------
        /* �������� ������������� - CREATE VIEW */
-----------------------------------------------------------

CREATE VIEW BthPerson   -- �������� �������������
AS SELECT FirstName, LastName, BirthDate, EmailAddress
FROM InfoPerson;
GO

SELECT * FROM BthPerson; -- ������� �� �������������

SELECT * FROM InfoPerson; -- ������� �� �������
GO

------------------------------------------------------------

CREATE VIEW BthPerson2  
WITH SCHEMABINDING     -- ��������� �������� ������� ��� ������� ������� �������������.
AS SELECT FirstName, LastName, BirthDate, EmailAddress
FROM dbo.InfoPerson;   -- ���������������� ��������� ����� ������� � ������� ������� �������������.
GO

SELECT * FROM BthPerson2;
DROP TABLE InfoPerson; -- ����� ������.
GO

------------------------------------------------------------

CREATE VIEW BthPrsn2Addres   -- ������� ������������� ��� ������� ������ �� �������.
AS SELECT FirstName, LastName, BirthDate, AddressLine1, AddressLine2
FROM InfoPerson
WHERE AddressLine2 is not null; -- ������������� ����� �������� ���������� � ��� ����� ������� ����� 2 ������
GO

SELECT * FROM BthPrsn2Addres; -- ������� �� �������������

SELECT FirstName, LastName, BirthDate, AddressLine1 FROM BthPrsn2Addres; -- ��� � ��� ������� �� ������� ����� �������� ������������ ����� ��������� ��� ������
GO


-- ������ ������� InfoPerson, � ������� �������� ���������� �� ������ ������ 
-- ����� ������� �������������, ��� ���� ����� ������������ ���������� ������ ���� ������.

CREATE VIEW InfoPerson2 AS 
SELECT pc.FirstName, pc.LastName, he.BirthDate, pa.AddressLine1, pa.AddressLine2, pea.EmailAddress
		FROM AdventureWorks2012.Person.Person as pc  -- ����������.�����.������� AS �����
		 JOIN AdventureWorks2012.HumanResources.Employee as he 
			ON pc.BusinessEntityID = he.BusinessEntityID
		 JOIN AdventureWorks2012.Person.BusinessEntityAddress as hea 
			ON he.BusinessEntityID = hea.BusinessEntityID
		 JOIN AdventureWorks2012.Person.Address as pa 
			ON hea.AddressID = pa.AddressID
		 JOIN AdventureWorks2012.Person.EmailAddress as pea
			ON pea.BusinessEntityID = pc.BusinessEntityID
			
SELECT * FROM InfoPerson;

SELECT * FROM InfoPerson2;


-------------- ������� ������ � ������ �������������.
SELECT * FROM BthPerson;

INSERT INTO BthPerson 
(BirthDate, EmailAddress, FirstName, LastName)
VALUES 
('02/03/1990', 'adgkj@mail.ru', 'Andrew', 'Test1');

-- ������� �� �������������.
SELECT * FROM BthPerson WHERE LastName = 'Test1';

-- ������� �� �������.
-- �� ����� ���� ������ ���������� � ������� InfoPerson.
SELECT * FROM InfoPerson WHERE LastName = 'Test1';

------------------------------------------------------------
	
-- ���������� ������ � ������� �������������.

UPDATE BthPerson 
	SET EmailAddress = 'testmail1@mail.ru'
	WHERE LastName = 'Test1';
	
SELECT * FROM BthPerson 
	WHERE LastName = 'Test1';
	
SELECT * FROM InfoPerson
	WHERE LastName = 'Test1';

-- ��� �� ������ �������� ��������� � � �������
UPDATE InfoPerson
SET EmailAddress = 'testmail2@mail.ru'
	WHERE LastName='Test1';
	
SELECT * FROM BthPerson 
	WHERE LastName='Test1';
	
SELECT * FROM InfoPerson
	WHERE LastName='Test1';
	
-----------------------��������� �������������--------------

SELECT * FROM BthPerson;

ALTER VIEW BthPerson  -- ��������� �������������.
AS  SELECT FirstName, LastName, BirthDate, EmailAddress , AddressLine1
FROM InfoPerson;
GO

SELECT * FROM BthPerson;	

----------------------- �������� ������������� ---------------

DROP VIEW BthPerson;

-- ������������� ������ ���.
SELECT * FROM BthPerson 
	WHERE LastName = 'Test1';
	
-- ������ ������� ����������� ����� ������������� �������� � �������.
SELECT * FROM InfoPerson
	WHERE LastName = 'Test1';
