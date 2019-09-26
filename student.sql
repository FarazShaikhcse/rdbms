create database stud_enroll

use stud_enroll

create table STUDENT (
			regno char(10),
			fname char(15),
			major char (20),
			bdate datetime
			primary key(regno)
		    )

insert into STUDENT values ('cs001','Joyston','academic','1999-12-19')
insert into STUDENT values ('cs002','Mark','academic','1992-08-24')
insert into STUDENT values ('is001','kumar','academic','1995-07-06')
insert into STUDENT values ('ec020','uday','academic','1999-05-20')
insert into STUDENT values ('ec005','jayesh','academic','1998-01-04')

create table COURSE (
			courseno int,
			cname varchar(20),
			dept  char (10),
			primary key(courseno)
		    )
DROP TABLE COURSE

insert into COURSE values (1,'RDBMS','CS')
insert into COURSE values (2,'OS','CS')
insert into COURSE values (3,'JAVA','CS')
insert into COURSE values (4,'SIG PROCESSING','EC')
insert into COURSE values (5,'DIGTAL CIRCUITS','EC')
insert into COURSE values (6,'IMAGE PROCESSING','IS')
insert into COURSE values (7,'MICRO PROCESSOR','IS')
insert into COURSE values (8,'PYTHON','IS')

select * from COURSE 

create table TEXTBOOK (
			bookno int,
			title varchar(50),
			publisher  varchar(20),
			author  char(20),
			primary key (bookno)
		     )

insert into TEXTBOOK  values (101,'Fundamentals of DBMS','McGraw','NAVATHE')
insert into TEXTBOOK  values (102,'Database Design','McGraw','Raghu Rama')
insert into TEXTBOOK  values (103,'Image processing','Pearson','Ulman')
insert into TEXTBOOK  values (104,'Fundamentals of MP','McGraw','BALAGURU')
insert into TEXTBOOK  values (105,'Singals and Fundumentals','McGraw','NITHIN')
insert into TEXTBOOK  values (106,'Java programming','McGraw','Ragavan')
insert into TEXTBOOK  values (107,'Python programming','Pearson','Kolman')
insert into TEXTBOOK  values (108,'Circuit design','McGraw','Rajkamal')
insert into TEXTBOOK  values (109,'Electronic Circuits','McGraw','Alfred')
insert into TEXTBOOK  values (110,'Operating System','Pearson','Prakash')

 select * from TEXTBOOK

create table BOOK_ADAPTION (
			course int,
			sem int,
			bookISBN int,
			primary key(course, sem,bookISBN),
			foreign key(course) references COURSE(course) on delete cascade on update cascade,
			foreign key(bookISBN) references TEXTBOOK (bookISBN) on delete cascade on update cascade,
		    )

create table ENROLL (
			regno char(10),
			courseno  int,
			sem int ,
			marks int,
			primary key(regno,courseno,sem),
			foreign key(regno) references STUDENT(regno)on delete cascade on update cascade,
			foreign key(courseno) references COURSE(courseno)on delete cascade on update cascade,
		    )
insert into ENROLL  values ('cs001',1,5,89)
insert into ENROLL  values ('cs002',2,5,75)
insert into ENROLL  values ('is001',6,3,64)
insert into ENROLL  values ('ec020',1,5,49)
insert into ENROLL  values ('ec005',4,5,91)

insert into ENROLL  values ('cs,4,3,79)

select * from ENROLL
update ENROLL set courseno=4 where regno='ec020'