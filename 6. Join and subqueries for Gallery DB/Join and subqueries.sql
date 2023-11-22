use Gallery;

--Написать по два запроса на каждое соединение таблиц

--Внутреннее
--1.	Вывести к каким категориям относятся картины
SELECT artist_name, artwork_name, name AS category
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
JOIN Art_group G ON G.id = AG.group_id;

--2.	Вывести для купленных картин владельцев и их адреса
SELECT A.artist_name, A.artwork_name, C.name, C.address
FROM Artwork A
JOIN Client C ON A.client_name = C.name;


--Внешнее левое
--1.	Вывести владельцев и их адреса для всех картин 
SELECT A.artwork_name, C.name, C.address
FROM Artwork A
LEFT OUTER JOIN Client C ON A.client_name = C.name;

--2.	Вывести художников из США, которые нравятся клиентам, и их стиль
SELECT CA.client_name, CA.artist_name, Ac.art_style
FROM ClientArtist CA
LEFT OUTER JOIN Artist Ac ON CA.artist_name = Ac.name
WHERE birthplace = 'США';


--Внешнее правое

--1.	Вывести категории, к которым не относится ни одна картина
SELECT G.name AS category
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
RIGHT OUTER JOIN Art_group G ON G.id = AG.group_id
WHERE artwork_name IS NULL;

--2.	Вывести для клиентов количество приобретенных картин
SELECT C.name, COUNT(*) AS [Количество картин]
FROM Artwork A
RIGHT OUTER JOIN Client C ON A.client_name = C.name
WHERE A.artwork_name IS NOT NULL
GROUP BY C.name;


--Полное внешнее соединение

--1.	Вывести количество художников, которые нравятся клиентам
SELECT COALESCE(client_name, 'ИТОГО'),
		COALESCE(name, 'ИТОГО'),
		COUNT(name) AS [Количество художников]
FROM ClientArtist CA
FULL OUTER JOIN Artist Ac ON CA.artist_name = Ac.name
GROUP BY ROLLUP(client_name, name);

--2.	Вывести сумму, потраченную каждым клиентом
SELECT C.name, COALESCE(SUM(A.price), 0) AS [Потраченная сумма]
FROM Artwork A
FULL OUTER JOIN Client C ON A.client_name = C.name
WHERE C.name IS NOT NULL
GROUP BY C.name;


--Перекрестное соединение

--1.	Вывести декартово произведение произведений искусства и их типов

SELECT artist_name, artwork_name, name AS category
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
CROSS JOIN Art_group G;

--2.	Вывести декартово произведение клиентов и художников

SELECT C.name, A.name
FROM Client C
CROSS JOIN Artist A;



--14. Написать по два запроса:

--На объединение:

--1.	Вывести объединенный результат выполнения запросов, которые выбирают картины написанные до 1980 и после 2005
SELECT artwork_name, year
FROM Artwork
WHERE year < 1980
	UNION
SELECT artwork_name, year
FROM Artwork
WHERE year > 2005;


--2.	Вывести объединенный результат выполнения запросов, которые выбирают художников, чей возраст < 50, и художников из Венгрии

SELECT name, birthplace, age
FROM Artist
WHERE age < 50
	UNION
SELECT name, birthplace, age
FROM Artist
WHERE birthplace = 'Венгрия';


--на разность

--1.	Вывести список картин типа живопись, исключить картины стоимостью > 100000

SELECT artwork_name, price
FROM Artwork
WHERE category = 'Живопись'
	EXCEPT
SELECT artwork_name, price
FROM Artwork
WHERE price > 100000

--2.	Вывести список клиентов потративших в галерее > 100000, исключить клиентов проживающих в Минске

SELECT A.client_name 
FROM Artwork A
JOIN Client C ON A.client_name = C.name
GROUP BY A.client_name
HAVING SUM(A.price) > 100000
	EXCEPT
SELECT C.name
FROM Client C
WHERE C.address NOT LIKE '%Минск%';


-- на пересечение таблиц

--1.	Вывести названия картин, тип которых Произведения 19-го века и цена > 4500000

SELECT A.artwork_name
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
JOIN Art_group G ON G.id = AG.group_id
WHERE G.name = 'Произведения 19-го века'
	INTERSECT
SELECT artwork_name
FROM Artwork
WHERE price > 4500000;

--2.	Вывести клиентов, которым нравятся художники из Франции и художники импрессионисты

SELECT CA.client_name, Ac.name
FROM ClientArtist CA
JOIN Artist Ac ON CA.artist_name = Ac.name
WHERE Ac.birthplace = 'Франция'
	INTERSECT
SELECT CA.client_name, Ac.name
FROM ClientArtist CA
JOIN Artist Ac ON CA.artist_name = Ac.name
WHERE Ac.art_style = 'Импрессионизм';



--Написать 4 запроса с использованием подзапросов, используя операторы
--сравнения, операторы IN, ANY|SOME и ALL, предикат EXISTS

--1.	Вывести имена и адреса клиентов, которые покупали картины

SELECT name, address
FROM Client
WHERE name IN
			(SELECT A.client_name
			FROM Artwork A
			WHERE A.client_name IS NOT NULL);


--2.	Вывести названия картин типа живопись, цена которых больше хотя бы одной картины типа инсталляция

SELECT artwork_name, price
FROM Artwork
WHERE price > ANY
				(SELECT A.price
				FROM Artwork A
				WHERE A.category = 'Инсталляция');

--3.	Вывести названия картин, цена которых больше цены любой инсталяции созданной до 2011 года

SELECT artwork_name, price, year
FROM Artwork
WHERE price > ALL
				(SELECT A.price
				FROM Artwork A
				WHERE A.year < 2011 AND A.category = 'Инсталляция');
				
--4.	Если в галерее есть картины, написанные до 1980 года, то вывести названия всех картин типа живопись

SELECT artwork_name, year, price
FROM Artwork
WHERE category = 'Живопись' AND EXISTS
			(SELECT year
			FROM Artwork
			WHERE year < 1980);