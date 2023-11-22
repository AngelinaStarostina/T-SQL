USE Ucheb_7_Starostina

--1.1
SELECT predmet, ush, COUNT(fio) AS kol
FROM Table_uch
GROUP BY predmet, ush;

--1.2
SELECT predmet, ush, COUNT(fio) AS kol
FROM Table_uch
GROUP BY predmet, ush WITH ROLLUP;

--2.1
SELECT predmet, ush, COUNT(fio) AS kol
FROM Table_uch
GROUP BY predmet, ush;

--2.2
SELECT predmet, ush, COUNT(fio) AS kol
FROM Table_uch
GROUP BY predmet, ush WITH CUBE;

--3
SELECT predmet, ush, COUNT(fio) AS kol
FROM Table_uch
GROUP BY GROUPING SETS(predmet, ush);

--4
SELECT COALESCE(predmet, 'ИТОГО') AS predmet,
		COALESCE(ush, 'ИТОГО') AS ush,
		COUNT(fio) AS kol
FROM Table_uch
GROUP BY ROLLUP(predmet, ush);

--5
SELECT IIF(GROUPING(predmet)=1, 'ИТОГО', predmet) AS predmet,
		IIF(GROUPING(ush)=1, 'Итого', ush) AS ush,
		COUNT(fio) AS kol
FROM Table_uch
GROUP BY CUBE(predmet, ush);

--6
SELECT CASE GROUPING_ID(predmet, ush)
			WHEN 1 THEN 'Итого по предметам'
			WHEN 3 THEN 'Итого'
			ELSE ''
		END AS Итого,
		ISNULL(predmet, '') AS predmet,
		ISNULL(ush, '') AS ush,
		COUNT(fio) AS kol
FROM Table_uch
GROUP BY ROLLUP(predmet, ush);

--1
SELECT predmet, ush, MAX(ball) AS max_ball
FROM Table_uch
GROUP BY predmet, ush WITH ROLLUP;

--2
SELECT predmet, ush, MIN(ball) AS min_ball
FROM Table_uch
GROUP BY predmet, ush WITH CUBE;

--3
SELECT predmet, ush,  AVG(ball) AS avg_ball
FROM Table_uch
GROUP BY GROUPING SETS(predmet, ush);

--4
SELECT COALESCE(ush, 'ИТОГО') AS ush,
		COALESCE(predmet, 'ИТОГО') AS predmet,
		COUNT(fio) AS kol
FROM Table_uch
GROUP BY ROLLUP(ush, predmet);

--5
SELECT IIF(GROUPING(ush)=1, 'ИТОГО', ush) AS ush,
		IIF(GROUPING(predmet)=1, 'Итого', predmet) AS predmet,
		SUM(ball) AS sum_ball
FROM Table_uch
GROUP BY CUBE(ush, predmet);

--6
SELECT CASE GROUPING_ID(ush, predmet)
			WHEN 1 THEN 'Итого по школам'
			WHEN 3 THEN 'Итого'
			ELSE ''
		END AS Итого,
		ISNULL(ush, '') AS ush,
		ISNULL(predmet, '') AS predmet,
		MAX(ball) AS max_ball
FROM Table_uch
GROUP BY ROLLUP(ush, predmet);