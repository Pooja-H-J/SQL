# SQL Commands
/* DDL- data definition language-- create, alter, drop and truncate
   DML- data manipulation language-- insert, update, delete
   DQL- data Query language-- Select
   TCL- transaction control language-- Save Point, commit, rollback
   DCL- data cotrol language-- Grant, revoke*/
   
   create database int_prep;
   use int_prep;
  create table emp 
  (id int primary key, name varchar (15), depid int, foreign key(depid) references dept (depid), sAL INT);
  create table dept
  (depid int primary key, depname varchar (15), loc varchar(15));
  
   INSERT into DEPT VALUES 
   (1, "Analyst", "Bengaluru"),
   (2,"Operations", "Bengaluru"),
   (3,"HR", "Mumbai"),
   (4,"Finance","Mumbai");
   
   INSERT into emp values
   (1, "Pooja", 1, 3000), (2, "Ruchika", 3, 2500),(3,"Ganavi",2,2800),(4,"Vishishta",4,3500);
   
   #Alter, Drop
   Alter table emp add column j_date date default("2020-06-15");#add column
   alter table emp rename column name to ename;# rename column
   alter table emp rename to emp1;#rename table
   alter table emp1 drop column j_date;#drop column
   /*drop table emp1; #drop table*/
   /* drop database int_prep; #drop database*/
   
   #Update, delete
   update emp1 set ename= "Darshini" where id=3;
   insert into emp values (5,null,4,null);
   delete from emp where id=5;
   #rollback, savepoint, commit
   savepoint sp1;
   savepoint sp2;
   set autocommit =0;
   commit;
   rollback to sp2;
   set autocommit=1;
   
#select
select * from emp;

   #truncate
   #truncate table emp;
   
   #CONSTRAINTS
   /* Primary key, Foreign key, Unique, not null, default, check*/
   
   /*Alias-- used to give temporary name to a column or a table to increase its readability, 
   can use along with the key word "as" */
   
   #Joins
   select *, depname from emp e left join dept d on e.depid=d.depid; #left join
   select e.id, d.*  from emp e right join dept d on e.depid=d.depid; #right join
   select *, depname from emp e inner join dept d on e.depid=d.depid; #inner join
   
   #View-- creates virtual table based on the sql statement 
   #simple view-- sub set of the table, filtered data based on the sql statement
   create view sam_tab as select id, ename,depid from emp;
   select * from sam_tab;
   #Complex view-- view created using complex queries, aggregated functions etc
	create view comp_view as select depid,sal,sum(sal) from emp group by depid having sal>2000;
    
    #Index-- which contains pointers and which helps in easy retrival of data
    #sorted index--
    create index sort_depid on emp(depid desc);
    
    #unique index-- created on unique fields in the table, only one unique index per table
    create unique index un_ind on emp(id);
    
    #clustered index--table itself is sorted to match the index
   #create clustered index clust_ind on emp(id, ename, depid);
    
    #drop index
   /* drop index index_name on table_name; */
    
    