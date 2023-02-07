create database hollywood_synopsis;

use hollywood_synopsis;

/*List all the movies of Walt Disney.*/
select movie
from highestgrossers
where distributor="Walt Disney"
group by movie;

/*List the movies where genre was Adventure and MPAA Ratings was PG-13.*/
select movie
from highestgrossers
where genre="Adventure" and MPAA_RATING="PG-13"
group by movie;

/*CLassify the number of movies with respect to top distributors.*/
select distributors,movies
from topdistributors
order by movies desc;

/*Show how many tickets were sold for each year where average ticket price was more than $7.00*/
select year,tickets_sold,avg_ticketprice
from annualticketsales
where avg_ticketprice>7.00;

/*Show the data of release of all episodes of Star Wars between years 1995-2021.*/
select *
from highestgrossers
where movie like "%Star Wars%";

/*Show the data of top genres with respect to their market shares.*/
select genres,marketshare
from topgenres;

/*Show the data of top grossing ratings with respect to their market shares.*/
select mpaa_ratings,marketshare
from topgrossingratings;

/*Show the data of top distributors with respect to their market shares.*/
select distributors,marketshare
from topdistributors;