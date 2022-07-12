USE [SQL ESSENTIAL]

select * from CustomerShipment

--Ex. 1: What's is the total number of rows in the customer shipment table :

select count(*) from CustomerShipment
select count(transid) from PurchaseTrans -- number of transactions


--Ex 2: You wanted to know how many province are there in the database :Write a sql statement to extract all the province
select  StateProvince from CustomerShipment

select count(distinct StateProvince)as countofprovince from CustomerShipment

--Ex. 3:List all the employees whose Lastname is David

select * from Employee where LastName = 'david'

--select * from Employee
--select  FirstName ='vargas' , LastName ='garett' from Supplier
--select *from PurchaseTrans

--exercise 4: 
select TransID, Supplier from PurchaseTrans  where Supplier ='vargas garrett' -- list of transation
select TransID from PurchaseTrans  where Supplier ='vargas garrett'


--Ex. 5 & 6
select distinct accountnumber, Supplier from PurchaseTrans where Supplier = 'vargas garrett' --list of unique accountnumber 

--Ex. 7
select ProductNumber, ProductName,Supplier from CustomerShipment 
where Supplier = 'vargas garrett' or supplier = 'Pak Jae'             ----As the senior manager , you want to know all the products supplied by Vargas Garrett or Pak jae
  
--Ex. 8
--From the Purchase Transaction table, list all transactions showing the productsID , the transaction ID, 
--the account Number, the employee that processed the transaction and that are Silver in color
--and list price greater than $3398
select ProductID,TransID,AccountNumber,Employee,Color,ListPrice from PurchaseTrans
where Color = 'silver' and ListPrice > $3398

--Ex. 9 were most impacted. Write SQL to list all transaction that has carrier tracking number containing
--the “4343”.

select * from PurchaseTrans where CarrierTrackingNumber like '%4343%'

--Ex 10  Still on on this root cause analysis , you notice those carriertracking numbers that starts with 6C and those that ends with 83 are also impacted. Write aPlease list only the TransactionID ,Carrier Tracking Number, Supplier Name, Color, List Price and ProductID
select  TransID,CarrierTrackingNumber,Supplier,Color,ListPrice,ProductID from PurchaseTrans
where CarrierTrackingNumber like '6c%' or CarrierTrackingNumber like '%83' or CarrierTrackingNumber like '%4343%'

--Ex 11 

select distinct  Supplier,Country,City,

case 

when country = 'australia' then 'australia'
when country = 'united kingdom' then 'europe'
when Country = 'germany' then 'europe'
when country = 'france' then 'europe'
when country = 'united states' then 'north america'
when country = 'canada' then 'north america'
else 'none'
 end as continent

from PurchaseTrans

select distinct  Supplier,Country,City,

case 

when country = 'australia' then 'australia'
when country = 'united kingdom' or Country= 'germany' or country='Country' then 'europe'
when country = 'united states' or Country = 'canada' then 'north america'
else 'unknown'
 end as continent

from PurchaseTrans

--Ex. 12
select OrderID , City, Country,ProductNumber, ListPrice, Customerclass,  
case 
when CustomerClass ='black' then '0.01'
when CustomerClass = 'blue' then '0.02'
when CustomerClass = 'red' then '0.03%'
when CustomerClass = 'silver' then '0.04%'
when CustomerClass = 'yellow' then '0.05%'

else '0.07%'

end as shippingcost

from CustomerShipment
order by CustomerClass

----Ex 13 1.Every other class will have No discount , except :
--2.
--If customer class is yellow and List price 1500 or less , then DiscountCLass will be YellowClassDiscount
--Else if list price is between 1501 and 2000
--discountClass will be PromoDIscount , else discountClass will be called VP Discount
--3.
--If customer class is Silver and List price is 1400 or less then DiscountCLass will be SilverClassDiscount
--Else if list price is greater than 1500 and less than 2000
--discountClass will be PromoDIscount , else discountClass will be called VP
--Discount

select OrderID , City, Country,ProductNumber, ListPrice, Customerclass,  
case CustomerClass
when  'yellow' then
case 
when ListPrice <=1500 then 'yellowclassdiscount'
when ListPrice between 1501 and 2000 then 'promodiscount'
else 'vpDiscount'
end

when 'silver' then
case
when ListPrice <=1400 then 'silverclassdiscount'
when ListPrice > 1500 and ListPrice < 2000 then 'promodiscount'
else 'vpDiscount'
end
end as discountclass
from CustomerShipment

--Ex 14
use [SQL ESSENTIAL]

select  ProductID, ProductName, ProductNumber,
case
when ProductName like '%mountain%' then 'high altitude'
when ProductName like '%road%' then 'warrior'
when ProductName like '%touring%' then 'zaphyr'

else 'elite'
end as marketAlias
from Product 

select * from customershipment

--Ex 15 Whats the total number of Product that contains the word Mountain in their productName
select count(*)numberofproducts from Product where ProductName like '%mountain%'

--Ex 16 Count the number of unique supplier from the purchaseTrans Table
select count(distinct supplier)countofuniquesupplier from PurchaseTrans

--Ex 17 Count the number of transactions made by an employee called Track Glenn
select count(*) from PurchaseTrans where Employee = 'track Glenn'

--Ex 18 What's the average order shipped tilldate
select avg(OrderQty)avgordershiped  from CustomerShipment

--Ex 19 Whats the average list price for all order shipped till date
select avg(ListPrice)avglistprice  from CustomerShipment

--Ex 20 What's the highest quantity of order shipped tilldate
select max(orderqty)highestqtyshipped from customershipment

--Ex 21 Using the Purchase Trans Table , when was the earliest and the last shipping date for transaction
select  ShipDate from PurchaseTrans order by ShipDate asc

--Ex 22 Go back to Exercise 4, what is the sum of all quantity ordered by this supplier
select TransID, Supplier from PurchaseTrans  where Supplier ='vargas garrett' -- list of transation
select TransID from PurchaseTrans  where Supplier ='vargas garrett'

select  Supplier, sum(orderqty)sumoforderqty from PurchaseTrans 
where Supplier ='vargas garrett'
group by  Supplier


--Ex 23 what is the total quantity transaction that has carrier tracking number containing the “4343”. Refer Exercise 9
--select * from PurchaseTrans where CarrierTrackingNumber like '%4343%'

select CarrierTrackingNumber, sum(orderqty)sumoforderqty  from purchaseTrans  
where CarrierTrackingNumber like '%4343%'
group by CarrierTrackingNumber

--Ex 24 Group all suppliers by the number of transaction they have made till date in the Purchase Trans

select  Supplier,transid, count(*) from PurchaseTrans
group by  Supplier,transid

--Ex 25 Group all suppliers by the total qty of all orders they made

Select  Supplier,sum(orderqty)totalorderqty from PurchaseTrans
group by Supplier,orderqty

--Ex 26 List all the count of all transaction by supplier . Which supplier has the largest amount of
--transaction .
select supplier, count(*)countofsupplier from PurchaseTrans
group by Supplier
order by countofsupplier desc



























