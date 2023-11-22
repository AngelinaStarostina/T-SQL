--1
SELECT
		'Количество' AS [Количество учеников по предметам],
		Математика,
		Физика,
		Химия
FROM
		(
		SELECT predmet, fio
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			COUNT(fio)
			FOR predmet IN (Математика, Физика, Химия)
		)
		AS PIVOT_TABLE

--2
SELECT
		ush,
		Математика,
		Физика,
		Химия
FROM
		(
		SELECT ush, predmet, fio
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			COUNT(fio)
			FOR predmet IN (Математика, Физика, Химия)
		)
		AS PIVOT_TABLE


--3
SELECT
		fio,
		[Предмет или школа]
FROM Table_uch
UNPIVOT
	(
		[Предмет или школа]
		FOR Значение IN (ush, predmet)
	)
	AS unpvt

--4
SELECT
		'Средний балл' AS [Средний балл по школам],
		гимназия,
		лицей
FROM
		(
		SELECT ush, ball
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			AVG(ball)
			FOR ush IN (гимназия, лицей)
		)
		AS PIVOT_TABLE

--5
SELECT
		predmet,
		гимназия,
		лицей
FROM
		(
		SELECT predmet, ush, ball
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			AVG(ball)
			FOR ush IN (гимназия, лицей)
		)
		AS PIVOT_TABLE

--6
SELECT
		[Фио, школа и предмет]
FROM Table_uch
UNPIVOT
	(
		[Фио, школа и предмет]
		FOR Значение IN (fio, ush, predmet)
	)
	AS unpvt

--7.1
CREATE TABLE test_table_pivot(
fio varchar(50) NULL,
god int NULL,
summa float NULL
)

--7.3
SELECT fio, [2011], [2012], [2013], [2014], [2015]
FROM test_table_pivot
PIVOT
	(
		SUM(summa)
		FOR god IN ( [2011], [2012], [2013], [2014], [2015])
	)
	AS test_pivot;

