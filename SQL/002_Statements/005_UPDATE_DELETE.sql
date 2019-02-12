USE ShopDB;
GO

INSERT MyFriends 
(FstName, Ntel)
VALUES ('Max', '050*******');
GO

SELECT * FROM MyFriends;

--------------------------------------------------------------------------
--	      �������� UPDATE (���������(����������) ������ � �������)
--------------------------------------------------------------------------

UPDATE MyFriends
SET Ntel = '098*******' -- �������� ����� �������� ����,
WHERE FstName = 'Max'	-- ��� ��� 'Max'
GO

SELECT * FROM MyFriends;


-- �������� �������� �������� ����� � ���������� ��������
UPDATE MyFriends
SET FstName = 'TestName',
	Ntel = '000*******'
WHERE FstName = 'Max'

SELECT * FROM MyFriends;


UPDATE MyFriends
SET Ntel = '060*******' -- ���� �� ������ ���������� WHERE, �� ���������� ���� ������� �� ��������� ��������
GO

SELECT * FROM MyFriends;


--------------------------------------------------------------------------
--	          �������� DELETE (�������� ������ �� �������)
--------------------------------------------------------------------------

-- ������� ���� ������������� ��� ������� TestName
DELETE MyFriends 
WHERE FstName = 'TestName';
SELECT * FROM MyFriends;

-- �������� ���� ������ �� ������� � ������� DELETE.
DELETE MyFriends;
SELECT * FROM MyFriends;

-- ��� �������� ���� ������ �� ������� ����� ������������ - TRUNCATE TABLE,
-- ��� ��� TRUNCATE ������� ���������� �� ���� ������� ��� ����������� DELETE.
TRUNCATE TABLE MyFriends;
SELECT * FROM MyFriends;