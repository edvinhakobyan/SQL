USE AdventureWorks2012;
GO
-- ���� �������� ��� �������� ������ ���������.
SET ANSI_NULLS ON  --  ���� SET ANSI_NULLS ����������� � ON, ����� ���������� SELECT, ������������ ����������� WHERE column_name = NULL, �� ������ �� ����� ������, ���� ���� � ������� column_name ���� �������� NULL.
GO
-- ���� ��������� SET ARITHABORT � SET ANSI WARNINGS ����������� � �������� ON, 
-- ��� ������� ������ �������� � ���������� �������. ���� �������� SET ARITHABORT ���������� � �������� ON, 
-- � �������� SET ANSI WARNINGS ���������� � �������� OFF, �� ��� ������� ������ �������� � ���������� ������.
SET ARITHABORT ON -- ���� ��� ���������� ���������� ��������� ������, �� ��� ���� ���������� ����������� �����.
GO
SET CONCAT_NULL_YIELDS_NULL ON -- ����� �������� SET CONCAT_NULL_YIELDS_NULL ���������� � ON, ����������� �������� NULL �� ������� ���� � ���������� NULL. 
GO
SET QUOTED_IDENTIFIER ON -- ���� ��������� SET QUOTED_IDENTIFIER ��������� �������� ON, �� �������������� ����� ��������� � ������� ������� � �������� ������ ���� ��������� ���������� ���������.
GO
SET ANSI_PADDING ON -- �������, ������������ ������ ������ char, varchar, binary � varbinary, ����� ������������ ������.
GO
SET ANSI_WARNINGS ON -- ���� �������� NULL ���������� � ���������� ��������, ����� ��� SUM, AVG, MAX, MIN, STDEV, STDEVP, VAR, VARP ��� COUNT, �� ��� ��������� �������� ON ����������� ��������������� ���������. 
GO
-- ���� �������� SET NUMERIC_ROUNDABORT ����� �������� ON, ����� ������ �������� � ��������� ����������� ������.
-- ���� ������ �������� OFF, ������ �������� �� �������� � ������������ ��������� �� �������, � ��������� ����������� � ��������� ������� ��� ����������, � ������� ����� ��������. 
SET NUMERIC_ROUNDABORT OFF 
GO
-- http://msdn.microsoft.com/ru-ru/library/ms188048.aspx
--------------------------------------------------------------------------
DROP TRIGGER Sales.SaleaOrderDetailNotDiscontinued; -- �������� ��������.
GO
--------------------------------------------------------------------------
-- ������� - ��� ���������� ������� ����� ��������� �� ����� ���������� �������� - INSERT, UPDATE, DELETE.
-- ������ � ��������� �������� ��������� ��������� ��� ��������� �������: Inserted � deleted

CREATE TRIGGER Sales.SaleaOrderDetailNotDiscontinued
	ON Sales.SalesOrderDetail
	FOR INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT *
		FROM Inserted as i -- ������ ����������� ������������� � ������� Sales.SalesOrderDetail(inserted - ���������� ������� ������� ��� �������� ������ ������� ���� ����������� � ��� ������� ���������� �������� ����� ����������� � ������� Sales.SalesOrderDetail)
		JOIN Production.Product p
		ON i.ProductID = p.ProductID
		  WHERE p.DiscontinuedDate IS NOT NULL -- ��������� ���� �� ���� ������ � �������
	)
BEGIN
	RAISERROR('����� ���������� �� ������!', 1, 16); -- ������� ������ ���� ����� ��� ���� � �������
	ROLLBACK TRAN
END
GO

SELECT * FROM Production.Product WHERE ProductID = 706;

UPDATE Production.Product -- ������� ����������� ������ ��� ������� ���� ������ � ������� ��� ��� � ������� Production.Product ������� ������ ����
SET DiscontinuedDate = '01-03-2011'
WHERE ProductID = 940;

SELECT * FROM Sales.SalesOrderDetail;

