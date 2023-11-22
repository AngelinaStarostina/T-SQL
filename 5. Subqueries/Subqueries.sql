use Ucheb_7_Starostina;

--Вывести список стран и процентное соотношение площади каждой из
--них к общей площади всех стран мира. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent,
		ROUND(CAST(PL AS FLOAT) * 100 / 
		(SELECT SUM(PL)
		FROM Tabl_Kontinent), 3) AS Процент
FROM Tabl_Kontinent
ORDER BY Процент DESC;

--Вывести список стран мира, плотность населения которых больше, чем средняя плотность населения всех стран мира. 

SELECT Nazvanie,
		Stolica,
		KolNas / PL AS плотность_населения,
		Kontinent
FROM Tabl_Kontinent
WHERE KolNas / PL > (SELECT AVG(KolNas / PL) FROM Tabl_Kontinent);

--С помощью подзапроса вывести список европейских стран, население которых меньше 5 млн. чел. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM (SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
	FROM Tabl_Kontinent
	WHERE Kontinent = 'Европа') A
WHERE KolNas < 5000000;

--Вывести список стран и процентное соотношение их площади к суммарной площади той части мира, где они находятся. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent,
		ROUND(CAST(PL AS FLOAT) * 100 / 
		(SELECT SUM(PL)
		FROM Tabl_Kontinent B
		WHERE A.Kontinent = B.Kontinent), 3) AS Процент
FROM Tabl_Kontinent A
ORDER BY Процент DESC;

--Вывести список стран мира, площадь которых больше, чем средняя площадь стран той части света, где они находятся. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent A
WHERE PL > (SELECT AVG(PL) FROM Tabl_Kontinent B 
				WHERE B.Kontinent = A.Kontinent);

--Вывести список стран мира, которые находятся в тех частях света, средняя плотность населения которых превышает общемировую. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent IN
					(SELECT Kontinent
					FROM Tabl_Kontinent
					GROUP BY Kontinent
					HAVING AVG(PL) >
									(SELECT AVG(PL)
									FROM Tabl_Kontinent));

--Вывести список южноамериканских стран, в которых живет больше людей, чем в любой африканской стране. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = 'Южная Америка' AND KolNas > ALL
					(SELECT KolNas
					FROM Tabl_Kontinent
					WHERE Kontinent = 'Африка');

--Вывести список африканских стран, в которых живет больше людей, чем хотя бы в одной южноамериканской стране. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = 'Африка' AND KolNas > ANY
					(SELECT KolNas
					FROM Tabl_Kontinent
					WHERE Kontinent = 'Южная Америка');

--Если в Африке есть хотя бы одна страна, площадь которой больше 2 млн. кв. км, вывести список всех африканских стран. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = 'Африка' AND EXISTS
					(SELECT *
					FROM Tabl_Kontinent
					WHERE Kontinent = 'Африка'
					AND PL > 2000000);

--Вывести список стран той части света, где находится страна «Фиджи»

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = 
				(SELECT Kontinent
				FROM Tabl_Kontinent
				WHERE Nazvanie = 'Фиджи');

--Вывести название страны с наибольшим населением среди стран с наименьшей площадью на каждом континенте.

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE KolNas = 
				(SELECT MAX(KolNas)
				FROM Tabl_Kontinent
				WHERE PL IN
					(SELECT MIN(PL)
					FROM Tabl_Kontinent
					GROUP BY Kontinent));