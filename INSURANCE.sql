create database insurancecomp
use insurancecomp
create table driver(
driverid real,
dname char(15) not null,
city varchar(15),
dist varchar(15),
state varchar(15),
mobno real,
primary key(driverid))
insert into driver values(2019101,'Joyston','karkala','udupi','karnataka',9480966920)
insert into driver values(2019102,'karthik','karkala','udupi','karnataka',9981611225)
insert into driver values(2019103,'Deon','Mangalore','DK','karnataka',9123456780)
insert into driver values(2019104,'Jayesh','Moodbidri','DK','karnataka',9480452104)
insert into driver values(2019105,'ramesh','Nitte','udupi','karnataka',9123456780)
insert into driver values(2019106,'Suresh','Belman','DK','karnataka',8765432190)
select * from driver
CREATE TABLE CAR (
regno varchar(20),
make varchar(10),
model varchar(10)not null,
cyear int,
primary key(regno)
)
DROP TABLE CAR
insert into  CAR values ('KA-20-AA-1970','FORD','MUSTANG',2014)
insert into  CAR values ('KA-20-MA-2741','FORD','FIGO',2012)
insert into  CAR values ('KA-20-AA-1524','BMW','M5',2015)
insert into  CAR values ('KA-47-AB-6541','TATA','NEXON',2017)
insert into  CAR values ('GA-05-MJ-1770','MERCEDES','AMG',2005)
insert into  CAR values ('KA-20-MA-9695','HONDA','CITY',2013)
insert into  CAR values ('KA-19-MB-9745','HONDA','JAZZ',2015)

SELECT * FROM CAR

CREATE TABLE ACCIDENT  (
reportno int ,
REGNO varchar(20),
accdate datetime,
location varchar(20),
primary key(reportno),foreign key(REGNO) references CAR(regno) on delete cascade on update cascade
)
drop table ACCIDENT
insert into  ACCIDENT values (1,'KA-47-AB-6541','1998-07-22 23:00:00','karkala')
insert into  ACCIDENT values (2,'GA-05-MJ-1770','2016-07-10 22:45:00','udupi')
insert into  ACCIDENT values (3,'KA-20-MA-2741','2015-06-13 13:20:00','parkala')
update ACCIDENT set accdate='2019-08-10 22:45:00' where location='karkala'
select * from ACCIDENT
CREATE TABLE OWNS    (
driverid real ,
regno varchar(20)
primary key(driverid,regno)
foreign key(driverid) references driver(driverid)on delete cascade on update cascade,
foreign key(regno) references CAR(regno)on delete cascade on update cascade,
unique(regno)
   )
select * from ACCIDENT

insert into  OWNS values ('2019101','KA-20-AA-1970')
insert into  OWNS values ('2019102','KA-20-MA-2741')
insert into  OWNS values ('2019103','KA-20-AA-1524')
insert into OWNS values ('2019104','GA-05-MJ-1770')
insert into OWNS values ('2019105','KA-47-AB-6541')
insert into OWNS values ('2019106','KA-20-MA-9695')
insert into OWNS values ('2019106','KA-19-MB-9745')
select * from OWNS

CREATE TABLE PARTICIPATED (
			   driverid real ,
			   regno varchar(20),
			   reportno  int,
			   dmgamt int,
			   foreign key(driverid) references driver(driverid)on delete cascade on update cascade,
			   foreign key(regno) references CAR(regno),
			   foreign key(reportno) references ACCIDENT(reportno)  on delete cascade on update cascade,
			   foreign key(driverid,regno) references OWNS(driverid,regno),
			   unique(reportno) 
			 )
insert into  PARTICIPATED values ('2019105','KA-47-AB-6541',1,50000)
insert into  PARTICIPATED values ('2019104','GA-05-MJ-1770',2,10000)
insert into  PARTICIPATED values ('2019102','KA-20-MA-2741',3,60000)

SELECT * FROM PARTICIPATED

select distinct(location) from ACCIDENT

SELECT MAX(dmgamt) from PARTICIPATED

SELECT MIN(dmgamt) from PARTICIPATED

select count (distinct P.driverid)
from ACCIDENT A, PARTICIPATED P
where A.reportno = P.reportno 
and A.accdate between  '2015-01-01' and  '2016-12-31'

select  count (P.reportno) as NO_OF_ACC
from  PARTICIPATED P,  driver PN
where P.driverid =  PN.driverid 
and   PN.dname = 'ramesh' 

select  count (P.reportno) as NO_OF_ACC
from   PARTICIPATED P,  car C
where P.regno =  C.regno 
and   C.model  = 'NEXON'

