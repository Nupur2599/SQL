CREATE DATABASE Taxiforsure;
/*Import the data csv tables using Table Data Import Wizard in MySQL workbench*/

USE Taxiforsure; /*Make the database default*/
SHOW TABLES;

/*
CREATE TABLE Data
(pickup_date Char(100),
pickup_time	char(100), 
pickup_datetime	char(100),
PickupArea	char(100),
DropArea char(100),
Booking_id	char(100),
Booking_type Char(100),
Booking_mode char(100),
Driver_number Char(100),
Service_status Char(100),
Status Char(100),
Fare INT,
Distance INT,
Confirmed_at char(100)
);
*/

SELECT * FROM Data;

/*Q2*/
SELECT Booking_mode, Count(*) as Cnt
FROM data 
WHERE booking_type = "p2p"
Group by Booking_mode;


/*Q4 - Find top 5 drop zones in terms of  average revenue*/
SELECT Zone_id, avg(fare) as AverageFare
FROM Localities as L INNER JOIN Data as D 
ON L.Area = d.droparea
Group by Zone_id
Order By Avg(Fare) DESC
Limit 5;

select distinct Driver_number, PickupArea, zone_id, count(PickupArea) as count_pickupzone
 from data 
 join localities 
 on PickupArea=Area
 group by PickupArea
 order by count(PickupArea) desc 
 limit 5; 

/*Using View*/
Create View Top5PickZones As
SELECT zone_id, Sum(fare) as SumRevenue
FROM Data as D, Localities as L
WHERE D.pickuparea = L.Area
Group By Zone_id
Order By 2 DESC
Limit 5;

SELECT Distinct zone_id, driver_number
FROM localities as L INNER JOIN Data as D ON L.Area = D.PickupArea
WHERE zone_id IN (Select Zone_id FROM Top5PickZones);

/*Another method*/
/*Q5 - Find all unique driver numbers grouped by top 5 pickzones*/
SELECT Distinct Zone_id, driver_number
FROM (
SELECT DISTINCT Zone_id, pickuparea
FROM Localities as L INNER JOIN Data as D 
ON L.Area = d.pickuparea
Group by Zone_id
Order By Sum(Fare) DESC 
Limit 5) As TPZ, Data as d 
WHERE TPZ.pickuparea = d.pickuparea; 


SELECT Distinct Zone_id, driver_number
FROM (
SELECT DISTINCT Zone_id, pickuparea
FROM Localities as L INNER JOIN Data as D 
ON L.Area = d.pickuparea
Group by Zone_id
Order By Sum(Fare) DESC 
Limit 5) As TPZ, Data as d 
WHERE TPZ.pickuparea = d.pickuparea; 


/*Q7 - Make a hourwise table of bookings for week between Nov01-Nov-07 and highlight the hours with more than average no.of bookings day wise*/

/*Part 1*/
SELECT * FROM data;

/*Part 1 - Hour-wise no of bookings*/
SELECT Hour(str_To_date(pickup_time,"%H:%i:%s")) as Hr, Count(*) as TotalBookings
FROM Data 
WHERE str_to_date(pickup_date,"%d-%m-%Y") between '2013-11-01' and '2013-11-07'
Group By Hour(str_to_date(pickup_time,"%H:%i:%s"))
Order by 1;

/*Part 2 - Avge Daily Bookings*/
SELECT Avg(NoOfBookingsDaily)
FROM (
SELECT Day(str_to_date(pickup_date,"%d-%m-%Y")), count(*) as NoOfBookingsDaily
FROM data 
Group By Day(str_to_date(pickup_date,"%d-%m-%Y"))) as tt;

/*Combined - Part 1 & Part 2 - ANSWER*/
SELECT Hour(str_To_date(pickup_time,"%H:%i:%s")) as Hr, Count(*) as TotalBookings
FROM Data 
WHERE str_to_date(pickup_date,"%d-%m-%Y") between '2013-11-01' and '2013-11-07'
Group By Hour(str_to_date(pickup_time,"%H:%i:%s"))
HAVING Count(*) > (SELECT Avg(NoOfBookingsDaily)
FROM (
SELECT Day(str_to_date(pickup_date,"%d-%m-%Y")), count(*) as NoOfBookingsDaily
FROM data 
Group By Day(str_to_date(pickup_date,"%d-%m-%Y"))) as tt)
Order By 1 ASC;


Select Hour(Pickup_time), Count(*) as NoOfBookings
FROM data 
WHERE pickup_date between '2013-11-01' and '2013-11-07'
Group By Hour(pickup_time)
HAVING Count(*) > (SELECT Avg(Bookings) as AvgBookings
FROM (Select Pickup_date, Count(*) as Bookings
FROM data 
WHERE pickup_date between '2013-11-01' and '2013-11-07'
Group By pickup_date) as TempTable);
