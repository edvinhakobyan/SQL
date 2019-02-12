USE ShopDB
GO	
---------- ������� ������� �����������. ----------
CREATE TABLE MyEmployee
(
  EmployeeID int NOT NULL,
  ManagerID int NULL REFERENCES MyEmployee(EmployeeID), -- ��������� ���� ����������� ������ ���������.
  JobTitle nvarchar(50) NOT NULL,
  LastName nvarchar(50) NOT NULL,
  FirstName nvarchar(50) NOT NULL,
    CONSTRAINT PK_Employee2_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
);
GO

-- ������������� ������ (��� ��� ������� �������� ���������� � ����������� ������������� ����������� ���������� � ������� ��� �� �������� � ���� �������)
INSERT INTO MyEmployee(EmployeeID,ManagerID,JobTitle,LastName,FirstName)
VALUES
  (1, NULL, '����������� ��������','�������', '������'),
  (2, 1, '���������� ��������', '��������', '�������'),	
  (3, 1, '�������� ���������','��������','��������'),		
  (4, 1, '�������������� ��������', '����������', '������'),
  (5, 4, '�������', '��������', '�������'),			
  (8, 5, '�������', '�����', '������'),			
  (9, 5, '�����������', '�����', '�����'),				
  (10 ,5, 'Data Architect', '������', '������'),			
  (11 ,5, '����������', '��������', '������'),				
  (6, 4, '������������ ���������', '��������', '����'),	
  (7, 4, '��������� ������','��������','�����');				

SELECT * FROM MyEmployee;

-- ������ ��� ����������� ��������������� ���������.
SELECT  sub.EmployeeID,
		sub.FirstName,
		sub.LastName
FROM
	MyEmployee as boss
	JOIN
	MyEmployee as sub
	ON boss.EmployeeID = sub.ManagerID
WHERE boss.JobTitle LIKE '�������������� ��������';
GO

-- ����������� ������� ������ ���� �����������.

CREATE FUNCTION fnGetSub (@EmployeeId int) -- ������� ������� � ����� ����������.
RETURNS @Sub TABLE  -- �������� ������������ �������.
		(
			EmployeeId int,
			SubId int,
			Name varchar (90)
		)
AS
BEGIN
	DECLARE @EmpId int;

INSERT @Sub -- �������� ������ � ������������ � �������� �������.
	SELECT EmployeeID, ManagerID ,FirstName+' '+LastName
	FROM MyEmployee
	WHERE EmployeeID = @EmployeeId;

SET @EmpId = (SELECT MIN(EmployeeID) -- ���������� ������� �����������.
			  FROM MyEmployee
			  WHERE ManagerID = @EmployeeId);
			  
-- ���� ����� ���� �� ������� � ����������� ����������� WHILE			  
WHILE @EmpId IS NOT NULL -- ���� ���� ����������� ��������� ����.
BEGIN
	INSERT @Sub -- ��������� ������ � ����������� ������������ ���� ��������� ������������.
		SELECT * FROM dbo.fnGetSub(@EmpId) -- ��������.

	SET @EmpId =(SELECT MIN(EmployeeID) -- ���������� ���������� ������������.
				 FROM MyEmployee
				 WHERE EmployeeID > @EmpId
					   AND
					   ManagerID = @EmployeeId);
END;
RETURN; -- ���� �� ������� ������������ ������� �� � RETURN �� ����������� �������� ��������, ����� ��������� ������.
END;
GO

SELECT * FROM dbo.fnGetSub(4); -- ������������� ��� ������ �������� - fnGetSub.
SELECT * FROM MyEmployee;
drop function fnGetSub 