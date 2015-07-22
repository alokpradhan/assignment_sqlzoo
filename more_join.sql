-- List the films where the yr is 1962 [Show id, title]

SELECT id, title
  FROM movie
  WHERE yr=1962

-- Give year of 'Citizen Kane'.

SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr

-- What are the titles of the films with id 11768, 11955, 21191

SELECT title
  FROM movie
  WHERE id IN (11768, 11955, 21191)

-- What id number does the actress 'Glenn Close' have?

SELECT id
  FROM actor
  WHERE name = 'Glenn Close'

-- What is the id of the film 'Casablanca'

SELECT id
  FROM movie
  WHERE title = 'Casablanca'

-- Obtain the cast list for 'Casablanca'. Use movieid=11768, this is the value that you obtained in the previous question.

SELECT name
  FROM actor JOIN casting ON (actor.id=actorid)
  WHERE movieid = 11768

-- Obtain the cast list for the film 'Alien'

SELECT actor.name
  FROM actor JOIN casting ON (actor.id=actorid)
             JOIN movie ON (movie.id=movieid)
  WHERE movie.title = 'Alien'

-- List the films in which 'Harrison Ford' has appeared

SELECT movie.title
  FROM actor JOIN casting ON (actor.id=actorid)
             JOIN movie ON (movie.id=movieid)
  WHERE actor.name = 'Harrison Ford'

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT movie.title
  FROM actor JOIN casting ON (actor.id=actorid)
             JOIN movie ON (movie.id=movieid)
  WHERE actor.name = 'Harrison Ford' AND casting.ord <> 1

-- List the films together with the leading star for all 1962 films.

SELECT movie.title, actor.name
  FROM actor JOIN casting ON (actor.id=actorid)
             JOIN movie ON (movie.id=movieid)
  WHERE movie.yr = 1962 AND casting.ord = 1

-- Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) 
  FROM actor JOIN casting ON (actor.id=actorid)
             JOIN movie ON (movie.id=movieid)
  WHERE name='John Travolta'
  GROUP BY yr
  HAVING COUNT(title) > 2

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
-- ask for alias name for subquery!!

SELECT movie.title, actor.name
  FROM actor JOIN casting ON (actor.id=actorid)
             JOIN movie ON (movie.id=movieid)
  WHERE ord = 1 AND movieid IN 
  (
    SELECT movieid FROM casting
      WHERE actorid IN (
        SELECT id FROM actor
        WHERE name='Julie Andrews')
  )

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

SELECT name
FROM
(SELECT actor.name
FROM casting JOIN actor ON casting.actorid= actor.id
                       JOIN movie ON casting.movieid=movie.id
WHERE ord=1) AS top_actors
GROUP BY name
HAVING count(name) > 29
ORDER BY name ASC

-- List the films released in the year 1978 ordered by the number of actors in the cast.

SELECT DISTINCT movie.title, count(actorid) as actors
FROM casting JOIN movie ON casting.movieid=movie.id
WHERE yr = 1978
GROUP BY movieid
ORDER BY actors DESC

-- List all the people who have worked with 'Art Garfunkel'.

SELECT  DISTINCT actor.name
      FROM casting JOIN actor ON casting.actorid= actor.id
                       JOIN movie ON casting.movieid=movie.id
WHERE movieid IN
(SELECT movieid
FROM casting JOIN actor ON casting.actorid= actor.id
                       JOIN movie ON casting.movieid=movie.id
WHERE actor.name = 'Art Garfunkel' 
)  
AND name != 'Art Garfunkel'



