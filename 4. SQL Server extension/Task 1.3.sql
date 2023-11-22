use Ucheb_7_Starostina

--3.1
SELECT otdel, god, sum(summa) AS sum_oplata
FROM Table_1
GROUP BY otdel, god;

--3.2
SELECT otdel, god, sum(summa) AS sum_oplata
FROM Table_1
GROUP BY ROLLUP(otdel, god);

--3.3
SELECT otdel, sum(summa) AS sum_oplata
FROM Table_1
GROUP BY otdel WITH ROLLUP;

--3.4
SELECT god, sum(summa) AS sum_oplata
FROM Table_1
GROUP BY god WITH ROLLUP;


--4.1
SELECT otdel, god, sum(summa) AS sum_oplata
FROM Table_1
GROUP BY CUBE(otdel, god);

--5.1
SELECT otdel, god, sum(summa) AS sum_oplata
FROM Table_1
GROUP BY GROUPING SETS(otdel, god);

--6
SELECT otdel,
		ISNULL(CAST(god AS VARCHAR(30)),
		CASE
			WHEN GROUPING(god)=1 AND GROUPING(otdel)=0
			THEN 'Промежуточный итог' ELSE 'Общий итог'
			END) AS god,
		SUM(summa) AS itog,
		GROUPING(otdel) AS grouping_otdel,
		GROUPING(god) AS grouping_god
FROM Table_1
GROUP BY ROLLUP(otdel, god);