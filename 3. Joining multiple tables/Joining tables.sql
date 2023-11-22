USE TestDatabas;

--1. Вывести из таблиц «Кафедра», «Специальность» и «Студент» данные о
--студентах, которые обучаются на данном факультете (например, «ит»).

SELECT
	S.*,
	P.NaprSpez,
	K.Nkaf
FROM Student S
INNER JOIN Spezialn P ON S.Nom_SpeZ_St = P.NSpez
INNER JOIN Kafedra K ON P.Shifr_Spez = K.ShifrKaf
WHERE K.AbFaK_Kaf = 'ит';


--2. Вывести в запросе для каждого сотрудника номер
--и фамилию его непосредственного руководителя. 
--Для заведующих кафедрами поле руководителя оставить пустым. 

SELECT
	S.FIO,
	IIF(P.TabNom_ruk != S.TabNom, P.FIO, NULL) AS [Фамилия руководителя],
	IIF(P.TabNom_ruk != S.TabNom, P.TabNom, NULL) AS [Номер руководителя]	 
FROM Sotrudnik P
left OUTER JOIN Sotrudnik S ON S.TabNom_ruk = P.TabNom;


--3. Вывести список студентов, сдавших минимум два экзамена. 

SELECT
	S.Fio_stud,
	COUNT(O.Ozenk_a) AS [Количество экзаменов]
FROM Student S
INNER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
GROUP BY S.Fio_stud
HAVING COUNT(O.Ozenk_a) > 1;

--4. Вывести список инженеров с зарплатой, меньшей 2000 руб. 

SELECT
	S.FIO,
	S.Zarplata,
	I.Spez
FROM Sotrudnik S
INNER JOIN Ingener I ON S.TabNom = I.TabNom_IN
WHERE S.Zarplata < 2000;

--5. Вывести список студентов, сдавших экзамены в заданной аудитории. 

SELECT
	S.Fio_stud
FROM Student S
LEFT OUTER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
WHERE O.Auditoria = 'т506';

--6. Вывести из таблиц «Студент» и «Экзамен» учетные номера и фамилии студентов, а также 
--количество сданных экзаменов и средний балл для каждого студента только для тех студентов, 
--у которых средний балл не меньше заданного (например, 4). 

SELECT
	S.Reg_Nom,
	S.Fio_stud,
	COUNT(O.Ozenk_a) AS [Количество экзаменов],
	AVG(O.Ozenk_a) AS [Средний балл]
FROM Student S
INNER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
GROUP BY S.Fio_stud, S.Reg_Nom
HAVING AVG(O.Ozenk_a) >= 4;


--7. Вывести список заведующих кафедрами и их зарплаты, и степень. 

SELECT
	S.FIO,
	S.Zarplata,
	Z.St_K
FROM Sotrudnik S
INNER JOIN ZavKaf Z ON S.TabNom = Z.TabNom_K;

--8. Вывести список профессоров.

SELECT
	S.FIO
FROM Sotrudnik S
INNER JOIN Prepodavatel P ON S.TabNom = P.TabNom_Pr
WHERE P.Zvanie = 'профессор';

-- 9. Вывести название дисциплины, 
--фамилию, должность и степень преподавателя, дату
--и место проведения экзаменов в хронологическом порядке в заданном интервале даты. 

SELECT DISTINCT
	PR.Predmet AS Дисциплина,
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

--10. Вывести фамилию преподавателей, принявших более трех экзаменов. 

SELECT
	S.FIO
FROM Ozenka O
INNER JOIN Sotrudnik S ON O.Tab_Nom = S.TabNom
GROUP BY S.FIO
HAVING COUNT(O.data) > 3;

--11. Вывести список студентов, не сдавших ни одного экзамена в указанной дате.
SELECT
	S.Fio_stud
FROM Student S
LEFT OUTER JOIN
	(SELECT O.* 
	FROM Ozenka O 
	WHERE O.data = '2022-06-05') O
	ON S.Reg_Nom = O.ReGNom
WHERE O.ReGNom IS NULL;