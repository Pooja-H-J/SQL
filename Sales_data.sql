create database sales;
use sales;

create table sales_people 
(snum int primary key, sname varchar(25), city varchar (25), comm int not null);
insert into sales_people values 
(1001,'Peel','London',0.12), 
(1002,'Serres','San Jose',0.13),
(1003,'Axelrod','New York',0.10),
(1004,'Motika','London',0.11),
(1007,'Rafkin','Barcelona',0.15);

create table Cust
(cnum int primary key, cname varchar(25), city varchar(25), rating int, 
snum int, foreign key(snum) references sales_people(snum));

insert into cust values 
(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002), 
(2006,'Clemens','London',300,1007),
(2007,'Pereira','Rome',100,1004),
(2008,'James','London',200,1007);

create table orders 
(onum int primary key, amt int, odate date, cnum int, foreign key (cnum) references Cust(cnum), 
snum int, foreign key (snum) references sales_people(snum));

insert into orders values 
(3001, 18.69, '1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19, '1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2004,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);

# 4 	Write a query to match the salespeople to the customers according to the city they are living
select s.sname, c.cname, s.city from sales_people s left join cust c on s.snum=c.snum order by s.city;

#5 Write a query to select the names of customers and the salespersons who are providing service to them
select c.cname as Customers,s.sname as sales_person from Cust c left join sales_people s on c.snum=s.snum;

# 6 Write a query to find out all orders by customers not located in the same cities as that of their salespeople
select o.onum, c.cname,c.city,s.sname, s.city from orders o inner join cust c on o.cnum=c.cnum join sales_people s on c.snum=s.snum where c.city<>s.city;

# 7 Write a query that lists each order number followed by name of customer who made that order
select o.onum order_number, c.cname as customer from orders o left join cust c on o.cnum=c.cnum ;

# 8 Write a query that finds all pairs of customers having the same rating………………
select cname,rating from cust order by rating;

# 9	Write a query to find out all pairs of customers served by a single salesperson………………..
select c.cname,s.sname from cust c left join sales_people s on c.snum=s.snum order by s.sname;

# 10	Write a query that produces all pairs of salespeople who are living in same city………………..
select sname, city from sales_people order by city;

# 11	Write a Query to find all orders credited to the same salesperson who services Customer 2008
select o.onum, s.sname from sales_people s inner join orders o on s.snum=o.snum where cnum=2008;

# 12 Write a Query to find out all orders that are greater than the average for Oct 4th
select onum from orders where amt> sum(amt)/count(onum) and odate='1994-10-04';

# 13 Write a Query to find all orders attributed to salespeople in London
select o.onum, s.sname from orders o left join sales_people s on o.snum=s.snum where s.city='London';

# 14 Write a query to find all the customers whose cnum is 1000 above the snum of Series
select cnum, cname from cust where cnum> snum+1000;

#  15.	Write a query to count customers with ratings above San Jose’s average rating #
select count(cname) from cust where rating>
(select avg(rating) from cust where city='San Jose');

# 16 Write a query to show each salesperson with multiple customers#
select s.snum, s.sname, count(c.cnum) as 'count of customers'  from sales_people s, cust c 
where s.snum=c.snum group by s.snum, s.sname having count(c.cnum)>1;
