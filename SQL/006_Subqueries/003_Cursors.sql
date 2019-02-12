
-- ��������!!! ����������� ������� ������ ��� ������� �������������!
-- ������ - ����� ������� ������ � ����������, ������� �������������� ������� ������.

USE AdventureWorks2012;
GO

--------------------------- ����������� ������� -------------------------------------

DECLARE contact_cursor CURSOR		   -- ���������� �������
FOR
		SELECT * FROM Person.Person   -- ����� ����� ��� �������
		
OPEN contact_cursor	                   -- �������� �������
CLOSE contact_cursor                   -- �������� �������
DEALLOCATE contact_cursor              -- �������� �������
GO

-- FETCH ��������� ������ �� ������� 

DECLARE contact_cursor CURSOR 
	SCROLL	             -- ������������� �����������, SCROLL(��������� ��������� ������� � ����� �����������) 
	FOR
	SELECT FirstName, LastName FROM Person.Person
	
OPEN contact_cursor

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '1 NEXT'		
FETCH NEXT FROM contact_cursor       -- NEXT - ������� ������
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName 

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '2 NEXT'			
FETCH NEXT FROM contact_cursor       -- NEXT - ������� ������
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '3 PRIOR'	
FETCH PRIOR FROM contact_cursor      -- PRIOR - ������� ���������� ������
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '4 LAST'	
FETCH LAST FROM contact_cursor       -- LAST - ������� ��������� ������
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '5 FIRST'	
FETCH FIRST FROM contact_cursor      -- FIRST - ������� ������ ������ 
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '6 ABSOLUTE'	
FETCH ABSOLUTE 5 FROM contact_cursor -- ABSOLUTE n - ������� ������ ����� n
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

DECLARE @FirstName nvarchar(50),
		@LastName nvarchar(50);
PRINT '7 RELATIVE'	
FETCH RELATIVE 5 FROM contact_cursor -- RELATIVE n - ������� n-��� ������ ����� �������
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName

CLOSE contact_cursor 
DEALLOCATE contact_cursor
GO


-- LOCAL - ��������� ������������� ��������� � ������� ������ ����� ���������� �������.

DECLARE contact_cursor CURSOR 
	LOCAL             -- ������������� ����������� LOCAL
	FOR
	SELECT FirstName, LastName FROM Person.Person
	
OPEN contact_cursor

DECLARE @FirstName nvarchar(50), @LastName nvarchar(50);

FETCH NEXT FROM contact_cursor       -- NEXT - ������� ������
	INTO @FirstName, @LastName
PRINT @FirstName + ' ' + @LastName 
GO 

DEALLOCATE contact_cursor -- ������, ��� ��� LOCAL ������ ������.
GO