CREATE DATABASE items_customers;
USE items_customers;

show tables;

/*PRACTICE EXERCISE 1*/
/*1.*/
SELECT customerid,item,price
FROM items_ordered
WHERE Customerid=10449;

/*2.*/
SELECT * 
FROM items_ordered
WHERE item="Tent";

/*3.*/
SELECT Customerid,order_date,price,item
FROM items_ordered
WHERE item like "S%";

/*4.*/
SELECT DISTINCT item
FROM items_ordered;

/*PRACTICE EXERCISE-2(AGGREGATE FUNCTIONS)*/
/*1.*/
SELECT MAX(Price)
FROM items_ordered;

/*2.*/
ALTER TABLE items_ordered
ADD COLUMN New_Order_Date int;

SELECT str_to_date(order_date,"%d-%m-%Y") as New_Order_Date
FROM items_ordered;

SET SQL_SAFE_UPDATES=0;

UPDATE items_ordered
SET New_Order_Date=str_to_date(order_date,"%d-%m-%Y");


SELECT date_format(New_Order_Date,"%d-%m-%Y") as New_Order_Date
FROM items_ordered;

SELECT item,AVG(price),MONTH(New_order_date)
FROM items_ordered
WHERE MONTH(New_order_date)=12;

/*3.*/
SELECT count(*)
FROM items_ordered;

/*4.*/
SELECT MIN(price)
FROM items_ordered
WHERE item="Tent";

/*PRACTICE EXERCISE-3-GROUP BY CLAUSE*/
/*1.*/
SELECT DISTINCT State,count(customerid) as Cnt
FROM Customers
Group By State;

/*2.*/
SELECT item,MAX(price), MIN(price)
FROM items_ordered
group by item;

/*3.*/
SELECT customerid, count(customerid) as CNT,SUM(price)
FROM items_ordered
group by customerid;

/*PRACTICE EXERCISE-4-HAVING CLAUSE*/
/*1.*/
SELECT DISTINCT State,COUNT(Customerid) as CNT
FROM customers
GROUP BY State
HAVING COUNT(Customerid)>1;

/*2.*/
SELECT item, MAX(price),MIN(price)
FROM items_ordered
group by item
HAVING MIN(PRICE)>190;

/*3.*/
SELECT customerid, count(customerid)
FROM items_ordered
Group BY item
HAVING count(customerid)>1;

/*PRACTICE EXERCISE-5-ORDER BY CLAUSE*/
/*1.*/
SELECT  firstname,lastname,city
FROM customers
ORDER BY lastname ASC;

/*2.*/
SELECT  firstname,lastname,city
FROM customers
ORDER BY lastname DESC;

/*3.*/
SELECT item,price
FROM items_ordered
HAVING price>10
ORDER BY price ASC;

/*PRACTICE EXERCISE-6-COMBINING CONDITIONS & BOOLEAN OPERATORS*/
