--***************************************************************************
--                    Типы данных даты и времени в T-SQL
--***************************************************************************

------------------------------------ DateTime -------------------------------

-- Типы данных даты и времени DateTime. 
-- Диапазон значений от 1 января 1753 года до 31 декабря 9999 года.

PRINT 'DateTime'

-- CAST (expression AS data_type) - это функция преобразования типов,
-- преобразует значение expression к типу  data_type.

DECLARE @datetime DateTime = CAST('2007-05-08 12:35:29.123' AS DateTime);
PRINT @datetime;  

SET @datetime = CURRENT_TIMESTAMP; -- Текущая дата и время
PRINT @datetime;

------------------------------------ DateTime2 ------------------------------

-- Типы данных даты и времени DateTime2. 
-- Диапазон значений от 1 января 1 года до 31 декабря 9999 года.

-- Типы данных даты и времени записывается как DateTime2(n), 
-- где n - определяет точность до 100нс ( 0<n<7 )

PRINT 'DateTime2';

DECLARE @datetime2 DateTime2(5) = CAST('2007-05-08 12:35:29.1234567' AS DateTime2)
PRINT @datetime2;  

SET @datetime2 = CURRENT_TIMESTAMP; -- Текущая дата и время
PRINT @datetime2;


-------------------------------- SmallDateTime ------------------------------

-- Типы данных даты и времени SmallDateTime. 
-- Диапазон значений от 1 января 1900 года до 6 июня 2079 года.

PRINT 'SmallDateTime';

DECLARE @smalldatetime SmallDateTime = CAST('2007-05-08 12:35:29' AS SmallDateTime)
PRINT @smalldatetime;  

SET @smalldatetime = CURRENT_TIMESTAMP; -- Текущая дата и время
PRINT @smalldatetime;

-------------------------------- DateTimeOffSet ------------------------------

-- Типы данных даты и времени DateTimeOffSet.
-- Определяет дату, объединенную со временем дня, с учетом часового пояса в 24-часовом формате. 
-- Диапазон значений от 1 января 1 года до 31 декабря 9999 года.

-- Типы данных даты и времени записывается как DateTimeOffSet(n), 
-- где n - определяет точность до 100нс ( 0<n<7 )

PRINT 'DateTimeOffSet';

DECLARE @dateTimeOffSet DateTimeOffSet(5) = CAST('2007-05-08 12:35:29.1234567 +12:15' AS DateTimeOffSet)
PRINT @dateTimeOffSet;  

SET @dateTimeOffSet = CURRENT_TIMESTAMP; -- Текущая дата и время
PRINT @dateTimeOffSet;

------------------------------------ Date -----------------------------------

-- Типы данных даты Date. 
-- Диапазон значений от 1 января 1 года до 31 декабря 9999 года.

PRINT 'Date';

DECLARE @date Date = CAST('2007-05-08 12:35:29.1234567' AS Date)
PRINT @date;  

SET @date = CURRENT_TIMESTAMP; -- Текущая дата и время
PRINT @date;

------------------------------------ Time -----------------------------------

-- Типы данных времени Time. 
-- Типы данных времени записывается как Time(n), 
-- где n - определяет точность до 100нс ( 0<n<7 )

PRINT 'Time';

DECLARE @time Time(5) = CAST('2007-05-08 12:35:29.1234567' AS Time);
PRINT @time;  

SET @time = CURRENT_TIMESTAMP; 
PRINT @time;

-----------------------------------------------------------------------------