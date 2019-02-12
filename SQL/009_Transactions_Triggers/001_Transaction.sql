USE ShopDB;	 
GO
--IF OBJECT_ID('MyUserName') IS NOT NULL
--	DROP TABLE MyUserName;
--GO
-- �������, ���� ���������� ����� �������...
DROP TABLE MyUserName;
GO
DROP TABLE MyUserTell;
GO
DROP TABLE MyUserInfo;
GO
-- ... ������, ����� � ��� ���������?

--- ������� ������� ---
CREATE TABLE MyUserName
(
	IdTest int IDENTITY PRIMARY KEY,
	FName varchar(25),
	LName varchar(25)
)
GO

CREATE TABLE MyUserTell
(
	IdTest int IDENTITY PRIMARY KEY,
	IdUser int FOREIGN KEY REFERENCES MyUserName(IdTest) UNIQUE,
	TellN char(12) 
	CHECK (TellN LIKE ('([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')) -- ��� ��� ������?
)
GO

CREATE TABLE MyUserInfo
(
	IdTest int IDENTITY PRIMARY KEY,
	IdUser int FOREIGN KEY REFERENCES MyUserName(IdTest),
	Bdate date
)
GO

--------------------------------------------------------------------
-------------------------- ���������� ------------------------------
--------------------------------------------------------------------

---------------------------------------------------------
-- �� ��� ������������ ���������� (������)
 BEGIN TRANSACTION; -- ������ ����������
 INSERT MyUserName
 VALUES('TestName0','TestLName0')
 COMMIT TRANSACTION; -- �������� ���������� ����������   
 
 SELECT * FROM MyUserName;
---------------------------------------------------------
 -- ����� ����������
 
 BEGIN TRANSACTION  -- ������ ����������

 INSERT MyUserName
 VALUES
	('RollTest1','RollTestL1')
	
 ROLLBACK TRANSACTION; -- ���������� ����� ����������, ���� ������� �� ����������, ������: 
					   -- INSERT MyUserName VALUES ('TestName1','RollTestL1') ,- �� ���������� 

SELECT * FROM MyUserName;

---------------------------------------------------------
 
-- � ����� ���������� ����� ��������� ��������� ��������

BEGIN TRANSACTION; -- ������ ����������
 
DECLARE @Id int;

INSERT MyUserName
VALUES
	('TestName0','TestLName0')
	
SET @Id = @@IDENTITY;
		
INSERT MyUserTell
VALUES 
(@Id,'(097)2224455');
		
INSERT MyUserInfo
VALUES (@Id,'01/02/1990');

COMMIT TRANSACTION; -- �������� ���������� ����������   
 
SELECT * FROM MyUserName;
SELECT * FROM MyUserInfo;
SELECT * FROM MyUserTell;
GO

---------------------------------------------------------

-- � ����� ���������� ����� "��������" ��������� ��������.

BEGIN TRANSACTION; -- ������ ����������.
 
DECLARE @Id int;

INSERT MyUserName
VALUES
	('RollBackTest','TestLName0')
	
SET @Id = @@IDENTITY; 
		
INSERT MyUserTell
VALUES 
(@Id,'(097)2224455');
		
INSERT MyUserInfo
VALUES (@Id,'01/02/1990');

ROLLBACK TRANSACTION; -- ����� ������������������ �������.

SELECT * FROM MyUserName;
SELECT * FROM MyUserInfo;
SELECT * FROM MyUserTell;
---------------------------------------------------------
-- ����� ���������� ���������� (������������� ���������� ����������)

BEGIN TRAN 

INSERT MyUserName
VALUES
	('SavePoinTest1','TestLName0')
SAVE TRAN SavePointTran; -- ����� ���������� ���������� (������������� ���������� ����������)
PRINT 'SAVE POINT';
INSERT MyUserName
VALUES
	('SavePointTest2','TestLName0')

ROLLBACK TRAN SavePointTran; -- ����� � ����� �������������.

COMMIT TRAN -- ����� ����������� ����� ���������� ���������� ���� �� ����.

SELECT * FROM MyUserName;
GO

---------------------------------------------------------
-- ����� ���������� ���������� (������������� ���������� ����������)

BEGIN TRAN 

INSERT MyUserName
VALUES
	('SavePoinTest3','TestLName0')
SAVE TRAN SavePointTran; -- ����� ���������� ���������� (������������� ���������� ����������)
PRINT 'SAVE POINT';
INSERT MyUserName
VALUES
	('SavePointTest4','TestLName0')

ROLLBACK TRAN -- ���� �� ������� ����� ���������� � ������� ����� ���������� �����, 
			  -- �� ����� ���������� � ������ ����������

SELECT * FROM MyUserName;
GO

---------------------------------------------------------

DROP PROC MyTransactProc;
GO

-- ��������� ������ ������ � ������������ (���, �������, ����� ��������, ���� ��������) , ���� ��������� ������, �������� ����������...
CREATE PROC MyTransactProc
	@FName varchar(25),
	@LName varchar(25),
	@TellN char(12),
	@BDate date
AS
BEGIN
DECLARE @Id int;
BEGIN TRAN -- ������ ����������.
			
		INSERT MyUserName
		VALUES (@FName,@LName);
		SET @Id = @@IDENTITY;
		
		INSERT MyUserTell
		VALUES (@Id,@TellN);
		
		INSERT MyUserInfo
		VALUES (@Id,@BDate);
		
IF EXISTS (SELECT * FROM MyUserName WHERE @FName = FName AND @LName = LName AND IdTest != @Id) -- �������� �� ������� ������ �� ���� ��������.
			BEGIN
				ROLLBACK TRAN; -- ����� ���������� ���� ������� ����������.
				RETURN 1;
			END;	
			
		COMMIT TRAN ; -- �������� ���������� ��������� ���� ������ ������������ ��� �� ������� � ��.
END;	

 -- �������� ����������� ������ ���������. --
EXEC MyTransactProc			  -- ������ ������.
	 @Fname = 'Name1',
	 @LName = 'LName1', 
	 @TellN = '(097)7775566',
	 @BDate = '01/02/2010';
GO

EXEC MyTransactProc			  -- ��������� ������� ������ ��� �� ������.
	 @Fname = 'Name1',
	 @LName = 'LName1', 
	 @TellN = '(097)7775566' ,
	 @BDate = '01/02/2010';
GO

EXEC MyTransactProc				
	 @Fname = 'TestName2',
	 @LName = 'TestLName2', 
	 @TellN = '(097)7775566' ,
	 @BDate = '01/02/2010';
GO

SELECT * FROM MyUserName;
SELECT * FROM MyUserInfo;
SELECT * FROM MyUserTell;