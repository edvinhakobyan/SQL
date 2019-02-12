USE ShopDB;
GO
--------------------------------------------------------------------------
--                     ������� ������. ������ SELECT 
--------------------------------------------------------------------------

-- ���������� ������� ���� ������ �� ������� MyFriends.
SELECT * FROM MyFriends; 

-- ���������� ������� ������ �� ������� FstName, ������� MyFriends
SELECT FstName FROM MyFriends; 

-- ���������� ������� ������ �� ������� LstName, ������� MyFriends
SELECT LstName FROM MyFriends; 

SELECT BthDate FROM MyFriends; 

-- ���������� ������� ������ �� �������� FstName � LstName, ������� MyFriends
SELECT FstName, LstName FROM MyFriends; 

-- ���������� ������� ������ �� �������� FstName, LstName � BthDate, ������� MyFriends
SELECT FstName,LstName,BthDate FROM MyFriends; 

--------------------------------------------------------------------------

USE AdventureWorks2012;
GO

/* 
   ����� �� ������� CreditCard ����: 
   ����� ��������� ����, 
   ������� ����, 
   ������ �� �������� ������������� �����, � 
   ���� �� �������� ������������� ����� 
*/

SELECT CardType, CardNumber, ExpMonth, ExpYear FROM Sales.CreditCard; -- Sales - �����

--------------------------------------------------------------------------
--                         ����������� WHERE. 
--------------------------------------------------------------------------

-- ���������� ������� ���� ������ �� ������� CreditCard, ��� �������� ����� ������� CreditCardID ����� 10.
SELECT * FROM Sales.CreditCard 
WHERE CreditCardID = 10; -- � ����������� WHERE ��������� �������� ��������� (=)

-- ���������� ������� ���� ������ �� ������� CreditCard, ��� �������� ����� ������� CreditCardID ������ 10.
SELECT * FROM Sales.CreditCard 
WHERE CreditCardID < 10; -- � ����������� WHERE ��������� �������� ��������� (<)

-- ���������� ������� ���� ������ �� ������� CreditCard, 
-- ��� �������� ����� ������� CreditCardID ����� � ��������� �� 1 �� 3 (������������).
SELECT * FROM Sales.CreditCard 
WHERE CreditCardID BETWEEN 1 AND 3 -- � ����������� WHERE ��������� �������� �������� ���������.

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� ExpYear ����� 2005 ��� 2006.
SELECT * FROM Sales.CreditCard 
WHERE ExpYear = 2005 OR ExpYear = 2007 -- ���������� �������� "���"

-- ���������� ������� ���� ������ �� ������� CreditCard, 
-- ��� �������� ����� ������� ExpYear ����� � ��������� �� 2005 �� 2006 (������������).
SELECT * FROM Sales.CreditCard 
WHERE ExpYear BETWEEN 2005 AND 2007 -- � ����������� WHERE ��������� �������� �������� ���������.

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� ExpYear ����� 2005 � �������� ����� ������� CardType ����� 'Vista'.
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE ExpYear = 2005 AND CardType = 'Vista' -- ���������� �������� "�"

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� ExpYear �� ����� 2006
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE NOT ExpYear = 2006 -- ���������� �������� "��"

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� CardType ������������� �������	'ColonialVoice'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'ColonialVoice' -- LIKE - �������� �������� ������������ ��������� ������� - 'ColonialVoice'

SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType = 'ColonialVoice'

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� CardType ������������� �������	'Dis%'

SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Dis%' -- ����� ���� ����, ��� ���� ������� ���������� ��  'Dis', 
						   -- ���� % ��������� ������������ ���������� �������� ����� Dis.

SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType = 'Dis%'  -- ������� ������ ������ ��� ������ �������� ��� 'Dis%' ��� � �������
						  
-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� CardType ������������� �������	'Vis__'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Vis__' --_ - ������ ������������� ���������� ����� ���� ������ ����� Vis 

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� CardType ������������� �������	'Vis_'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Vis_' -- ������ ������� ������?

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� CardType ������������� �������	'Vis_�'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Vis_a'

-- ���������� ������� ������ �� �������� CardType � ExpYear, ������� CreditCard,
-- ��� �������� ����� ������� CardType ������������� �������	'%ist%'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE '%ist%'

-- ���������� ������� ���� ������ �� ������� CreditCard, 
-- ��� �������� ����� ������� ExpMonth ��������� ������ �� �������� ���� (1, 5, 11)
SELECT * FROM Sales.CreditCard WHERE ExpMonth IN (1, 5, 11); -- IN (1, 5, 11) ���������� �������� ExpMonth ������ 1 ��� 5 ��� 11 

SeLeCt * from Sales.CreditCard where ExpMonth = 1 or ExpMonth = 5 or ExpMonth = 11;
