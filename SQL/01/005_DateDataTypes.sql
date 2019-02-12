--***************************************************************************
--                    ���� ������ ���� � ������� � T-SQL
--***************************************************************************

------------------------------------ DateTime -------------------------------

-- ���� ������ ���� � ������� DateTime. 
-- �������� �������� �� 1 ������ 1753 ���� �� 31 ������� 9999 ����.

PRINT 'DateTime'

-- CAST (expression AS data_type) - ��� ������� �������������� �����,
-- ����������� �������� expression � ����  data_type.

DECLARE @datetime DateTime = CAST('2007-05-08 12:35:29.123' AS DateTime);
PRINT @datetime;  

SET @datetime = CURRENT_TIMESTAMP; -- ������� ���� � �����
PRINT @datetime;

------------------------------------ DateTime2 ------------------------------

-- ���� ������ ���� � ������� DateTime2. 
-- �������� �������� �� 1 ������ 1 ���� �� 31 ������� 9999 ����.

-- ���� ������ ���� � ������� ������������ ��� DateTime2(n), 
-- ��� n - ���������� �������� �� 100�� ( 0<n<7 )

PRINT 'DateTime2';

DECLARE @datetime2 DateTime2(5) = CAST('2007-05-08 12:35:29.1234567' AS DateTime2)
PRINT @datetime2;  

SET @datetime2 = CURRENT_TIMESTAMP; -- ������� ���� � �����
PRINT @datetime2;


-------------------------------- SmallDateTime ------------------------------

-- ���� ������ ���� � ������� SmallDateTime. 
-- �������� �������� �� 1 ������ 1900 ���� �� 6 ���� 2079 ����.

PRINT 'SmallDateTime';

DECLARE @smalldatetime SmallDateTime = CAST('2007-05-08 12:35:29' AS SmallDateTime)
PRINT @smalldatetime;  

SET @smalldatetime = CURRENT_TIMESTAMP; -- ������� ���� � �����
PRINT @smalldatetime;

-------------------------------- DateTimeOffSet ------------------------------

-- ���� ������ ���� � ������� DateTimeOffSet.
-- ���������� ����, ������������ �� �������� ���, � ������ �������� ����� � 24-������� �������. 
-- �������� �������� �� 1 ������ 1 ���� �� 31 ������� 9999 ����.

-- ���� ������ ���� � ������� ������������ ��� DateTimeOffSet(n), 
-- ��� n - ���������� �������� �� 100�� ( 0<n<7 )

PRINT 'DateTimeOffSet';

DECLARE @dateTimeOffSet DateTimeOffSet(5) = CAST('2007-05-08 12:35:29.1234567 +12:15' AS DateTimeOffSet)
PRINT @dateTimeOffSet;  

SET @dateTimeOffSet = CURRENT_TIMESTAMP; -- ������� ���� � �����
PRINT @dateTimeOffSet;

------------------------------------ Date -----------------------------------

-- ���� ������ ���� Date. 
-- �������� �������� �� 1 ������ 1 ���� �� 31 ������� 9999 ����.

PRINT 'Date';

DECLARE @date Date = CAST('2007-05-08 12:35:29.1234567' AS Date)
PRINT @date;  

SET @date = CURRENT_TIMESTAMP; -- ������� ���� � �����
PRINT @date;

------------------------------------ Time -----------------------------------

-- ���� ������ ������� Time. 
-- ���� ������ ������� ������������ ��� Time(n), 
-- ��� n - ���������� �������� �� 100�� ( 0<n<7 )

PRINT 'Time';

DECLARE @time Time(5) = CAST('2007-05-08 12:35:29.1234567' AS Time);
PRINT @time;  

SET @time = CURRENT_TIMESTAMP; 
PRINT @time;

-----------------------------------------------------------------------------