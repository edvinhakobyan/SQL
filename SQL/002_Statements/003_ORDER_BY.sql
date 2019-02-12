USE AdventureWorks2012
GO

SELECT BusinessEntityID, FirstName, LastName, MiddleName, ModifiedDate FROM Person.Person

--------------------------------------------------------------------------
--				����������� ORDER BY - ����������� ��...
--------------------------------------------------------------------------

-- ���������� ������� ������ �� �������� BusinessEntityID, FirstName, LastName, MiddleName � ModifiedDate,
-- ��� ������ ����������� �� ������� FirstName, ������� Person.Person
SELECT BusinessEntityID, FirstName, LastName, MiddleName, ModifiedDate 
FROM Person.Person
ORDER BY FirstName;  -- ����������� �� �����.

-- ���������� ������� ������ �� �������� BusinessEntityID, FirstName, LastName, MiddleName � ModifiedDate, 
-- ��� ������ ����������� �� ������� ModifiedDate, ������� Person.Person
SELECT BusinessEntityID, FirstName, LastName, MiddleName, ModifiedDate 
FROM Person.Person
ORDER BY ModifiedDate;  -- ����������� �� ModifiedDate

-- ���������� ������� ������ �� �������� BusinessEntityID, FirstName, LastName, MiddleName � ModifiedDate, 
-- ��� ������ ����������� �� �������� FirstName � LastName, ������� Person.Person
SELECT BusinessEntityID, FirstName, LastName, MiddleName, ModifiedDate 
FROM Person.Person
ORDER BY FirstName, LastName;  -- C���������� �� ����� � �������

-- ���������� ������� ������ �� �������� BusinessEntityID, FirstName, LastName, MiddleName � ModifiedDate, 
-- ��� ������ ����������� �� ������� FirstName, ������� Person.Person
SELECT BusinessEntityID, FirstName, LastName, MiddleName, ModifiedDate 
FROM Person.Person
ORDER BY FirstName ASC; -- ���������� �� �����������. ASC - �� ���������.

-- ���������� ������� ������ �� �������� BusinessEntityID, FirstName, LastName, MiddleName � EmailAddress, 
-- ��� ������ ����������� � ������� ��������, �� ������� FirstName, ������� Person.Contact
SELECT BusinessEntityID, FirstName, LastName, MiddleName, ModifiedDate 
FROM Person.Person
ORDER BY FirstName DESC; -- ���������� �� ��������.

