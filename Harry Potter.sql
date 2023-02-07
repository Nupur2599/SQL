CREATE DATABASE harry_potter;

USE harry_potter;/*Make the database Default*/
/*Create Table Wands
(id int,
code int,
coins_needed int,
power int)
Create Table Wands_property
(code int,
age int,
is_evil int)*/
select * from wands;
select * from wands_property;

/*Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
If more than one wand has same power, sort the result in order of descending age.*/
select w.id, p.age, w.coins_needed, w.power from Wands as w 
join Wands_Property as p
on w.code = p.code
where w.coins_needed = (select min(coins_needed)
                       from Wands w2 inner join Wands_Property p2 
                       on w2.code = p2.code 
                       where p2.is_evil = 0 and p.age = p2.age and w.power = w2.power)
order by w.power desc, p.age desc;






