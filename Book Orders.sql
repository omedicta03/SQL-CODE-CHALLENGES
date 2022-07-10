USE [BOOK ORDERS]
----XMAS GIFT

create table Book_Orders(
order_id int primary key,
customer_id int,
book_id int,
Price Numeric,
order_date date
);


insert into Book_Orders values('101','201','1010','15.01','1/1/2019');
insert into Book_Orders values('102','202','1030','14.00','2/12/2019');
insert into Book_Orders values('103','203','1211','25.45','3/5/2019');
insert into Book_Orders values('104','204','1367','8.01','4/15/2019');
insert into Book_Orders values('105','205','2903','95.15','5/15/2019');
insert into Book_Orders values('106','206','7840','15.90','7/10/2019');
insert into Book_Orders values('107','207','4010','45.01','9/15/2019');
insert into Book_Orders values('108','208','1015','180.00','12/15/2019');
insert into Book_Orders values('109','209','1014','80.01','1/1/2020');
insert into Book_Orders values('110','210','5010','6.30','2/12/2020');
insert into Book_Orders values('111','211','1071','6.00','3/5/2020');
insert into Book_Orders values('112','212','1010','15.01','4/15/2020');
insert into Book_Orders values('113','213','1860','12.00','5/15/2020');
insert into Book_Orders values('114','214','1820','5.41','7/10/2020');
insert into Book_Orders values('115','215','5689','15.01','9/15/2020');

select* from Book_Orders


--number of books sold 2019
SELECT  count( *) as numberofbookssold, year( Order_date) as year  from Book_Orders
WHERE year( Order_date) = '2019' 
group by year( Order_date)

SELECT  count( *) as numberofbookssoldr  from Book_Orders
WHERE year( Order_date) = '2019' 

--list of customers with number of book orders placed by year
select customer_id, count(*) as numberofbookorders, year(order_date) year from Book_Orders
group by year(order_date),customer_id

--average price of a book across sales history
select  avg(price) as averagepriceofbooks from Book_Orders

--customers that placed more than 3 orders per year in both 2019 and 2020

select data20.customer_id,data20.totalnumberofbooks2020,data20.year2020,data19.customer_id,data19.totalnumberofbooks2019,data19.year2019

from 

(  select customer_id, year(order_date) year2020, count(*)totalnumberofbooks2020 from Book_Orders
where year(order_date) = 2020
group by  customer_id, year(order_date)
having count(*) > 3
) data20

inner join

(  select customer_id, year(order_date) year2019, count(*)totalnumberofbooks2019 from Book_Orders
where year(order_date) = '2019'
group by  customer_id,year(order_date)
having count(*) > 3
) data19 

on data20.customer_id = data19.customer_id
