use Ucheb_7_Starostina;

--1. Вывести объединенный результат выполнения запросов, которые выбирают страны с площадью меньше 500 кв. км
--и с площадью больше 5 млн. кв. км:

SELECT 
		Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE PL < 500
	UNION
SELECT 
		Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE PL > 5000000;

-- 2. Вывести список стран с площадью больше 1 млн. кв. км, исключить страны с населением меньше 100 млн. чел.

SELECT 
		Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE PL > 1000000
	EXCEPT
SELECT 
		Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE KolNas < 100000000;


--3. Вывести список стран с площадью меньше 500 кв. км и с населением меньше 100 тыс. чел.

SELECT 
		Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE PL < 500
	INTERSECT
SELECT 
		Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE KolNas < 100000;