INSERT INTO Sales.SalesOrderDetail -- ���������� �������� ���� ����� c ������� ID �������� 940
VALUES
(43659,'4911-403C-98',1,940,1,6.45,0.00,NEWID(),GETDATE());

INSERT INTO Sales.SalesOrderDetail -- ���������� �������� ���� ����� c ������� ID �������� 706
VALUES
(43659,'4911-403C-98',1,706,1,6.45,0.00,NEWID(),GETDATE());

------------------------------------------------------------------------------------------------------
--- ���������� �������� ��� �������� ������ (���������) ���������� ---
--������ ���������� - �������� ��������� ������������ �������� ������������ �����������.
SELECT * FROM Production.ProductInventory
GO

DROP TRIGGER Production.ProductIsRationed
GO

CREATE TRIGGER Production.ProductIsRationed
	ON Production.ProductInventory
	FOR UPDATE
AS
IF EXISTS
(
	SELECT * 
	FROM inserted i
	JOIN deleted d
		ON d.ProductID = i.ProductID 
		 AND d.LocationID=i.LocationID
	WHERE (d.Quantity - i.Quantity) > d.Quantity/2 --��������� ������ ���������� (������� ����� ������� ����������� ������ � ������� ��������� ����� �������)
		 AND d.Quantity - i.Quantity > 0
)
BEGIN
	RAISERROR('�� �������� �������� ������ 50 ��������� �� ����������� ���������� ������� ',1,2)	
	ROLLBACK TRAN
END
GO

SELECT * FROM Production.ProductInventory WHERE ProductID = 4 AND LocationID = 6

UPDATE Production.ProductInventory
SET Quantity = 200 -- �������� ������� 422-200 = 222-������ 50% ���������
WHERE ProductID = 4
	AND LocationID = 6
	
UPDATE Production.ProductInventory
SET Quantity = 222 -- �������� ������� 422-222 = 200- ������ 50% ���������
WHERE ProductID = 4
	AND LocationID = 6
	
UPDATE Production.ProductInventory
SET Quantity = 422 
WHERE ProductID = 4
	AND LocationID = 6
GO
---------------------------------------------------------------------
---������ �������� �������� �� ������� ��� ��� ��������---
ALTER TABLE Production.ProductInventory
DISABLE TRIGGER ALL ; -- ��������� �������
GO

UPDATE Production.ProductInventory
SET Quantity = 200 --�������� ������� 422-200 = 222-������ 50% ���������
WHERE ProductID = 4
	AND LocationID = 6
GO
	
UPDATE Production.ProductInventory
SET Quantity = 422 
WHERE ProductID = 4
	AND LocationID = 6
GO

ALTER TABLE Production.ProductInventory
ENABLE TRIGGER ALL ; -- �������� ������
GO

UPDATE Production.ProductInventory
SET Quantity = 200 --�������� ������� 422-200 = 222-������ 50% ���������
WHERE ProductID = 4
	AND LocationID = 6
GO
---Production.ProductIsRationed - ���������� ��������� �� �� �������������! --
------------------------------------------------------------------------------

---- ��������� ���: -----
ALTER TRIGGER Production.ProductIsRationed -- ALTER TRIGGER ��������� �������� ������������ ������ �� ������ ���
		ON Production.ProductInventory
	FOR UPDATE 
AS
	IF UPDATE(Quantity) -- ������� UPDATE() - ���������� TRUE ��� FALSE � ����������� �� ���� �������������� �� ���������� ����������� �������.
	BEGIN
		IF EXISTS
		(
			SELECT * 
			FROM inserted i
			JOIN deleted d
				ON d.ProductID = i.ProductID 
				 AND d.LocationID=i.LocationID
			WHERE (d.Quantity - i.Quantity) > d.Quantity/2 --��������� ������ ���������� (������� ����� ������� ����������� ������ � ������� ��������� ����� �������)
				 AND d.Quantity - i.Quantity > 0
		)
		BEGIN
			RAISERROR('�� �������� �������� ������ 50 ��������� �� ����������� ���������� ������� ',1,16)	
			ROLLBACK TRAN
		END
	END
GO
