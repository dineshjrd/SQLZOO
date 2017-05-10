/*1. List the films where the yr is 1962 [Show id, title]  */
 select id,title from movie
where yr = 1962

/*2. Give year of 'Citizen Kane'.  */
Select yr from movie
where title='Citizen Kane'

/*List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.  */
Select id,title, yr from movie
where title like '%Star Trek%'

/*4. What id number does the actor 'Glenn Close' have?  */
select id from actor
where name='Glenn Close'

/*5. What is the id of the film 'Casablanca'  */
select id from movie
where title ='Casablanca'

/* 6. Obtain the cast list for 'Casablanca'. */
Select actor.name from movie join actor join casting
on movie.id=casting.movieid and actor.id=casting.actorid
where title='Casablanca'


/*Obtain the cast list for the film 'Alien'  */
Select actor.name from movie join actor join casting
on movie.id=casting.movieid and actor.id=casting.actorid
where title='Alien'

/*8. List the films in which 'Harrison Ford' has appeared  */
Select title from movie join actor join casting
on movie.id=casting.movieid and actor.id=casting.actorid
where actor.name='Harrison Ford'

/*9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]  */
Select title from movie join actor join casting
on movie.id=casting.movieid and actor.id=casting.actorid
where actor.name='Harrison Ford' and casting.ord <>1

/*10. List the films together with the leading star for all 1962 films.  */
Select movie.title,actor.name from movie join actor join casting
on movie.id=casting.movieid and actor.id=casting.actorid
where movie.yr=1962 and casting.ord=1

/*11.Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies   */
Select movie.yr, count(movie.yr) as number_of_movies
from movie join casting join actor
on movie.id = casting.movieid and actor.id=casting.actorid
where actor.name='John Travolta'
group by 1
having count(movie.yr) >2

/*12.  List the film title and the leading actor for all of the films 'Julie Andrews' played in.  */
Select movie.title,actor.name 
from movie inner join casting inner join actor 
on movie.id=casting.movieid and casting.actorid=actor.id
where movie.id in
(Select movie.id
from movie inner join casting inner join actor 
on movie.id=casting.movieid and casting.actorid=actor.id
where actor.name='Julie Andrews')
and casting.ord=1

/*13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.  */
Select actor.name 
from movie inner join casting inner join actor 
on movie.id=casting.movieid and casting.actorid=actor.id
where casting.ord=1
group by 1
having count(*) >= 30
order by 1

/*14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.  */

Select movie.title, count(actorid)
from movie inner join casting inner join actor 
on movie.id=casting.movieid and casting.actorid=actor.id
where movie.yr=1978
group by 1
order by 2 desc,1 
