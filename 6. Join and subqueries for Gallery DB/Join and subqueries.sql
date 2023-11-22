use Gallery;

--�������� �� ��� ������� �� ������ ���������� ������

--����������
--1.	������� � ����� ���������� ��������� �������
SELECT artist_name, artwork_name, name AS category
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
JOIN Art_group G ON G.id = AG.group_id;

--2.	������� ��� ��������� ������ ���������� � �� ������
SELECT A.artist_name, A.artwork_name, C.name, C.address
FROM Artwork A
JOIN Client C ON A.client_name = C.name;


--������� �����
--1.	������� ���������� � �� ������ ��� ���� ������ 
SELECT A.artwork_name, C.name, C.address
FROM Artwork A
LEFT OUTER JOIN Client C ON A.client_name = C.name;

--2.	������� ���������� �� ���, ������� �������� ��������, � �� �����
SELECT CA.client_name, CA.artist_name, Ac.art_style
FROM ClientArtist CA
LEFT OUTER JOIN Artist Ac ON CA.artist_name = Ac.name
WHERE birthplace = '���';


--������� ������

--1.	������� ���������, � ������� �� ��������� �� ���� �������
SELECT G.name AS category
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
RIGHT OUTER JOIN Art_group G ON G.id = AG.group_id
WHERE artwork_name IS NULL;

--2.	������� ��� �������� ���������� ������������� ������
SELECT C.name, COUNT(*) AS [���������� ������]
FROM Artwork A
RIGHT OUTER JOIN Client C ON A.client_name = C.name
WHERE A.artwork_name IS NOT NULL
GROUP BY C.name;


--������ ������� ����������

--1.	������� ���������� ����������, ������� �������� ��������
SELECT COALESCE(client_name, '�����'),
		COALESCE(name, '�����'),
		COUNT(name) AS [���������� ����������]
FROM ClientArtist CA
FULL OUTER JOIN Artist Ac ON CA.artist_name = Ac.name
GROUP BY ROLLUP(client_name, name);

--2.	������� �����, ����������� ������ ��������
SELECT C.name, COALESCE(SUM(A.price), 0) AS [����������� �����]
FROM Artwork A
FULL OUTER JOIN Client C ON A.client_name = C.name
WHERE C.name IS NOT NULL
GROUP BY C.name;


--������������ ����������

--1.	������� ��������� ������������ ������������ ��������� � �� �����

SELECT artist_name, artwork_name, name AS category
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
CROSS JOIN Art_group G;

--2.	������� ��������� ������������ �������� � ����������

SELECT C.name, A.name
FROM Client C
CROSS JOIN Artist A;



--14. �������� �� ��� �������:

--�� �����������:

--1.	������� ������������ ��������� ���������� ��������, ������� �������� ������� ���������� �� 1980 � ����� 2005
SELECT artwork_name, year
FROM Artwork
WHERE year < 1980
	UNION
SELECT artwork_name, year
FROM Artwork
WHERE year > 2005;


--2.	������� ������������ ��������� ���������� ��������, ������� �������� ����������, ��� ������� < 50, � ���������� �� �������

SELECT name, birthplace, age
FROM Artist
WHERE age < 50
	UNION
SELECT name, birthplace, age
FROM Artist
WHERE birthplace = '�������';


--�� ��������

--1.	������� ������ ������ ���� ��������, ��������� ������� ���������� > 100000

SELECT artwork_name, price
FROM Artwork
WHERE category = '��������'
	EXCEPT
SELECT artwork_name, price
FROM Artwork
WHERE price > 100000

--2.	������� ������ �������� ����������� � ������� > 100000, ��������� �������� ����������� � ������

SELECT A.client_name 
FROM Artwork A
JOIN Client C ON A.client_name = C.name
GROUP BY A.client_name
HAVING SUM(A.price) > 100000
	EXCEPT
SELECT C.name
FROM Client C
WHERE C.address NOT LIKE '%�����%';


-- �� ����������� ������

--1.	������� �������� ������, ��� ������� ������������ 19-�� ���� � ���� > 4500000

SELECT A.artwork_name
FROM ArtworkGroup AG
JOIN Artwork A ON A.id = AG.artwork_id
JOIN Art_group G ON G.id = AG.group_id
WHERE G.name = '������������ 19-�� ����'
	INTERSECT
SELECT artwork_name
FROM Artwork
WHERE price > 4500000;

--2.	������� ��������, ������� �������� ��������� �� ������� � ��������� ��������������

SELECT CA.client_name, Ac.name
FROM ClientArtist CA
JOIN Artist Ac ON CA.artist_name = Ac.name
WHERE Ac.birthplace = '�������'
	INTERSECT
SELECT CA.client_name, Ac.name
FROM ClientArtist CA
JOIN Artist Ac ON CA.artist_name = Ac.name
WHERE Ac.art_style = '�������������';



--�������� 4 ������� � �������������� �����������, ��������� ���������
--���������, ��������� IN, ANY|SOME � ALL, �������� EXISTS

--1.	������� ����� � ������ ��������, ������� �������� �������

SELECT name, address
FROM Client
WHERE name IN
			(SELECT A.client_name
			FROM Artwork A
			WHERE A.client_name IS NOT NULL);


--2.	������� �������� ������ ���� ��������, ���� ������� ������ ���� �� ����� ������� ���� �����������

SELECT artwork_name, price
FROM Artwork
WHERE price > ANY
				(SELECT A.price
				FROM Artwork A
				WHERE A.category = '�����������');

--3.	������� �������� ������, ���� ������� ������ ���� ����� ���������� ��������� �� 2011 ����

SELECT artwork_name, price, year
FROM Artwork
WHERE price > ALL
				(SELECT A.price
				FROM Artwork A
				WHERE A.year < 2011 AND A.category = '�����������');
				
--4.	���� � ������� ���� �������, ���������� �� 1980 ����, �� ������� �������� ���� ������ ���� ��������

SELECT artwork_name, year, price
FROM Artwork
WHERE category = '��������' AND EXISTS
			(SELECT year
			FROM Artwork
			WHERE year < 1980);