use Ucheb_7_Starostina;

--1. ������� ������������ ��������� ���������� ��������, ������� �������� ������ � �������� ������ 500 ��. ��
--� � �������� ������ 5 ���. ��. ��:

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

-- 2. ������� ������ ����� � �������� ������ 1 ���. ��. ��, ��������� ������ � ���������� ������ 100 ���. ���.

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


--3. ������� ������ ����� � �������� ������ 500 ��. �� � � ���������� ������ 100 ���. ���.

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