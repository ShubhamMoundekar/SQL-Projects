Create Database Customers_data;
Use Customers_data;

-- Create customers table
CREATE TABLE customer_s (
    Customer_ID INT,
    Name VARCHAR(100),
    City VARCHAR(50),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Gender VARCHAR(10),
    Address TEXT
);

/* Change Table Name */
RENAME TABLE `customers (1)` TO customers;

Select * from Customers;
Select * from Orders;
Select * from products;

/* Show first 10 customers*/
Select * from Customers
limit 10;

/* Count total orders */
Select count(*) as total_orders from Orders;

/* Find distinct cities of customers */
Select distinct city from Customers;

/* Check orders with quantity > 5 */ 
Select * from Orders
where quantity > 5;

/* Total revenue generated */ 

Select 
      SUM(o.Quantity * p.`Price (INR)`) as Total_sales 
from orders  o
join products  p 
on o.product_id = p.product_id;

/* Revenue by product */
Select p.product_name, sum(o.Quantity * p.`Price (INR)`) as Total_revenue from orders as o
inner join products as p
on o.product_id = p.product_id
group by p.product_name
order by total_revenue desc;

/* Top 5 selling products */ 
Select p.product_name, sum(o.Quantity) as Total_revenue from orders as o
join products as p 
on o.product_id = p.product_id
group by p.product_name 
order by Total_revenue desc
limit 5;

/* Customer-wise total orders */

Select c.name, Count(o.order_id) as total_Orders from customers as c
join orders as o 
on c.customer_id = o.customer_id
group by c.name
order by total_orders desc;

/* Month-wise revenue */ 

Select Month(o.order_date) as Month_no, 
Monthname(o.Order_Date) as Month, 
sum(o.Quantity * p.`Price (INR)`) as revenue from Orders o
join products p
on o.product_id = p.product_id
group by Month_no, Month
order by month;

/* Rank products by revenue */ 

Select p.product_name, sum(o.quantity * p.`Price (INR)`) as Revenue, 
Rank() Over (Order by Sum(o.quantity * p.`Price (INR)`) desc) as Rank_no from orders as o
join products p
on o.product_id = p.product_id
group by p.product_name;

/* Customers who never placed an order */ 

Select C.customer_id, C.name from Customers C
Left join Orders o
on C.Customer_id = O.Customer_Id
Where O.order_id is null;


/* Occasion-wise revenue */ 

Select O.Occasion, sum(o.Quantity * p.`Price (INR)`) as Revenue from orders o
join products p 
on o.product_id = p.product_id
group by O.Occasion
order by Revenue DESC;

