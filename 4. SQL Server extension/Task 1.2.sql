--1
SELECT
		'����������' AS [���������� �������� �� ���������],
		����������,
		������,
		�����
FROM
		(
		SELECT predmet, fio
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			COUNT(fio)
			FOR predmet IN (����������, ������, �����)
		)
		AS PIVOT_TABLE

--2
SELECT
		ush,
		����������,
		������,
		�����
FROM
		(
		SELECT ush, predmet, fio
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			COUNT(fio)
			FOR predmet IN (����������, ������, �����)
		)
		AS PIVOT_TABLE


--3
SELECT
		fio,
		[������� ��� �����]
FROM Table_uch
UNPIVOT
	(
		[������� ��� �����]
		FOR �������� IN (ush, predmet)
	)
	AS unpvt

--4
SELECT
		'������� ����' AS [������� ���� �� ������],
		��������,
		�����
FROM
		(
		SELECT ush, ball
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			AVG(ball)
			FOR ush IN (��������, �����)
		)
		AS PIVOT_TABLE

--5
SELECT
		predmet,
		��������,
		�����
FROM
		(
		SELECT predmet, ush, ball
		FROM Table_uch
		)
		AS SOURCE_TABLE
		PIVOT
		(
			AVG(ball)
			FOR ush IN (��������, �����)
		)
		AS PIVOT_TABLE

--6
SELECT
		[���, ����� � �������]
FROM Table_uch
UNPIVOT
	(
		[���, ����� � �������]
		FOR �������� IN (fio, ush, predmet)
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

