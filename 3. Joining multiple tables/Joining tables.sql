USE TestDatabas;

--1. ������� �� ������ ��������, ��������������� � �������� ������ �
--���������, ������� ��������� �� ������ ���������� (��������, ���).

SELECT
	S.*,
	P.NaprSpez,
	K.Nkaf
FROM Student S
INNER JOIN Spezialn P ON S.Nom_SpeZ_St = P.NSpez
INNER JOIN Kafedra K ON P.Shifr_Spez = K.ShifrKaf
WHERE K.AbFaK_Kaf = '��';


--2. ������� � ������� ��� ������� ���������� �����
--� ������� ��� ����������������� ������������. 
--��� ���������� ��������� ���� ������������ �������� ������. 

SELECT
	S.FIO,
	IIF(P.TabNom_ruk != S.TabNom, P.FIO, NULL) AS [������� ������������],
	IIF(P.TabNom_ruk != S.TabNom, P.TabNom, NULL) AS [����� ������������]	 
FROM Sotrudnik P
left OUTER JOIN Sotrudnik S ON S.TabNom_ruk = P.TabNom;


--3. ������� ������ ���������, ������� ������� ��� ��������. 

SELECT
	S.Fio_stud,
	COUNT(O.Ozenk_a) AS [���������� ���������]
FROM Student S
INNER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
GROUP BY S.Fio_stud
HAVING COUNT(O.Ozenk_a) > 1;

--4. ������� ������ ��������� � ���������, ������� 2000 ���. 

SELECT
	S.FIO,
	S.Zarplata,
	I.Spez
FROM Sotrudnik S
INNER JOIN Ingener I ON S.TabNom = I.TabNom_IN
WHERE S.Zarplata < 2000;

--5. ������� ������ ���������, ������� �������� � �������� ���������. 

SELECT
	S.Fio_stud
FROM Student S
LEFT OUTER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
WHERE O.Auditoria = '�506';

--6. ������� �� ������ �������� � �������� ������� ������ � ������� ���������, � ����� 
--���������� ������� ��������� � ������� ���� ��� ������� �������� ������ ��� ��� ���������, 
--� ������� ������� ���� �� ������ ��������� (��������, 4). 

SELECT
	S.Reg_Nom,
	S.Fio_stud,
	COUNT(O.Ozenk_a) AS [���������� ���������],
	AVG(O.Ozenk_a) AS [������� ����]
FROM Student S
INNER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
GROUP BY S.Fio_stud, S.Reg_Nom
HAVING AVG(O.Ozenk_a) >= 4;


--7. ������� ������ ���������� ��������� � �� ��������, � �������. 

SELECT
	S.FIO,
	S.Zarplata,
	Z.St_K
FROM Sotrudnik S
INNER JOIN ZavKaf Z ON S.TabNom = Z.TabNom_K;

--8. ������� ������ �����������.

SELECT
	S.FIO
FROM Sotrudnik S
INNER JOIN Prepodavatel P ON S.TabNom = P.TabNom_Pr
WHERE P.Zvanie = '���������';

-- 9. ������� �������� ����������, 
--�������, ��������� � ������� �������������, ����
--� ����� ���������� ��������� � ��������������� ������� � �������� ��������� ����. 

SELECT DISTINCT
	PR.Predmet AS ����������,
	S.FIO,
	S.Dolgn,
	P.Stepen,
	O.data,
	O.Auditoria
FROM Ozenka O
INNER JOIN Predmet PR ON O.Kod = PR.kod_pred
INNER JOIN Sotrudnik S ON O.Tab_Nom = S.TabNom
INNER JOIN Prepodavatel P ON O.Tab_Nom = P.TabNom_Pr
WHERE O.data BETWEEN '2022-06-05' AND '2022-06-09'
ORDER BY O.data;

--10. ������� ������� ��������������, ��������� ����� ���� ���������. 

SELECT
	S.FIO
FROM Ozenka O
INNER JOIN Sotrudnik S ON O.Tab_Nom = S.TabNom
GROUP BY S.FIO
HAVING COUNT(O.data) > 3;

--11. ������� ������ ���������, �� ������� �� ������ �������� � ��������� ����.
SELECT
	S.Fio_stud
FROM Student S
LEFT OUTER JOIN
	(SELECT O.* 
	FROM Ozenka O 
	WHERE O.data = '2022-06-05') O
	ON S.Reg_Nom = O.ReGNom
WHERE O.ReGNom IS NULL;