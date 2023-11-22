use Ucheb_7_Starostina;

--������� ������ ����� � ���������� ����������� ������� ������ ��
--��� � ����� ������� ���� ����� ����. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent,
		ROUND(CAST(PL AS FLOAT) * 100 / 
		(SELECT SUM(PL)
		FROM Tabl_Kontinent), 3) AS �������
FROM Tabl_Kontinent
ORDER BY ������� DESC;

--������� ������ ����� ����, ��������� ��������� ������� ������, ��� ������� ��������� ��������� ���� ����� ����. 

SELECT Nazvanie,
		Stolica,
		KolNas / PL AS ���������_���������,
		Kontinent
FROM Tabl_Kontinent
WHERE KolNas / PL > (SELECT AVG(KolNas / PL) FROM Tabl_Kontinent);

--� ������� ���������� ������� ������ ����������� �����, ��������� ������� ������ 5 ���. ���. 

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
	WHERE Kontinent = '������') A
WHERE KolNas < 5000000;

--������� ������ ����� � ���������� ����������� �� ������� � ��������� ������� ��� ����� ����, ��� ��� ���������. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent,
		ROUND(CAST(PL AS FLOAT) * 100 / 
		(SELECT SUM(PL)
		FROM Tabl_Kontinent B
		WHERE A.Kontinent = B.Kontinent), 3) AS �������
FROM Tabl_Kontinent A
ORDER BY ������� DESC;

--������� ������ ����� ����, ������� ������� ������, ��� ������� ������� ����� ��� ����� �����, ��� ��� ���������. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent A
WHERE PL > (SELECT AVG(PL) FROM Tabl_Kontinent B 
				WHERE B.Kontinent = A.Kontinent);

--������� ������ ����� ����, ������� ��������� � ��� ������ �����, ������� ��������� ��������� ������� ��������� �����������. 

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

--������� ������ ���������������� �����, � ������� ����� ������ �����, ��� � ����� ����������� ������. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = '����� �������' AND KolNas > ALL
					(SELECT KolNas
					FROM Tabl_Kontinent
					WHERE Kontinent = '������');

--������� ������ ����������� �����, � ������� ����� ������ �����, ��� ���� �� � ����� ���������������� ������. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = '������' AND KolNas > ANY
					(SELECT KolNas
					FROM Tabl_Kontinent
					WHERE Kontinent = '����� �������');

--���� � ������ ���� ���� �� ���� ������, ������� ������� ������ 2 ���. ��. ��, ������� ������ ���� ����������� �����. 

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = '������' AND EXISTS
					(SELECT *
					FROM Tabl_Kontinent
					WHERE Kontinent = '������'
					AND PL > 2000000);

--������� ������ ����� ��� ����� �����, ��� ��������� ������ ������

SELECT Nazvanie,
		Stolica,
		PL,
		KolNas,
		Kontinent
FROM Tabl_Kontinent
WHERE Kontinent = 
				(SELECT Kontinent
				FROM Tabl_Kontinent
				WHERE Nazvanie = '�����');

--������� �������� ������ � ���������� ���������� ����� ����� � ���������� �������� �� ������ ����������.

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