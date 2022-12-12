
--����� 1

CREATE DATABASE University
GO

CREATE TABLE FACULTET (
    KOD_FACULTETA int IDENTITY(1,1) PRIMARY KEY,
    NAME_FACULTETA text NOT NULL,
	FIO_DECANA text,
	NOMER_KOMNATU int,
	TEL_DECANA char(10),	 
);
GO

CREATE TABLE KAFEDRA (
    KOD_KAFEDRU int IDENTITY(1,1) PRIMARY KEY,
    KOD_FACULTETA int DEFAULT 0 FOREIGN KEY REFERENCES FACULTET(KOD_FACULTETA),
	NAME_KAFEDRU text,
	FIO_ZAVKAF  text,
	NOMER_KOMNATU int,
	NUM_KORPUSA int,
	TEL_KAFEDRU char(10),
);
GO


CREATE TABLE STUDENT (
    STUDENT_ID int IDENTITY(1,1) PRIMARY KEY,
    SUTNAME text NOT NULL,
	SUTFNAME text NOT NULL,
	STIPEND decimal CHECK (STIPEND < 500 ),
	KURS int CHECK (KURS >= 1 AND KURS <=4 ),
	CITY text,
	BIRTDAY datetime,
	S_GROUP  text,
	KOD_KAFEDRU int DEFAULT 0 FOREIGN KEY REFERENCES KAFEDRA(KOD_KAFEDRU),
);
GO


CREATE TABLE TEACHER (
    KOD_TEACHER int IDENTITY(1,1) PRIMARY KEY,
    NAME_TEACHER text NOT NULL,
	INDEF_KOD int UNIQUE,
	DOLGNOST varchar(25) not null CHECK (DOLGNOST IN ('���������', '������', '������� �������������', '���������')) DEFAULT '���������',
	ZVANIE varchar(25) NOT NULL CHECK (ZVANIE IN ('�.�.�.', '�.�.�.', '�.�.�.', '�.�.�.�.', '�.�.�.', '�.�.�.', '�.�.�.', '�.�.�.�.')) DEFAULT '���',
	SALARY decimal CHECK (SALARY > 0 ) DEFAULT 1000,
	RISE decimal CHECK (RISE >= 0 ) DEFAULT 0,
	DATA_HIRE date DEFAULt GETDATE(),
	BIRTDAY date,
	POL varchar(25) not null CHECK (POL IN ( '�', '�', '�', '�')),
	TEL_TEACHER char(10) NOT NULL CHECK (TEL_TEACHER LIKE '[1-9][0-9]- [0-9][0-9]-[0-9][0-9]'),
	KOD_KAFEDRU int DEFAULT 0 FOREIGN KEY REFERENCES KAFEDRA(KOD_KAFEDRU), 
);
GO


--����� 2

--3 ���������� ������� � �������������� ���������� ���������;

--"������� ������� ��������� � ����������� ���������� ����� 200 ������"
SELECT* FROM STUDENT
WHERE STIPEND > 200

SELECT* FROM TEACHER
WHERE SALARY >= 1600

SELECT* FROM STUDENT
WHERE KURS != 3


--3 ������� � �������������� ���������� ���������� AND, OR � NOT;

SELECT* FROM TEACHER
WHERE DOLGNOST LIKE '���������' AND ZVANIE LIKE '�.�.�.'

SELECT* FROM TEACHER
WHERE KOD_KAFEDRU = 1 OR KOD_KAFEDRU = 4

SELECT* FROM TEACHER
WHERE SALARY NOT BETWEEN 1500 AND 4000


--2 ������� �� ������������� ���������� ���������� ����������;

SELECT* FROM KAFEDRA
WHERE KOD_KAFEDRU BETWEEN 1 AND 4 OR KOD_KAFEDRU = 9

SELECT* FROM STUDENT
WHERE KURS = 1 AND CITY NOT LIKE '������-��-����' OR KURS = 2


--2 ������� �� ������������� ��������� ��� ���������;

SELECT NAME_TEACHER, SALARY, RISE, (SALARY + RISE) AS 'Total salary' 
FROM TEACHER

