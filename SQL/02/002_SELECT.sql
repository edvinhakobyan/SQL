USE ShopDB;
GO
--------------------------------------------------------------------------
--                     Выборка данных. Запрос SELECT 
--------------------------------------------------------------------------

-- Производим выборку всех данных из таблицы MyFriends.
SELECT * FROM MyFriends; 

-- Производим выборку данных из столбца FstName, таблицы MyFriends
SELECT FstName FROM MyFriends; 

-- Производим выборку данных из столбца LstName, таблицы MyFriends
SELECT LstName FROM MyFriends; 

SELECT BthDate FROM MyFriends; 

-- Производим выборку данных из столбцов FstName и LstName, таблицы MyFriends
SELECT FstName, LstName FROM MyFriends; 

-- Производим выборку данных из столбцов FstName, LstName и BthDate, таблицы MyFriends
SELECT FstName,LstName,BthDate FROM MyFriends; 

--------------------------------------------------------------------------

USE AdventureWorks2012;
GO

/* 
   Выбор из таблицы CreditCard всех: 
   типов кредитных карт, 
   номеров карт, 
   месяца до которого действительна карта, и 
   года до которого действительна карта 
*/

SELECT CardType, CardNumber, ExpMonth, ExpYear FROM Sales.CreditCard; -- Sales - схема

--------------------------------------------------------------------------
--                         Конструкция WHERE. 
--------------------------------------------------------------------------

-- Производим выборку всех данных из таблицы CreditCard, где значения ячеек столбца CreditCardID равны 10.
SELECT * FROM Sales.CreditCard 
WHERE CreditCardID = 10; -- В конструкции WHERE применена операция сравнения (=)

-- Производим выборку всех данных из таблицы CreditCard, где значения ячеек столбца CreditCardID меньше 10.
SELECT * FROM Sales.CreditCard 
WHERE CreditCardID < 10; -- В конструкции WHERE применена операция сравнения (<)

-- Производим выборку всех данных из таблицы CreditCard, 
-- где значения ячеек столбца CreditCardID лежат в диапазоне от 1 до 3 (включительно).
SELECT * FROM Sales.CreditCard 
WHERE CreditCardID BETWEEN 1 AND 3 -- В конструкции WHERE применена операция проверки диапазона.

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца ExpYear равно 2005 или 2006.
SELECT * FROM Sales.CreditCard 
WHERE ExpYear = 2005 OR ExpYear = 2007 -- Логическая операция "ИЛИ"

-- Производим выборку всех данных из таблицы CreditCard, 
-- где значения ячеек столбца ExpYear лежат в диапазоне от 2005 до 2006 (включительно).
SELECT * FROM Sales.CreditCard 
WHERE ExpYear BETWEEN 2005 AND 2007 -- В конструкции WHERE применена операция проверки диапазона.

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца ExpYear равно 2005 и значения ячеек столбца CardType равно 'Vista'.
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE ExpYear = 2005 AND CardType = 'Vista' -- Логическая операция "И"

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца ExpYear не равно 2006
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE NOT ExpYear = 2006 -- Логическая операция "НЕ"

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца CardType соответствуют шаблону	'ColonialVoice'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'ColonialVoice' -- LIKE - операция проверки соответствия заданному шаблону - 'ColonialVoice'

SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType = 'ColonialVoice'

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца CardType соответствуют шаблону	'Dis%'

SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Dis%' -- Вывод всех карт, имя типа которых начинается на  'Dis', 
						   -- знак % обозначет произвольное количество символов после Dis.

SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType = 'Dis%'  -- Выборка пустая потому что такого значения как 'Dis%' нет в таблице
						  
-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца CardType соответствуют шаблону	'Vis__'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Vis__' --_ - нижнее подчеркивание определяет любой один символ после Vis 

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца CardType соответствуют шаблону	'Vis_'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Vis_' -- почему выборка пустая?

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца CardType соответствуют шаблону	'Vis_а'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE 'Vis_a'

-- Производим выборку данных из столбцов CardType и ExpYear, таблицы CreditCard,
-- где значения ячеек столбца CardType соответствуют шаблону	'%ist%'
SELECT CardType, ExpYear FROM Sales.CreditCard 
WHERE CardType LIKE '%ist%'

-- Производим выборку всех данных из таблицы CreditCard, 
-- где значения ячеек столбца ExpMonth равняются одному из значений ряда (1, 5, 11)
SELECT * FROM Sales.CreditCard WHERE ExpMonth IN (1, 5, 11); -- IN (1, 5, 11) определяет значения ExpMonth равные 1 или 5 или 11 

SeLeCt * from Sales.CreditCard where ExpMonth = 1 or ExpMonth = 5 or ExpMonth = 11;
