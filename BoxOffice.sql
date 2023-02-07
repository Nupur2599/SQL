
use Box_office;

Select * 
from Movie_details;

/*How many movies were produced in each year*/

Alter Table movie_details
ADD Column New_date date;

select Movie_Name, release_date, str_to_date(LEFT(release_date, 10), "%d-%M-%Y")
from movie_details;

SET SQL_SAFE_UPDATES=0;
UPDATE movie_details
SET New_date= str_to_date(LEFT(release_date, 10), "%d-%M-%Y");

select new_date
from movie_details;

Select count(Movie_name), year(new_date)
from movie_details
group by year(new_date);

/*which movie has seen the highest box office collection world wide?*/

Select movie_name, movie_total_worldwide
from movie_commercials
order by movie_total_worldwide desc
limit 1;

/*how many movies we released under "Dharma" banner?*/
Select banner, count(movie_name)
from movie_details
where banner Like "Dharma%"
group by banner;

/*What is the total revenue gained under Yash Raj Films in different years?*/
Select md.banner, count(md.movie_name), year(md.new_date), sum(mc.movie_total_worldwide) 
from movie_details as md inner join movie_commercials as MC on MD.Movie_name= MC.Movie_name
where md.banner="Yash Raj Films"
group by md.banner, year(md.new_date);

/*Top 5 Directors in terms of world wide collection*/
select MD.Movie_director, sum(MC.movie_total_worldwide) AS TotalCollection
from movie_commercials as MC Inner join Movie_details as MD on MC.Movie_name= MD.Movie_name
group by md.movie_director
order by TotalCollection desc
Limit 5;

/*Which movies have seen the lowest collection? limit the data to 5*/

Select MC.Movie_name, MC.movie_opening, year(MD.new_date)
from movie_commercials as MC inner join movie_details as MD on MC.Movie_name= MD.Movie_Name
order by MC.movie_opening
limit 5;

/*Which movie earned the highest revenue during the opening?*/
 
Select movie_name, movie_opening
from movie_commercials
order by movie_opening desc
Limit 1;


/*Rank the movies on the basis of lowest opening earnings and partition them by years*/
Select *
from(Select MC.Movie_name, MC.Movie_Opening, MD.New_date, 
DENSE_rank()over(partition by year(MD.new_date) order by MC.Movie_opening asc)as DRank
from movie_commercials as MC Inner join Movie_details as MD on MC.Movie_name=MD.Movie_name) as Temptable;

Select MC.Movie_name, MC.Movie_Opening, MD.New_date, 
DENSE_rank()over(partition by year(MD.new_date) order by MC.Movie_opening asc)as DRank
from movie_commercials as MC Inner join Movie_details as MD on MC.Movie_name=MD.Movie_name;

/*List the hit movies and rank them on the basis of their worldwide collection*/
Select MC.Movie_name, MC.movie_total_worldwide, MD.New_date, 
rank()over(partition by year(MD.new_date) order by MC.Movie_total_worldwide desc)as Hits
from movie_commercials as MC Inner join Movie_details as MD on MC.Movie_name=MD.Movie_name;


/*Movies released on Friday that have seen the highest openings*/
select MD.movie_name, dayname(MD.new_date), MC.movie_opening, 
rank()over(order by MC.Movie_opening desc)as HighestOpening
from movie_details as MD inner join movie_commercials as MC on MD.movie_name=MC.movie_name
where dayname(MD.new_date)="Friday";

/*Which genre has received appreciation in terms of avg world wide collection*/
select MD.movie_genre,avg(MC.movie_total_worldwide), 
rank()over(order by avg(MC.Movie_total_worldwide) desc)as AverageTotal
from movie_details as MD inner join movie_commercials as MC on MD.movie_name=MC.movie_name
group by Md.movie_Genre;

/*How many movies were release on Friday?*/
Select Count(movie_name), dayname(new_date)
from movie_details
where dayname(new_date)="Friday";

/*grouping movies on the basis of genres*/

select movie_genre, count(movie_Genre) as NoOfMovies
from movie_details
group by movie_genre
Order by 2 desc
Limit 5;

/*Does higher Runtime imply more popularity? Base your answer on the basis of total collection made by the movie having runtime >150 mins */
Select mc.movie_name, movie_total, Runtime
from movie_commercials as mc inner join movie_details as md on mc.movie_name=md.movie_name
where md.runtime >150
order by 3 desc;

/*Write a query to list the movies that did not make a collection after the first week*/

Select movie_name, movie_firstweek, movie_total
from movie_commercials
where movie_firstweek=movie_total;

/*Based on their worldwide collection, find the sum of revenues of all genres. Which Genre has made the highest collection?*/

Select  movie_Genre, round(sum(movie_total_worldwide),2) as TotalRevenue
From movie_commercials as mc inner join movie_details as md on mc.movie_name=md.movie_name
group by movie_genre
Order by 2 desc;

/*Find the count of movies produced under T series banner*/
Select round(avg(mc.movie_total_worldwide),2), count(md.banner) as TotalMovies
from movie_details as md inner join movie_commercials as mc on md.movie_name=mc.movie_name 
where banner like "T-Series%";