SELECT NAME_TEACHER, SALARY, RISE  FROM TEACHER
WHERE SALARY/2 > RISE*3


--2 ������� � ��������� �� �������������� ���������;

SELECT* FROM STUDENT
WHERE KURS IN (1, 3)

SELECT* FROM KAFEDRA
WHERE NOMER_KOMNATU IN (414, 123)


--2 ������� � ��������� �� �������������� ��������� ��������;

SELECT* FROM STUDENT
WHERE STIPEND BETWEEN 100 AND 300

SELECT* FROM TEACHER
WHERE BIRTDAY BETWEEN '1980-01-01' AND '2000-01-01'


--2 ������� � ��������� �� ������������ �������;

SELECT* FROM STUDENT
WHERE SUTNAME LIKE '�%'

SELECT* FROM STUDENT
WHERE SUTNAME LIKE '[�-�]%'


--2 ������� � ��������� �� �������������� ��������

SELECT* FROM KAFEDRA
WHERE NOMER_KOMNATU IS NULL

SELECT* FROM KAFEDRA
WHERE NOMER_KOMNATU IS NOT NULL




--����� 3

--2 ������� � �������������� ����������� ������������ ���� ������;

SELECT KAFEDRA.NAME_KAFEDRU AS '�������� �������', TEACHER.NAME_TEACHER AS '������� �������������' 
FROM  KAFEDRA 
CROSS JOIN TEACHER

SELECT KAFEDRA.NAME_KAFEDRU AS '�������� �������', TEACHER.NAME_TEACHER AS '������� �������������' 
FROM KAFEDRA CROSS JOIN TEACHER
ORDER BY KAFEDRA.KOD_KAFEDRU;


--3 ������� � �������������� ���������� ���� ������ �� ���������;

SELECT*
FROM  KAFEDRA 
INNER JOIN FACULTET ON FACULTET.KOD_FACULTETA = KAFEDRA.KOD_FACULTETA

SELECT*
FROM  KAFEDRA 
INNER JOIN STUDENT ON KAFEDRA.KOD_KAFEDRU = STUDENT.KOD_KAFEDRU

SELECT*
FROM  KAFEDRA 
INNER JOIN TEACHER ON TEACHER.KOD_KAFEDRU = KAFEDRA.KOD_KAFEDRU


--2 ������� � �������������� ���������� ���� ������ �� ��������� � �������� ������;

SELECT*
FROM  KAFEDRA 
INNER JOIN FACULTET ON FACULTET.KOD_FACULTETA = KAFEDRA.KOD_FACULTETA
WHERE NAME_FACULTETA LIKE '�������������'

SELECT*
FROM  KAFEDRA 
INNER JOIN STUDENT ON KAFEDRA.KOD_KAFEDRU = STUDENT.KOD_KAFEDRU
WHERE STIPEND >=300


--2 ������� � �������������� ���������� �� ���� ��������;

SELECT*
FROM  KAFEDRA 
INNER JOIN FACULTET ON FACULTET.KOD_FACULTETA = KAFEDRA.KOD_FACULTETA
INNER JOIN STUDENT ON KAFEDRA.KOD_KAFEDRU = STUDENT.KOD_KAFEDRU

SELECT*
FROM  KAFEDRA 
INNER JOIN FACULTET ON FACULTET.KOD_FACULTETA = KAFEDRA.KOD_FACULTETA
INNER JOIN TEACHER ON TEACHER.KOD_KAFEDRU = KAFEDRA.KOD_KAFEDRU

--������� ����� ����� ��������� �������� �� ���������� �� ��������� �� ������� � �������������� �������� ������� ���������� ������ (JOIN).

SELECT*
FROM  KAFEDRA 
FULL JOIN FACULTET ON FACULTET.KOD_FACULTETA = KAFEDRA.KOD_FACULTETA

SELECT*
FROM  KAFEDRA 
FULL JOIN STUDENT ON KAFEDRA.KOD_KAFEDRU = STUDENT.KOD_KAFEDRU

SELECT*
FROM  KAFEDRA 
FULL JOIN TEACHER ON TEACHER.KOD_KAFEDRU = KAFEDRA.KOD_KAFEDRU

