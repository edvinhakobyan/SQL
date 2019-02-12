-- ����� ��������� ����� ���� ����, �������������
-- �������������� ������������� �� ���� master.
USE master;
GO

-- �������� DROP DATABASE ������� ����������
DROP DATABASE  ShopDB;
GO

-------------------------------------------------------------------------
					 /* �������� ���� ������*/
-------------------------------------------------------------------------

CREATE DATABASE ShopDB    
ON							  
(
	NAME = 'ShopDB',            
	FILENAME = 'D:\ShopDB.mdf', 
	SIZE = 10MB,                    
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB				
)
LOG ON						  
( 
	NAME = 'LogShopDB',            
	FILENAME = 'D:\LogShopDB.ldf', 
	SIZE = 5MB,                        
	MAXSIZE = 50MB,                    
	FILEGROWTH = 5MB                   
)   
COLLATE Cyrillic_General_CI_AS -- ������ ��������� ��� ���� ������ �� ���������

-------------------------------------------------------------------------
					 /* ��������� ���� ������*/
-------------------------------------------------------------------------

EXEC sp_helpdb ShopDB

ALTER DATABASE ShopDB   -- �������� ALTER DATABASE �������� ��
MODIFY FILE			    -- ��������� ������� ��
( NAME = 'ShopDB',
  SIZE = 100MB )
GO
  
 ALTER DATABASE ShopDB	-- �������� ALTER DATABASE �������� ��
 MODIFY FILE				
( NAME = 'ShopDB',
  MAXSIZE = 1000MB,			-- ��������� ������������� ������� �� 
  FILEGROWTH = 20% )	    -- � ��������� ���������� ������� ��
  -- ���� FILEGROWTH �������� � ���������, �� ������� ��������� �� �������� ������� �� (FILEGROWTH = 0,2*SIZE). 
GO

ALTER DATABASE ShopDB
 MODIFY FILE				
( 
  NAME = 'ShopDB',
  MAXSIZE = 10MB		  -- ���������� ������������ ������ �� ����� ���� ������ �������� ������� �� 
)	  
GO

ALTER DATABASE ShopDB   
MODIFY FILE					
( NAME = 'ShopDB',
  SIZE = 100MB )		  -- �� ����������� �������� ������ �� ������ ��� ������ ��������.
GO

EXEC sp_helpdb ShopDB