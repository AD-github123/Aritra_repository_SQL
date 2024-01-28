create database inventory_management_system;
use inventory_management_system;
create table products(ProductID int primary key,ProductName varchar(100),Category varchar(100), UnitPrice int, QuantityInStock int);
insert into products(ProductID,ProductName,Category,UnitPrice,quantityInStock) 
values
(1, 'Laptop', 'Electronics', 800, 50),
(2, 'OfficeChair', 'Furniture', 150, 100),
(3, 'Printer','Electronics', 200, 300),
(4, 'Notebook', 'Stationery',5,200),
(5,'SmartPhone','Electronics',600,80),
(6,'Desk','Furniture',120,50),
(7,'HeadPhone','Electronics',50,80),
(8,'Pen','Staionery',1,500),
(9,'BookShelf','Furniture',250,20),
(10,'Mouse','Electronics',200,100);
create table suppliers(SupplierID int primary key, SupplierName varchar(100),ContactPerson varchar(100),PhoneNO varchar(10));
insert into suppliers (SupplierID, SupplierName, ContactPerson, PhoneNO)
values
(101, 'Tech Suppliers','John Doe','1234567890'),
(102, 'Furniture Mart', 'Jane Smith', '9876543210'),
(103,'Stationery World','Mark Johnson','5551234567'),
(104, 'Electronics World','Sarah Brown','1112223333'),
(105, 'Office Solutions','James White','4445556666'),
(106, 'Bookstore Central', 'Emma Wilson','7778889999'),
(107,'Home Furnishings', 'Michael Green', '9990001111'),
(108, 'Writing Essentials', 'Laura Davis', '2223334444'),
(109, 'Electronics Direct', 'Chris Turner', '6667778888'),
(110, 'Furniture Express','Alex Johnson', '3334445555');
create table orders(OrderID int primary key, ProductID int, SupplierID int, OrderDate date, QuantityOrdered int, OrderAmount int, 
foreign key(ProductID) references products(ProductID),
foreign key(SupplierID) references suppliers(SupplierID));
insert into orders (OrderID, ProductID, SupplierID, OrderDate, QuantityOrdered, OrderAmount)
values
(501, 1, 101, '2023-12-12', 10, 8000),
(502, 2, 102, '2024-01-05', 20, 3000),
(503, 3, 103, '2024-01-10', 5, 1000),
(504, 4, 104, '2023-12-01', 50, 250),
(505, 5, 105, '2023-12-20', 15, 9000),
(506, 6, 106, '2023-12-17', 8, 960),
(507, 7, 107, '2024-01-09', 25, 1250),
(508, 8, 108, '2024-01-03', 100, 100),
(509, 9, 109, '2023-12-02', 2, 500),
(510, 10, 110, '2024-01-05', 30, 600);
select * from orders;
select*from products;
select * from suppliers;
/*performing analyisis on "products" table*/

/*finding total quantity in sotck*/
select sum(QuantityInStock) 
as Total_Quantity
from products;

/*finding product name with maximum quantity and also its quantity in stock*/
select ProductName 
as Product_With_Max_Quantity, QuantityInStock
from products
where QuantityInStock=(select max(QuantityInStock) from products);

/*finding product name with minimum quantity and also its quantity in stock*/
select ProductName 
as Product_With_Min_Quantity, QuantityInStock
from products
where QuantityInStock=(select min(QuantityInStock) from products);

/*finding product category wise quantity in stock*/
select Category,sum(QuantityInStock) as Total_Quantity
from products
group by(Category);

/*finding product name and its price where price is maximum*/
select ProductName as Product_with_Max_Price, UnitPrice
from products
where UnitPrice=(select max(UnitPrice) from products);

/*finding product name and its price where price is minimum*/
select ProductName as Product_with_Min_Price, UnitPrice
from products
where UnitPrice=(select min(UnitPrice) from products);

/*performing analysis on "suppliers" table*/

/*finding longest suppliername along with its supplierid*/
select SupplierID,SupplierName as Longest_Supplier_Name
from suppliers
where SupplierName=(select max(SupplierName) from suppliers);

/*finding smallest suppliername along with its supplierid*/
select SupplierID,SupplierName as Smallest_Supplier_Name
from suppliers
where SupplierName=(select min(SupplierName) from suppliers);