--2 ������� �� ������������� ������� �������� ����������;

SELECT*
FROM  KAFEDRA 
RIGHT JOIN FACULTET ON FACULTET.KOD_FACULTETA = KAFEDRA.KOD_FACULTETA

SELECT*
FROM  KAFEDRA 
RIGHT JOIN STUDENT ON KAFEDRA.KOD_KAFEDRU = STUDENT.KOD_KAFEDRU



--2 ������� � �������������� ������������� ���������� � �������� ������������.

SELECT needed.Name_Kafedru
FROM KAFEDRA needed, KAFEDRA given
WHERE needed.NUM_KORPUSA = given.NUM_KORPUSA AND
given.Name_Kafedru = '�����������'



--����� 4 

--2 ������� � �������������� ������� COUNT;

SELECT COUNT(*) FROM STUDENT WHERE KURS = 2 

SELECT COUNT(NUM_KORPUSA) FROM KAFEDRA WHERE NUM_KORPUSA IS NOT NULL


--2 ������� � �������������� ������� SUM;

SELECT SUM(SALARY) as Total_salary FROM TEACHER

SELECT SUM(SALARY) as Total_salary FROM TEACHER WHERE DOLGNOST LIKE '���������'


--2 ������� � �������������� ������� UPPER, LOWER;

 SELECT UPPER (ZVANIE) AS ZVANIE FROM TEACHER

 SELECT LOWER (ZVANIE) AS ZVANIE FROM TEACHER


--2 ������� � �������������� ��������� �������;

SELECT *
FROM TEACHER
WHERE MONTH(BIRTDAY) = 11

SELECT *
FROM TEACHER
WHERE DAY(BIRTDAY) = 22


--2 ������� � �������������� ������� ������ ����� HAVING; 

SELECT AVG(SALARY), AVG(RISE), SUM(SALARY + RISE) 
FROM TEACHER
WHERE LOWER(DOLGNOST ) = '���������' 
HAVING SUM(SALARY + RISE) > 2500


SELECT AVG(SALARY), AVG(RISE), SUM(SALARY + RISE) 
FROM TEACHER
WHERE LOWER(DOLGNOST ) = '���������' 
HAVING SUM(SALARY + RISE) > 4000


--2 ������� � �������������� ����� HAVING ��� ����� GROUP BY;

SELECT SUM(SALARY) as Total_salary
FROM TEACHER
HAVING SUM(SALARY) > 2000


SELECT SUM(STIPEND) as Total_stipend
FROM STUDENT
HAVING SUM(STIPEND) > 500

--2 ������� � �������������� ���������� �� �������;

SELECT * FROM TEACHER
WHERE DOLGNOST LIKE '���������' OR 
DOLGNOST LIKE '������'
ORDER BY BIRTDAY

SELECT * FROM STUDENT
WHERE KURS = 2
ORDER BY STIPEND DESC

--2 ������� �� ���������� ����� ������ � �������;

INSERT INTO KAFEDRA(KOD_FACULTETA, NAME_KAFEDRU, FIO_ZAVKAF, NOMER_KOMNATU, NUM_KORPUSA, TEL_KAFEDRU) 
VALUES (3, '����������������', '�����������', 666, 1, 158426)

SELECT * FROM KAFEDRA


INSERT INTO FACULTET(NAME_FACULTETA, FIO_DECANA, NOMER_KOMNATU, TEL_DECANA) 
VALUES ('������������� ��������������', '������ ���� �������������', 999, 858426)

SELECT * FROM FACULTET


--2 ������� �� ���������� ������������ ������ � �������;

UPDATE STUDENT
SET STIPEND = 1.1*STIPEND

SELECT * FROM STUDENT


UPDATE FACULTET
SET NAME_FACULTETA = '������������� ���������'
WHERE KOD_FACULTETA = 3

SELECT * FROM FACULTET


--2 ������� �� �������� ������������ ������.

SELECT * FROM STUDENT

DELETE FROM STUDENT
WHERE KURS = 3


SELECT * FROM TEACHER

DELETE FROM TEACHER
WHERE NAME_TEACHER LIKE '������ ���� ��������'