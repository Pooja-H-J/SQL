create database department;

use department;

create table dept (deptno int primary key, dname varchar(25), loc varchar(25));
insert into dept values 
(10, 'OPERATIONS', 'BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');

create table employee 
(empno int unique not null, ename varchar(25), 
job varchar(25) default ('CLERK'),mgr int, hiredate date, sal int check (sal>0),comm int, 
deptno int, foreign key (deptno) references dept(deptno));

insert into employee values 
(7369, 'SMITH', 'CLERK',7902, '1890-12-17', 800, null, 20);

insert into employee values
(7499,'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30), 
(7521,'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566,'JONES','MANAGER','7839', '1981-04-02', 2975, NULL, 20),
(7654,'MARTIN','SALESMAN','7698', '1981-09-28', 1250, 1400, 30), 
(7698,'BLAKE','MANAGER','7839', '1981-05-01', 2850, NULL, 30),
(7782,'CLARK','MANAGER','7839', '1981-06-09', 2450, NULL, 10),
(7788,'SCOTT','ANALYST','7566', '1987-04-19', 3000, NULL, 20),
(7839,'KING','PRESIDENT',NULL, '1981-11-17', 5000, NULL, 10),
(7844,'TURNER','SALESMAN','7698', '1981-09-08', 1500, 0, 30),
(7876,'ADAMS','CLERK','7788', '1987-05-23', 1100, NULL, 20),
(7900,'JAMES','CLERK','7698', '1981-12-03', 950, NULL, 30),
(7902,'FORD','ANALYST','7566', '1981-12-03', 3000, NULL, 20),
(7934,'MILLER','CLERK','7782', '1982-01-23', 1300, NULL, 10);

#3 List the Names and salary of the employee whose salary is greater than 1000
SELECT ENAME AS NAME, SAL AS SALARY FROM EMPLOYEE WHERE SAL>1000;

# 4 List the details of the employees who have joined before end of September 81.
SELECT * FROM EMPLOYEE WHERE HIREDATE < '1981-09-01';

#5 List Employee Names having I as second character
SELECT * FROM EMPLOYEE WHERE ENAME LIKE '_I%';

#6 List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns
SELECT ENAME AS EMPLOYEE_NAME, (40/100)*SAL AS ALLOWANCE, (10/100)*SAL AS PF,SAL-((10/100)*SAL) AS NET_SALARY, SAL FROM EMPLOYEE;

#7 List Employee Names with designations who does not report to anybody
SELECT * FROM EMPLOYEE WHERE MGR IS NULL;

#8 	List Empno, Ename and Salary in the ascending order of salary
SELECT EMPNO AS EMP_ID, ENAME AS NAME, SAL AS SALARY FROM EMPLOYEE ORDER BY SAL ASC;

#9 How many jobs are available in the Organization 
SELECT COUNT(distinct(JOB)) FROM EMPLOYEE;

#10 Determine total payable salary of salesman category
SELECT SUM(SAL) FROM EMPLOYEE WHERE JOB='SALESMAN';

#11 List average monthly salary for each job within each department 
SELECT DEPTNO, avg(SAL) FROM EMPLOYEE group by DEPTNO;

#12 Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working
SELECT EMP.ENAME AS EMPLOYEE_NAME, EMP.SAL AS SALARY, DEP.DNAME AS DEPARTMENT FROM EMPLOYEE EMP LEFT JOIN DEPT DEP ON EMP.DEPTNO=DEP.DEPTNO;

#13  Create the Job Grades Table 
create table JOB_GRADES(GRADE CHAR(1), LOWEST_SAL INT, HIGHEST_SAL INT);
INSERT INTO JOB_GRADES VALUES ('A',0,999), ('B',1000,1999),('C',2000,2999),('D',3000,3999),('E',4000,5000);

# 14 Display the last name, salary and  Corresponding Grade
select e.ename, e.sal, g.grade
 from employee e join job_grades g on e.sal between g.lowest_sal and g.highest_sal;

#15 Display the Emp name and the Manager name under whom the Employee works in the below format "Emp Report to Mgr"
select e.ename,concat('reporting to') as ' ', e1.ename as manager
 from employee e join employee e1 on e.mgr=e1.empno;

#16 Display Empname and Total sal where Total Sal (sal + Comm)
select ename, sal+((0.40)*sal) as total_salary from employee;

#17 Display Empname and Sal whose empno is a odd number
select empno, ename from employee where empno %2=1;

#18 Display Empname , Rank of sal in Organisation , Rank of Sal in their department
select ename as employee,sal as salary, rank() over (order by sal desc) as overall_rank,rank() over (partition by deptno order by sal desc) as deptwise_rank from employee;

#19 Display Top 3 Empnames based on their Salary
select empno, ename, sal from employee order by sal desc limit 3;

#20 Display Empname who has highest Salary in Each Department
SELECT ename,deptno, max(SAL) FROM EMPLOYEE group by deptno;
