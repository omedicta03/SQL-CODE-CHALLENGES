---TRIPLE A

--TripleA Corporation, a manufacturer of bicycle equipment noticed a surge in decreasing sales and shipment of suppliers’ products to customers from 2013 to 
--2014. The management came up with strategic and key performance indicators to improve the sales of the initial 2013 product and increase the sales and 
--shipment of suppliers’ products to customers in 2015 and beyond. 
--Below are the business requirements and deliverable report with the following columns definitions and business rules:
-- Column Name Business Rule 
--1 ProductNumber The product number is considered as business key needs to identify the product in the customershipment table
--2 ProductName Name of the product
--3 QuantityShipped2013 Total Quantity of associated product shipped in 2013
--4 ShippedProductAmount2013 Total Amount of the associated product shipped in 2013, i.e. ShippedProductAmount= OrderQty*ListPrice
--5 QuantityShipped2014 Total Quantity of associated product shipped in 2014
--6 ShippedProductAmount2014 Total Amount of the associated product shipped in 2014, i.e. ShippedProductAmount= OrderQty*ListPrice
--7 MarginalQuantity QuantityShipped2014 - QuantityShipped2013
--8 MarginalRevenue ShippedProductAmount2014 - ShippedProductAmount2013
--9 . MarginalRevenuePercent (ShippedProductAmount2014-ShippedProductAmount2013)/ShippedProductAmount2013
--10 Strategic Indicator This is measured based on the marginal revenue as follows:
--MarginalRevenue < -40000 then 'Call for Rebranding'
--MarginalRevenue >= -40000 and MarginalRevenue<=0 then 'Call for Aggressive Marketing'
--MarginalRevenue >=0 and MarginalRevenue<1000 then 'Shipment free'
--MarginalRevenue>=1000 then 'Credit to Customer & Shipment free'
--When the product was sold and shipped in 2013 but not in 2014 then 'Product either discontinued or No shipment'
--If none of the above conditions are not TRUE then we need 'logistic support'
 
--Note: 
--1. 2013 Products are the baseline products regardless of their sales and shipment in 2014
--2. Customer Shipment, Product, Product Category and Category Tables in SQL Essential database are required to produce this report


SELECT nd.ProductName,nd.ProductNumber,nd.QuantityShipped2013,nd.totalamountproductshipped2013,QuantityShipped2014,totalamountproductshipped2014,
format(QuantityShipped2014-QuantityShipped2013,'c') as marginalqty, format(totalamountproductshipped2014- totalamountproductshipped2013,'c') as marginalrevenue, 
format((totalamountproductshipped2014- totalamountproductshipped2013)/totalamountproductshipped2013,'p') as marginalrevenuepercent,

CASE 

when (totalamountproductshipped2014- totalamountproductshipped2013) < -40000 then 'Call for Rebranding'
when(totalamountproductshipped2014- totalamountproductshipped2013) >= -40000 and (totalamountproductshipped2014- totalamountproductshipped2013)<=0 then 'Call for Aggressive Marketing'
when (totalamountproductshipped2014- totalamountproductshipped2013) >=0 and (totalamountproductshipped2014- totalamountproductshipped2013)<1000 then 'Shipment free'
when (totalamountproductshipped2014- totalamountproductshipped2013)>=1000 then 'Credit to Customer & Shipment free'
--When the product was sold and shipped in 2013 but not in 2014 then 'Product either discontinued or No shipment'
when (totalamountproductshipped2014- totalamountproductshipped2013) is NULL then 'Product either discontinued or No shipment'

ELSE 'need logistic support'

END  strategicindicator

from

(SELECT ProductNumber, ProductName, count(OrderQty)as QuantityShipped2013, sum(orderqty*listprice) as totalamountproductshipped2013 from CustomerShipment 
WHERE year(ShipDate) = '2013'
GROUP BY  ProductNumber, ProductName) nd

LEFT JOIN 

(SELECT ProductNumber, ProductName, count(OrderQty)as QuantityShipped2014, sum(orderqty*listprice) as totalamountproductshipped2014 from CustomerShipment 
WHERE year(ShipDate) = '2014'
GROUP BY  ProductNumber, ProductName) st on nd.productnumber = st.productnumber








select * from CustomerShipment
select * from Product
select * from ProductCategory