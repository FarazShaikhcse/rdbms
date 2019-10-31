create database  bankofnitte

use bankofnitte

create table BRANCH(
		   	bname varchar(15),
			ifsc varchar(10),
			bcity varchar(15),
			assets real,
			primary key(ifsc)
		   )

insert into BRANCH values('synd_nitte','SYND000101','karkala',200000)
insert into BRANCH values('Corp_nitte','CORP000110','karkala',300000)
insert into BRANCH values('PNB_nitte','PNB0000102','karkala',100000)
insert into BRANCH values('Corp_mang','CORP000148','Mangalore',300000)
insert into BRANCH values('PNB_mang','PNB0000105','Mangalore',500000)
insert into BRANCH values('state_udupi','SBI0000101','Udupi',500000)
insert into BRANCH values('synd_udupi','SYND000120','Udupi',500000)
	
select * from BRANCH

create table ACCOUNT(
			accno int, 
			ifsc varchar(10),
			balance real,
			primary key(accno),
			foreign key(ifsc) references BRANCH(ifsc)on delete cascade on update cascade
		    )			
			

insert into ACCOUNT values(12345,'CORP000110',6000)
insert into ACCOUNT values(12340,'CORP000110',6000)
insert into ACCOUNT values(21345,'SYND000101',10000)

insert into ACCOUNT values(14341,'PNB0000102',15000)
insert into ACCOUNT values(14345,'PNB0000102',15000)
insert into ACCOUNT values(12455,'CORP000110',17000)

insert into ACCOUNT values(13345,'SBI0000101',11000)
insert into ACCOUNT values(13346,'SBI0000101',11000)
insert into ACCOUNT values(13347,'SBI0000101',11000)
insert into ACCOUNT values(13340,'SBI0000101',11000)

insert into ACCOUNT values(15345,'PNB0000105',11000)

insert into ACCOUNT values(12453,'PNB0000105',17000)
insert into ACCOUNT values(21346,'PNB0000105',10000)
insert into ACCOUNT values(12450,'PNB0000105',17000)
insert into ACCOUNT values(12452,'PNB0000105',17000)

insert into ACCOUNT values(13245,'PNB0000102',5000)
insert into ACCOUNT values(13241,'PNB0000102',5000)
insert into ACCOUNT values(12375,'PNB0000102',12000)
insert into ACCOUNT values(12377,'SYND000120',12000)
insert into ACCOUNT values(12378,'SYND000120',12000)
insert into ACCOUNT values(15342,'SYND000120',19000)
insert into ACCOUNT values(12451,'CORP000148',17000)



create table CUSTOMER(
			cname varchar(20)primary key,
			cstreet varchar(25),
			ccity varchar(20)
		     )


insert into CUSTOMER values('Rahul','3rd main','karkala')
insert into CUSTOMER values('Sahil','4th main','karkala')
insert into CUSTOMER values('Sandhu','4th block','mangalore')
insert into CUSTOMER values('Jayesh','456 nagar','mangalore')
insert into CUSTOMER values('Johnny','452 street','Udupi')

create table DEPOSITOR(
			cname varchar(20),
			accno int,
			primary key(cname,accno),
			foreign key(cname) references CUSTOMER(cname) on delete cascade on update cascade,
			foreign key(accno) references ACCOUNT(accno) on delete cascade on update cascade,
			unique(accno)			
		      )
insert into DEPOSITOR values('Rahul',12340)
insert into DEPOSITOR values('Rahul',13345)
insert into DEPOSITOR values('Sahil',14345)
insert into DEPOSITOR values('Sahil',13346)
insert into DEPOSITOR values('Sandhu',15342)
insert into DEPOSITOR values('Sandhu',14341)

insert into DEPOSITOR values('Jayesh',12345)
insert into DEPOSITOR values('Sandhu',12375)
insert into DEPOSITOR values('Johnny',12377)
insert into DEPOSITOR values('Johnny',21345)
insert into DEPOSITOR values('Jayesh',12450)
insert into DEPOSITOR values('Sandhu',13340)
insert into DEPOSITOR values('Sahil',12451)
insert into DEPOSITOR values('Johnny',13347)
insert into DEPOSITOR values('',12455)


create table LOAN (
			loanno int, 
			ifsc varchar(10),
			amount real,
			primary key(loanno),
			foreign key(ifsc) references BRANCH(ifsc) on delete cascade on update cascade
			
		 )

insert into LOAN values(1,'SYND000101',12000)
insert into LOAN values(2,'CORP000110',11000)
insert into LOAN values(3,'CORP000148',10000)
insert into LOAN values(4,'SYND000120',16000)
insert into LOAN values(5,'SBI0000101',13000)
insert into LOAN values(6,'PNB0000105',12000)

create table BORROWER(
			cname varchar(20),
			loanno int
			primary key(cname,loanno),
			foreign key(cname) references CUSTOMER(cname) on delete cascade on update cascade,
			foreign key(loanno) references LOAN(loanno) on delete cascade on update cascade,
			unique(loanno)
			)


insert into BORROWER values('Johnny',1)
insert into BORROWER values('Rahul',2)
insert into BORROWER values('Sahil',3)
insert into BORROWER values('Sandhu',4)
insert into BORROWER values('Sahil',5)
insert into BORROWER values('Jayesh',6)

select distinct D.cname,D.accno
from DEPOSITOR D
where not exists( select B.ifsc
                  from BRANCH B
                  where B.bcity='Udupi'
                  and B.ifsc not in( select ifsc
                                      from ACCOUNT A,DEPOSITOR D1
                                      where A.accno=D1.accno
                                      and A.ifsc=B.ifsc
                                      and D1.cname=D.cname))
select d.cname,d.accno from DEPOSITOR d where d.cname in(
select C.cname 
from CUSTOMER  C
where  not  exists(select distinct(B1.bcity)   
                   from  BRANCH B1 
	               where not exists(select  count( distinct B.ifsc)   
	                                from BRANCH B, ACCOUNT A ,DEPOSITOR D
                                    where A.ifsc = B.ifsc
	                                and D.accno =A.accno  and B.bcity  = B1.bcity
	                                and D.cname =C.cname  
	                                group by B.bcity
	                                having count(*) >=1)))


select D.cname,D.accno from DEPOSITOR D where D.cname in(
select C.cname from CUSTOMER C 
where exists(
select count(distinct b.bname) from BRANCH B,ACCOUNT A,DEPOSITOR D
where A.ifsc=b.ifsc
and D.accno=A.accno
and B.bcity='karkala'
and D.cname=C.cname group by B.bcity having count(*)>=2))