/*arranging names of contact persons alphabatically*/
select * from suppliers
order by ContactPerson;

/*finding supplier whose phone numbers starts with 1*/
select *
 from suppliers
where PhoneNO like '1%';

/*finding supplier whose phone numbers ends with 9*/
select *
from suppliers
where PhoneNO like '%9';

/*performing analysis on "orders" table*/

/*finding total order amount*/
select sum(OrderAmount) as Total_Order_Amount
from orders;

/*finding minimum order amount*/
select min(OrderAmount) as Highest_Order_Amount
from orders;

/*finding minimum order amount*/
select min(OrderAmount) as Lowest_Order_Amount
from orders;

/*finding total order quantity*/
select sum(QuantityOrdered) as Total_Ordered_Quantity
from orders;

/*finding maximum order quantity*/
select max(quantityOrdered) as Max_Ordered_Quantity
from orders;

/*finding minimum order quantity*/
select min(quantityOrdered) as Min_Ordered_Quantity
from orders;

/*finding total ordered quantity and total order amount for the year 2023*/
select sum(QuantityOrdered) as Total_Quantity_Ordered,
sum(OrderAmount) as Total_Order_Aamount
from orders
where OrderDate like '2023%';

/*finding total ordered quantity and total order amount for the year 2024*/
select sum(QuantityOrdered) as Total_Quantity_Ordered,
sum(OrderAmount) as Total_Order_Aamount
from orders
where OrderDate like '2024%';

/*performing analysis by joining multiple tables*/
/*finding supplier name, contact person and their respective ordered quntities, order amounts*/
select SupplierName, ContactPerson, QuantityOrdered, OrderAmount
from suppliers join orders
using(SupplierID);

/*finding product category wise total order amount*/
select Category, sum(OrderAmount) as Total_Order_Amount
from products join orders
using(ProductID)
group by(Category);

/*finding product name, unit price, quantity in stock, supplier name, contact person, quantity ordered and order amount*/
select ProductName, UnitPrice, QuantityInStock, SupplierName, ContactPerson, QuantityOrdered, OrderAmount
from products  join suppliers  join orders
Using(ProductID,SupplierID);

/*finding supplier id, supplier name, contact person, order id, order amount for the year 2023*/
select SupplierID, SupplierName, ContactPerson, OrderID, OrderAmount
from suppliers join orders
USing(SupplierID)
where OrderDate like '2023%';

/*finding supplier id, supplier name, contact person, order id, order amount for the year 2024*/
select SupplierID, SupplierName, ContactPerson, OrderID, OrderAmount
from suppliers join orders
USing(SupplierID)
where OrderDate like '2024%';

/*finding names of contact persons, order amount and their phone numbers whose order amount is greater than 5000*/
select ContactPerson, OrderAmount, PhoneNO
from suppliers join orders
Using(SupplierID)
where OrderAmount > 5000;

/*arranging product names in ascending order w.r.t. their order amount*/
select ProductName
from products join orders
using(ProductID)
order by OrderAmount asc;

/*finding contact persons and their phone numbers whose orders are older than 1 month*/
select s.ContactPerson, s.PhoneNO
from suppliers s
 join orders o
Using(SupplierID)
where datediff(curdate(),o.OrderDate)>30;
 
 /*finding order id, order amount for December*/
 select o.OrderID, o.OrderAmount
 from Orders o
 where month(OrderDate)=12;
 
 /*finding order id, order amount for January*/
 select o.OrderID, o.OrderAmount
 from Orders o
 where month(OrderDate)=1;
 
 /*finding whether total orderamount for the year 2024 is greater than or not for the year 2023*/
SELECT 
  CASE 
    WHEN SUM(CASE WHEN YEAR(OrderDate) = 2023 THEN OrderAmount else 0 end) >
         SUM(CASE WHEN YEAR(OrderDate) = 2024 THEN OrderAmount else 0  END)
    THEN 'Yes'
    ELSE 'No'
  END AS comparison_result
FROM orders;

/*finding decrease(in %) in total order amount of December and January by rounding the percentage value upto 2 decimal numbers*/
select round(((sum(case when month(OrderDate)=12 then OrderAmount else 0 end)-
sum(case when month(OrderDate)=1 then OrderAmount else 0 end))/sum(case when month(OrderDate)=1 then OrderAmount else 0 end))*100,2)
 as decrease_in_order
from orders;