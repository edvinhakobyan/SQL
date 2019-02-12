/*���������������� ������� ������������ ��������� �������� (�� ���������)*/
USE ShopDB
GO

CREATE FUNCTION Hello() -- ������� �������
RETURNS varchar(30)     -- ��������� ��� ������������� ��������
AS
BEGIN --������ ���� �-���
DECLARE @MyVar varchar(20) ='Hello World!';
RETURN @MyVar; --������������ �������� �-���
END; -- ����� ���� �-���
GO

PRINT dbo.Hello();

DROP TABLE TestTable;
GO

CREATE TABLE TestTable
(
	id int identity not null,
	name varchar(25) not null,
	CDate smalldatetime not null
)
GO

-------------------------------------------------------

DECLARE @MyVar int =1;
DECLARE @MyVcVar varchar(10);

WHILE @MyVar < 20
BEGIN
	SET @MyVcVar = 'Test ' + CAST(@MyVar as varchar);
	-- ������� ������ � �������
	INSERT TestTable
	( name, CDate )
	VALUES (@MyVcVar, DATEADD(MI, @MyVar, GETDATE()));
	
	SET @MyVar = @MyVar + 1;
END
GO

/* ������ ������� ����� ������, ��� ��� ������� GETDATE() 
 ���������� �������� ���� datetime (���������� �� ������ 
 ���� �� � ������� ����� �� 3-� ����� �������)*/
SELECT * FROM TestTable
WHERE CDate = GETDATE(); 
GO
---------------------------------------------------------

CREATE FUNCTION DateOnly (@Date datetime) -- ������� ������� ����� �� ��� � ��������
RETURNS date --�������� ������������ ���
AS
BEGIN --���� �������
 RETURN CAST(@Date as date); -- �������� � ���� date ������������ ��������
END
GO

SELECT * FROM TestTable -- ������ ������� ������ 19 �������(��� �� ����������� ����
WHERE dbo.DateOnly(CDate)= dbo.DateOnly(GETDATE()); --����� ���� ��������� ����� ��� ������ ���������������� �������
----------------------------------------
USE AdventureWorks2012
GO

/* ������ ������ ��� ��������� ���� ������� ������� ����������,
� ������ ������� ������������ ������� ������ �������� �� ����-
���� ��������� ���������*/

SELECT	Name,
		ListPrice,
		(SELECT AVG(ListPrice) FROM Production.Product WHERE ProductSubcategoryID = 1) as Average, -- ���������� �������� ������, �� ������ ��� ������� AVG - ������������ ������� ��������
		ListPrice - (SELECT AVG(ListPrice) FROM Production.Product WHERE ProductSubcategoryID = 1) as DifferencePrice
FROM Production.Product 
WHERE ProductSubcategoryID = 1; -- ������ ������� ��� Mountain Bikers
GO

DROP FUNCTION AvgPrice
DROP FUNCTION DfrncPrice
GO

-- ��������� ������ (SELECT AVG(ListPrice)FROM Production.Product) ����� �������� � ���� �������, 
-- ��� ��� �� ���������� ������� �� ������ ��������
CREATE FUNCTION AvgPrice()
RETURNS money
WITH SCHEMABINDING    -- ��������� �������� �������.
AS
BEGIN
	RETURN (SELECT AVG(ListPrice)FROM Production.Product WHERE ProductSubcategoryID = 1);
END
GO

--- ������������� ��������� �������
CREATE FUNCTION DfrncPrice(@Price money)
RETURNS money
AS
BEGIN
	RETURN @Price - dbo.AvgPrice(); -- �������� ��������� ��������� �������
END;
GO

-- �������� ��� �� ������ ��� ��������� ���� ������� ������� ����������
SELECT  Name,
		ListPrice,
		dbo.AvgPrice() as AvgPrice,
		dbo.DfrncPrice(ListPrice) as DifferencePrice
FROM Production.Product
WHERE ProductSubcategoryID = 1;
GO

/*��������������� ������� ����������� �������*/

USE AdventureWorks2012;
GO

DROP FUNCTION fnContactList

CREATE FUNCTION fnContactList() -- ������� �������
RETURNS TABLE -- ������������ ��� TABLE ��������� �� �� ��� ������������ ����� �������
AS
RETURN (SELECT LastName, FirstName, ModifiedDate 
		FROM Person.Person); 
GO

SELECT * FROM dbo.fnContactList(); -- ������� ��� ���������� �� ������� ������������� ��� ������ ������� fnContactList();
GO

--�������: ��������� ���������� ������ � ������� �������������

DROP FUNCTION fnContactSearch

CREATE FUNCTION fnContactSearch(@LastName varchar(30)) --�������� ���� �������� ���� varchar (������� ��� ����� �������)
RETURNS TABLE
AS
RETURN (SELECT FirstName , LastName, ModifiedDate 
		FROM Person.Person
		WHERE LastName LIKE @LastName + '%'); -- ������� �� �������
GO

SELECT * FROM dbo.fnContactSearch('Berry'); -- ������� ��� ���������� � ����������� ����� ������� ��� ������� ������� 'Berry' �� ������� ������������� ��� ������ fnContactSearch();

SELECT * FROM dbo.fnContactSearch('Ber'); -- ������� ��� ���������� � ����������� ����� ������� ��� ������� ������� 'Ber' �� ������� ������������� ��� ������ fnContactSearch();