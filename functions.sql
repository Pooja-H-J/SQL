create database functions;
use functions;

CREATE TABLE  `dept` (
  `DEPTNO` int(11) DEFAULT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL
);

INSERT INTO `dept` (`DEPTNO`, `DNAME`, `LOC`) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

CREATE TABLE  `emp` (
  `EMPNO` int(11) NOT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `MGR` int(11) DEFAULT NULL,
  `HIREDATE` date DEFAULT NULL,
  `SAL` int(11) DEFAULT NULL,
  `COMM` int(11) DEFAULT NULL,
  `DEPTNO` int(11) DEFAULT NULL
) ;


INSERT INTO `emp` (`EMPNO`, `ENAME`, `JOB`, `MGR`, `HIREDATE`, `SAL`, `COMM`, `DEPTNO`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1980-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);

CREATE TABLE  `salgrade` (
  `GRADE` int(11) DEFAULT NULL,
  `LOSAL` int(11) DEFAULT NULL,
  `HISAL` int(11) DEFAULT NULL
) ;

INSERT INTO `salgrade` (`GRADE`, `LOSAL`, `HISAL`) VALUES
(1, 700, 1200),
(2, 1201, 1400),
(3, 1401, 2000),
(4, 2001, 3000),
(5, 3001, 9999);
CREATE TABLE  `bonus` (
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `SAL` int(11) DEFAULT NULL,
  `COMM` int(11) DEFAULT NULL
) ;

-- ---------FUNCTIONS--------------
--

/*Agrigate functions*/

select min(sal) from emp;

select max(sal) from emp;
--
select min(hiredate), max(hiredate) from emp;
--
select sum(sal), avg(sal) from emp;
--
select count(ename) from emp;
--
select count(comm) from emp;
--
select sum(sal),deptno from emp group by deptno;
--
select sum(sal),deptno from emp group by deptno having sum(sal)>9000;
--
select job from emp where job in ('clerk', 'manager') group by job having  count(empno)=4;

-- 
/*Scalar functions*/

select right('mysql',1);
--
select left('mysql',2);
--
select substr('mysql',2,3);
--
select substr('mysql',-2,2);
--
select instr('mysql','s');
--
select concat(upper(substr('renu',1,1)),
lower(substr('renu',-(length('renu')-1),length('renu')-1)));
--
select ifnull(comm,0)+sal,sal from emp;
--
select * from emp where left(ename,1)='s';
--
select * from emp where left(ename,1)='a' and right(ename,1)='s';

--

/* date functioons*/
select now();
--
select ename,monthname(hiredate) from emp;
--
select year(now());
--
select day (now());
--
select str_to_date('12-jul-97','%d-%M-%Y');
--
select * from emp where dayname(HIREDATE)='friday'; #hired on friday
--
select timestampdiff (month,'1997-12-07','2022-10-07');
--
select monthname(hiredate) as month, hiredate from emp;
--
select * from emp where monthname(hiredate) in ('may', 'december');
--

/*CONDITIONS =,<>,<=,>=,<,>-------SINGLE VALUE COMPARISION
MULTI VALUE--------- BETWEEN, IN, LIKE*/
SELECT * FROM EMP WHERE ENAME LIKE 'S%';
--
SELECT * FROM EMP WHERE ENAME LIKE '%S';
--
SELECT * FROM EMP WHERE ENAME LIKE '%A%';
--
SELECT * FROM EMP WHERE ENAME LIKE '%A%A%';
--
SELECT * FROM EMP WHERE ENAME LIKE '__I%';
--
SELECT * FROM EMP WHERE ENAME LIKE '%E_';
--
SELECT * FROM EMP WHERE COMM IS NULL;
--
select ename from emp where sal*12>20000;
--
select * from emp where job in ('clerk','salesman');
--
select * from emp where ename like 'j%';
--
select * from emp where hiredate like '%-12-%';
--
select * from emp where (job='clerk' or job='salesman') and sal>1000;
--
select * from emp where sal not between 1200 and 2000;
--
select * from emp where ename not in ('scott', 'smith');
--
select * from emp where ename not like ('s%');