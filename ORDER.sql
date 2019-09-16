create database  odb
use odb
CREATE TABLE CUSTOMER (
			custid int,
			cname char(15) not null,
			city varchar(30),
			primary key (custid)  
			)

insert into CUSTOMER values (101,'Rahul', 'Karkala')
insert into CUSTOMER values (102,'Sahil', 'Hubli')			
insert into CUSTOMER values (103,'Suresh', 'Udupi')
insert into CUSTOMER values (104,'Ronika', 'mangalore')
insert into CUSTOMER values (105,'Rajan', 'Mumbai')

			select count(*) as No_Of_CUST from  CUSTOMER

CREATE TABLE CUST_ORDER (
			orderid int,
			odate datetime,
			custid int,
			ordamt int,
			primary key (orderid)  ,
			foreign key(custid) references CUSTOMER(custid)on delete cascade on update cascade
			)
			
insert into CUST_ORDER values (201,'2011-05-06 10:26:00', 101,null)
insert into CUST_ORDER values (202,'2011-05-10 12:00:00', 103,null)
insert into CUST_ORDER values (203,'2011-05-20  14:30:00', 102,null)
insert into CUST_ORDER values (204,'2011-05-21 09:30:00', 105,null)
insert into CUST_ORDER values (205,'2011-06-01 15:45:00', 104,null)
insert into CUST_ORDER values (206,'2011-06-06 23:00:00', 101,null)
insert into CUST_ORDER values (207,'2011-06-15 16:10:00', 102,null)
insert into CUST_ORDER values (208,'2011-06-30 11:45:00', 103,null).

select * from CUST_ORDER

CREATE TABLE ITEM (
			itemid  int,
			price int,
			primary key (itemid)
		  )

insert into ITEM values (301,2000)
insert into ITEM values (302,500)
insert into ITEM values (303,1000)
insert into ITEM values (304,5000)
insert into ITEM values (305,2500)

CREATE TABLE ORDER_ITEM (
			orderid int,
			itemid int,
			qty int,
			primary key (orderid,itemid),
			foreign key(orderid) references CUST_ORDER(orderid) on delete cascade on update cascade,
			foreign key(itemid) references ITEM(itemid) on delete cascade on update cascade
			)
			
insert into ORDER_ITEM values (201,301,2)
insert into ORDER_ITEM values (201,302,3)
insert into ORDER_ITEM values (201,303,1)

insert into ORDER_ITEM values (202,304,2)
insert into ORDER_ITEM values (202,305,4)
insert into ORDER_ITEM values (203,303,1)
insert into ORDER_ITEM values (204,302,2)
insert into ORDER_ITEM values (205,301,3)
insert into ORDER_ITEM values (206,303,5)
insert into ORDER_ITEM values (207,304,4)
insert into ORDER_ITEM values (208,303,2)


update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 201)
where orderid = 201

update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 202)
where orderid = 202

update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 203)
where orderid = 203
update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 204)
where orderid = 204
update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 205)
where orderid = 205
update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 206)
where orderid = 206
update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 207)
where orderid = 207
update CUST_ORDER set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T
                              where O.itemid = T.itemid and O.orderid = 208)
where orderid = 208
CREATE TABLE WAREHOUSE (
			warehouseid int,
			city varchar(20)not null,
			primary key (warehouseid)
		   )


insert into WAREHOUSE values (1,'udupi')
insert into WAREHOUSE values (2,'Karkala')
insert into WAREHOUSE values (3,'Mumbai')
insert into WAREHOUSE values (4,'udupi')
insert into WAREHOUSE values (5,'Hubli')

CREATE TABLE SHIPMENT (
			orderid int,
			warehouseid int,
			ship_dt datetime,
			primary key (orderid,warehouseid)  ,
			foreign key(orderid) references CUST_ORDER(orderid) on delete cascade on update cascade,
			foreign key(warehouseid) references WAREHOUSE(warehouseid) on delete cascade on update cascade
		   )
		   DROP TABLE SHIPMENT
 insert into SHIPMENT values (201,1,'2011-05-10 12:00:00')
insert into SHIPMENT values (201,2,'2001-05-10 09:45:00')
insert into SHIPMENT values (201,3,'2011-05-11 10:30:00')

insert into SHIPMENT values (202,4,'2011-05-12 06:30:00')
insert into SHIPMENT values (202,4,'2011-05-13 15:00:00' )
insert into SHIPMENT values (202,4,'2003-06-01')
insert into SHIPMENT values (203,5,'2011-05-25  10:00:00')
insert into SHIPMENT values (204,3,'2011-05-22 20:00:00')
insert into SHIPMENT values (205,2,'2011-06-10 09:00:00')
insert into SHIPMENT values (206,1,'2011-06-20 11:00:00')
insert into SHIPMENT values (207,3,'2011-07-01 12:30:00')


select C.cname , count(O.orderid) as NO_OF_ORDR, avg(O.ordamt) as AVG_ORD_AMT 
from CUSTOMER C, CUST_ORDER O
where C.custid = O.custid group  by C.cname 

select O.orderid from CUST_ORDER O
where not exists (select warehouseid from WAREHOUSE where city = 'udupi' and warehouseid not in 
							(select warehouseid from SHIPMENT  where orderid = O.orderid) 
                 )
select O.orderid from CUST_ORDER O
where not exists (
                        (select warehouseid from WAREHOUSE where city = 'MAGALORE' and warehouseid not in 
							(select warehouseid from SHIPMENT  where orderid = O.orderid))
                                         union

			(select warehouseid from SHIPMENT  where orderid = O.orderid and   warehouseid not in 
							(select warehouseid from WAREHOUSE where city = 'udupi'))
                         
                 )