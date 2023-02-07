

Use visitors_data;
show tables;

select * from profile;
select * from visitdata; 

/*List the Visitor ID, Time spent, Internet usage of the visitors from Japan*/
select vistid,time_spent,internet_usage
from visitdata vd
right join profile p on vd.vistid=p.vistid
where country_name="Japan";



/*List the profile details of the visitors who have internet usage greater than 250.*/
select * 
from profile p inner join visitdata vd 
on p.vistid=vd,vistid
where internet_usage>250;


/*Write a query to find out the visiting details of the visitors who are males.*/
select * 
from visitdata v
join profile p on v.vistid = p.vistid
where sex = "M";


/*List the customers who are active on the internet during Mid-night and are from Bangladesh.*/
select profiles.vistid, profiles.Country_Name, visitdata.Time_Period
from profiles inner join visitdata
on profiles.VistID = visitdata.VistID
where profiles.country_name = "Bangladesh" and visitdata.Time_Period = "Mid-Night";


/*List the visitor ID for Ad topic-Product_24 who are females.*/
select p.vistid, sex, ad_topic
from profile p
join visitdata v on p.vistid = v.vistid
where sex = "F" and ad_topic = "Product_24";


/* Find out the average time spent on Sundays in the month of April and July.*/
select month, avg(time_spent) as avgTime
from visitdata
where weekday in ("Sunday") and month in ("April","July")
group by month;

alter table profile
add column New_dob date;

set sql_safe_updates=0;

select str_to_date(dob,"%m/%d/%Y"),DOB
FROM PROFILE;

update profile
set New_Dob= str_to_date(dob,"%m/%d/%Y");

select new_dob
from profile;

/*Find out the number of Females born between 1st Jan 1974 to 31st Dec 1984.*/
select sex, count(sex) as NoOfFemales
from profile
where sex="F" and New_DOB between "1974-1-1" and "1984-12-31"
group by sex;

/*Find out the number of Males born between 1st march 1960 to 1st Dec 2001.*/
select count(sex) as NoOfMales
from profile
where sex="M" and New_DOB between "1960-3-1" and "2001-12-1";

select sex,count(sex)
from profile
where sex = "M" and (dob between "1/3/1960" and "1/12/2001");

/*Find out how many people from Bangladesh have average income greater than 55000.*/
select count(vistid) as Cnt
from profile
where country_name="Bangladesh" and avg_income>55000;


/*Find out the Gender wise data from countries where country name starts with "S".*/
select vistid, sex, country_name
from profile
where country_name like"S%" ;


select sex, country_name,count(sex)
from profile 
where left(country_name,1) in ('s')
group by sex;



