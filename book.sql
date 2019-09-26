create database book_shoppe
use book_shoppe
create table AUTHOR
		(
			authid int primary key,
			authname  varchar(20),
			city	varchar(20),
			country	varchar(20)
		)
		drop table AUTHOR
insert into AUTHOR values(101,'Ulman','Texas','USA')
insert into AUTHOR values(102,'Kolman','London','UK')
insert into AUTHOR values(103,'Elmasri','Houston','Canada')
insert into AUTHOR values(104,'Sukesh','Bangalore','India')
insert into AUTHOR values(105,'Galvin','California','USA')
insert into AUTHOR values(106,'Lavathe','Berlin','Germany')

select * from AUTHOR

create table PUBLISHER
		(
			pubid int primary key,
			pubname  varchar(20),
			city	varchar(20),
			country	varchar(20)
		)	
		DROP TABLE PUBLISHER
insert into PUBLISHER values(201,'McGRAW','London','UK')
insert into PUBLISHER values(202,'Pearson','Texas','USA')
insert into PUBLISHER values(203,'Penguin','Bangalore','India')
insert into PUBLISHER values(204,'MediTech','Berlin','Germany')
insert into PUBLISHER values(205,'Willeys','Vegas','USA')


create table CATEGORY
		(
			catid int primary key ,
	      	descript varchar(30),				
		)	

		SELECT * FROM PUBLISHER

		insert into CATEGORY values(1,'Novels')
insert into CATEGORY values(2,'Engineering Books')
insert into CATEGORY values(3,'Encyclopedia')
insert into CATEGORY values(4,'Dictionary')
insert into CATEGORY values(5,'Medical Books')

select * from CATEGORY

create table CATALOGUE
		(
			bookid int primary key,
			title  varchar(20),
			pubid int,
			authorid int,
			catid int, 
			yr int,
			price int,
			foreign key(pubid) references PUBLISHER(pubid) on delete cascade on update cascade,
			foreign key(authorid) references AUTHOR(authid) on delete cascade on update cascade,
			foreign key(catid) references CATEGORY(catid) on delete cascade on update cascade
		)

select * from CATALOGUE
		insert into CATALOGUE values(301,'Time management',204,103,1,2010,250)
insert into CATALOGUE values(302,'Introduction to java',201,101,2,2012,430)
insert into CATALOGUE values(303,'Top 10 discoveries',203,104,3,2015,500)
insert into CATALOGUE values(304,'Oxford Dictionary',204,103,4,2009,160)
insert into CATALOGUE values(305,'Zoology',205,102,5,2008,750)
insert into CATALOGUE values(306,'Operating Systems',201,106,2,2017,425)
insert into CATALOGUE values(307,'Wings of fire',202,102,1,2016,250)

create table ORDER_DET
		(
			ordno int ,
			bookid int,
			qty int,
			primary key (ordno,bookid),
			foreign key(bookid) references CATALOGUE(bookid) on delete cascade on update cascade,			
		)	

		insert into ORDER_DET values(1,301,10)
insert into ORDER_DET values(1,302,6)
insert into ORDER_DET values(1,307,23)

insert into ORDER_DET values(2,301,15)
insert into ORDER_DET values(2,304,11)

insert into ORDER_DET values(3,304,15)

insert into ORDER_DET values(4,301,3)
insert into ORDER_DET values(4,305,8)

insert into ORDER_DET values(5,303,20)
insert into ORDER_DET values(5,306,6)
insert into ORDER_DET values(5,305,7)

select * from ORDER_DET
select A.authorid,A.aname,A.city from AUTHOR A, CATALOGUE C
where A.authorid  =  C.authorid group by A.authorid, A.aname,A.city
having sum(C.price) > (select avg(price) from CATALOGUE)
and count(*)>=2
 