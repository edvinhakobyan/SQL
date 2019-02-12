USE AdventureWorks2012;
GO
-------------------------------------------------------------------

CREATE PROC spEmployee -- �������� �������� ���������.
AS
  SELECT * FROM HumanResources.Employee;
GO 

EXEC spEmployee; --����� �������� ���������.
GO
--------------------------------------------------------------------

ALTER PROC spEmployee -- ��������� �������� ���������
AS
  SELECT he.BirthDate,he.BusinessEntityID FROM HumanResources.Employee he; 
GO
  
EXEC spEmployee; -- ����� ���������� �������� ���������.
   
DROP PROC spEmployee; -- �������� �������� ���������.

EXEC spEmployee; -- ������, ��� ��� ������ ��������� �������.
GO

----------------------------------------------------------------------

/*�������� ��������� � �����������*/

DROP PROC spEmployeeByName

CREATE PROC spEmployeeByName 
	@LastName nvarchar(25)   -- ��� ������������� ��������� �������� �� ��������� �� ������.
AS

	SELECT pc.BusinessEntityID, pc.FirstName, pc.LastName, pc.ModifiedDate 
	FROM Person.Person pc
	WHERE pc.LastName = @LastName;
GO


EXEC spEmployeeByName 'Abel' -- �������� ��������� ������������ ��������

EXEC spEmployeeByName -- ������ ���� �� �������� ������������ �������� �� ���������

------------------------------------------------------------------------

DROP PROC spEmployeeByName;
GO

CREATE PROC spEmployeeByName
	@LastName nvarchar(25) = NULL -- ����� ������� ��� �������� �������� �� ������������, ��� ������������� ���������� ������ ��� ���� �������� �� ���������.

AS
IF @LastName IS NOT NULL  -- �������� ����������� IF ��� @LastName IS NOT NULL �������� ����������� ���������� ������������ TRUE ��� FALSE 
	
	SELECT pc.BusinessEntityID, pc.FirstName, pc.LastName, pc.ModifiedDate
	FROM Person.Person pc
	WHERE pc.LastName LIKE @LastName + '%'
	
ELSE				
	
	SELECT pc.BusinessEntityID, pc.FirstName, pc.LastName, pc.ModifiedDate
	FROM Person.Person pc;
	
GO

EXEC spEmployeeByName     -- ����� ��� ���������.

EXEC spEmployeeByName 'Ca' --����� � ����������

EXEC spEmployeeByName 'Cao' 
GO
------------------------------------------------------------------------------

/*�������� ��������� � �������� ����������*/
DROP PROC spEmployeeCount;
GO

CREATE PROC spEmployeeCount
	@Info int = null OUTPUT -- ��� ���������� ��������� �������� ������������ �������� ����� OUTPUT
AS
BEGIN
	SET @Info =(SELECT Count(*) From Person.Person);
END
GO

DECLARE @MyInfo int;

EXEC  spEmployeeCount @MyInfo OUTPUT; -- ��� ������ �������� ���������� �������� ����� OUTPUT ������ �������������� ��� �� ��� � ��� ����������, �������� �������� ��� ������������� �������� ������� ����������

PRINT CAST (@MyInfo as varchar);
GO
---------------------------------------------

---   �������� �������� �������� RETURN   --- 

DROP PROC TestProc

CREATE PROC TestProc
AS
BEGIN
	DECLARE @MyVar int = 10;
	RETURN @MyVar; -- �������� RETURN � ���������� ���������� ������ ������������� ��������!
END;
GO

DECLARE @MyRTN int;
EXEC @MyRTN = TestProc;
PRINT CAST(@MyRTN as varchar);
GO

-------------------------------------------
DROP PROC TestProc;
GO

CREATE PROC TestProc
AS
BEGIN
	DECLARE @MyVar int = 10;
	RETURN 'Done' -- �������� RETURN � ���������� ���������� ������ ������������� ��������!!!
END;
GO

DECLARE @MyRTN2 varchar(5);
EXEC @MyRTN2 = TestProc;
PRINT @MyRTN2;
GO
-------------------------------------------
DROP PROC spTestProc
GO

CREATE PROC spTestProc
AS
BEGIN
	PRINT '������ ���������� ������ RETURN';
	RETURN; -- �� ��������� �������� RETURN ���������� 0
	PRINT '������ �� ���������� ������ RETURN';
	RETURN 5; -- ����� ���������� ������� ��������� RETURN, ��������� ���������� ���� ����������
END;
GO

DECLARE @MyVar3 int;
EXEC @MyVar3 = spTestProc;
PRINT @MyVar3;
GO
------------------------------------------
--- �������� ----
-- ������������ ������� �������� 32 �������

DROP PROC spFactorial

CREATE PROC spFactorial
@ValueIn int,
@ValueOut int OUTPUT
AS
BEGIN
	DECLARE @InWorking int;
	DECLARE @OutWorking int;
	IF (@ValueIn != 1)
	BEGIN
		SET @InWorking = @ValueIn -1;
		EXEC spFactorial @InWorking, @OutWorking OUTPUT; -- ����� ��������� �� ����� ���� (��������)
		SET @ValueOut = @ValueIn * @OutWorking;
	END
	ELSE
		SET @ValueOut = 1;
END;
GO
-------------------------------------------

DECLARE @MyVarOut int,
		@MyVARIn int;

SET @MyVARIn = 7;
EXEC spFactorial @MyVarIn, @MyVarOut OUTPUT; -- 7!= 1*2*3*4*5*6*7 
PRINT CAST(@MyVARIn as varchar) + ' ���������: ' + CAST(@MyVarOut as varchar);
GO

----------------------
-- ������. �� ������� ��������� �������� ���� ��������������� ��� ����������!

DECLARE @MyVarOut int,
		@MyVARIn int;

SET @MyVARIn = 13;
EXEC spFactorial @MyVarIn, @MyVarOut OUTPUT; -- 13!= 1*2*3*4*5*6*7*8*9*10*11*12*13
PRINT CAST(@MyVARIn as varchar) + ' ���������: ' + CAST(@MyVarOut as varchar);


----��������� ����������� ������ � ������� -----
DROP PROC uspLogError;
GO

DROP TABLE ErrorLog2

CREATE TABLE ErrorLog2
(
	ErrorId int IDENTITY,
	ErrorLine int,
	ErrorMessage varchar(200)
)
GO

-- ������� ��������� ����������� ������

CREATE PROC uspLogError
	@ErrorLogId int = 0 OUTPUT
AS
BEGIN
	INSERT dbo.ErrorLog2 -- ������ ������ �� ������.
		(
			ErrorLine,
			ErrorMessage
		)	
		VALUES
		(
			ERROR_LINE(),
			ERROR_MESSAGE()
		)
	SET @ErrorLogId = @@IDENTITY; -- @@IDENTITY ���������� ����� ���������� �������������� ����������� � �������.
END;
------------------------------------------------

BEGIN TRY
	
	CREATE TABLE OurTest
	(
		col int
	)
	
END TRY
BEGIN CATCH
	
	DECLARE @OutIdError int;
	
	IF ERROR_NUMBER() = 2714
	BEGIN
		PRINT '������� ������� ������������ �������';
		EXEC uspLogError @OutIdError OUTPUT;
		PRINT '������ �������� � ������ ����� ������: ' + CAST(@OutIdError as varchar);
	END
	
	ELSE
	  PRINT '�� ��������� ������ ';
	  
END CATCH

SELECT * FROM ErrorLog2
GO
