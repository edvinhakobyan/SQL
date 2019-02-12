USE ShopDB;
GO

INSERT MyFriends 
(FstName, Ntel)
VALUES ('Max', '050*******');
GO

SELECT * FROM MyFriends;

--------------------------------------------------------------------------
--	      Оператор UPDATE (изменение(обновление) данных в таблице)
--------------------------------------------------------------------------

UPDATE MyFriends
SET Ntel = '098*******' -- изменить номер телефона того,
WHERE FstName = 'Max'	-- чье имя 'Max'
GO

SELECT * FROM MyFriends;


-- Возможно изменять значение сразу в нескольких столбцах
UPDATE MyFriends
SET FstName = 'TestName',
	Ntel = '000*******'
WHERE FstName = 'Max'

SELECT * FROM MyFriends;


UPDATE MyFriends
SET Ntel = '060*******' -- Если не задана консрукция WHERE, то изменяется весь столбец на указанное значение
GO

SELECT * FROM MyFriends;


--------------------------------------------------------------------------
--	          Оператор DELETE (удаление данных из таблицы)
--------------------------------------------------------------------------

-- Удалить всех пользователей имя которых TestName
DELETE MyFriends 
WHERE FstName = 'TestName';
SELECT * FROM MyFriends;

-- Удаление всех данных из таблицы с помощью DELETE.
DELETE MyFriends;
SELECT * FROM MyFriends;

-- Для удаления всех данных из таблицы лучше использовать - TRUNCATE TABLE,
-- так как TRUNCATE удаляет информацию из базы быстрее чем стандартный DELETE.
TRUNCATE TABLE MyFriends;
SELECT * FROM MyFriends;