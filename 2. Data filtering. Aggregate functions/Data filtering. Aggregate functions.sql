--1
SELECT FIO, spez, Data FROM student;

--2
SELECT 
	FIO + ' поступил в ' + CAST(godpost AS nvarchar(max))
	AS [О поступлении]
	FROM student;

--3
SELECT FIO,
[Через 5 лет после поступления] = godpost + 5
	FROM student;

--4
SELECT DISTINCT godpost, FIO FROM student;

--5
SELECT * FROM student ORDER BY Data DESC;

--6
SELECT * FROM student ORDER BY spez DESC, godpost DESC, FIO ASC;

--7
SELECT TOP 1 * FROM student ORDER BY FIO ASC;

--8
SELECT TOP 1 FIO FROM student ORDER BY godpost;

--9
SELECT TOP 10 PERCENT * FROM student ORDER BY FIO;

--10
SELECT TOP 5 WITH TIES * FROM student ORDER BY godpost;

--11
SELECT * FROM student ORDER BY Data OFFSET 5 ROWS;

--12
SELECT * FROM [Ucheb_7_Starostina].[dbo].[student] ORDER BY FIO OFFSET 6 ROWS FETCH NEXT 1 ROWS ONLY;

--13
SELECT * FROM [Ucheb_7_Starostina].[dbo].[student] ORDER BY FIO OFFSET 4 ROWS FETCH NEXT 5 ROWS ONLY;

--Выборка с добавлением
SELECT
FirstName + ' ' + MiddleName + ' ' + LastName AS FIO,
EmailAddress
INTO Fio_Email
FROM [AdventureWorksDW2019].[dbo].[DimCustomer];

--Сортировка
SELECT LastName, EmailAddress, EnglishEducation  
FROM [AdventureWorksDW2019].[dbo].[DimCustomer]
ORDER BY EnglishEducation;

SELECT LastName, EmailAddress, EnglishEducation  
FROM [AdventureWorksDW2019].[dbo].[DimCustomer]
ORDER BY EnglishEducation DESC, LastName ASC;

SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS FIO, EmailAddress, EnglishEducation  
FROM [AdventureWorksDW2019].[dbo].[DimCustomer]
ORDER BY FIO DESC;

--1
SELECT * FROM Products WHERE Manufacturer = 'Samsung';

--2
SELECT * FROM Products WHERE Price > 45000;

--3
SELECT * FROM Products WHERE Price * ProductCount > 200000;

--4
SELECT * FROM Products WHERE Manufacturer = 'Samsung' AND Price  > 50000;

--5
SELECT * FROM Products WHERE Manufacturer = 'Samsung' OR Price  > 50000;

--6
SELECT * FROM Products WHERE Manufacturer != 'Samsung';

--7
SELECT * FROM Products WHERE ProductCount > 2 AND (Price > 30000 OR Manufacturer = 'Samsung');

--8
SELECT * FROM Products WHERE Manufacturer = 'Samsung' OR Manufacturer = 'Xiaomi' OR Manufacturer = 'Huawei';

--9
SELECT * FROM Products WHERE Price BETWEEN 20000 AND 40000;

--10
SELECT * FROM Products WHERE Price * ProductCount BETWEEN 100000 AND 200000;

---1
SELECT MIN(PL) AS min_PL FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent];

--2
SELECT MAX(KolNas) AS max_KolNas 
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent]
WHERE Kontinent = 'Северная Америка' OR  Kontinent = 'Южная Америка';

--3
SELECT ROUND(AVG(CAST(KolNas AS FLOAT)), 1) AS sum_KolNas 
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent];

--4
SELECT COUNT(*) AS Kol 
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent]
WHERE RIGHT(Nazvanie, 2) = 'ан' AND RIGHT(Nazvanie, 4) = 'стан';

--5
SELECT COUNT(DISTINCT Kontinent) AS Kol 
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent]
WHERE LEFT(Nazvanie, 1) = 'Р';

--6
SELECT MAX(PL) / MIN(PL) AS min_max_PL
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent];

--7
SELECT COUNT(*) AS count_S
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent]
WHERE KolNas > 100000000
GROUP BY Kontinent;

--8
SELECT LEN(Nazvanie) AS Кол_Букв, 
	COUNT(Nazvanie) AS Кол_Стран 
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent] 
GROUP BY LEN(Nazvanie) 
ORDER BY Кол_Букв DESC;

--9
SELECT Kontinent, 
		FLOOR(SUM(KolNas) * 1.1) AS Sum_Nas
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent] 
GROUP BY Kontinent;

--10
SELECT Kontinent
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent] 
GROUP BY Kontinent
HAVING MAX(PL) <= 10000.0 * MIN(PL);

--11
SELECT AVG(CAST(LEN(Nazvanie) AS FLOAT)) AS Длина_Названия
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent] 
WHERE Kontinent = 'Африка';

--12
SELECT Kontinent,
		AVG(CAST(KolNas AS FLOAT) / PL) AS Plotn
FROM [Ucheb_7_Starostina].[dbo].[Tabl_Kontinent] 

--13
WHERE KolNas > 1000000
GROUP BY Kontinent
HAVING AVG(CAST(KolNas AS FLOAT) / PL) > 30;