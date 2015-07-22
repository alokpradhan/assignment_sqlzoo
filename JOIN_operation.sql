-- Show matchid and player name for all goals scored by Germany.

SELECT matchid, player
  FROM goal 
  WHERE teamid = 'GER'

-- Show id, stadium, team1, team2 for game 1012

SELECT id,stadium,team1,team2
  FROM game 
 WHERE id=1012

-- Show the player, teamid and mdate and for every German goal.

SELECT player,teamid, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid='GER'

-- Show the team1, team2 and player for every goal scored by a player called Mario

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%'

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on (teamid=id)
  WHERE gtime<=10

-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
  FROM game JOIN eteam ON (team1=eteam.id)
  WHERE coach = 'Fernando Santos'

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
  FROM game JOIN goal ON (id=matchid)
  WHERE stadium='National Stadium, Warsaw'

-- Instead show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
  WHERE (team1='GER' OR team2='GER') AND teamid <> 'GER'

-- Show teamname and the total number of goals scored.

SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname
  ORDER BY teamname

-- Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(*)
  FROM game JOIN goal ON (id=matchid)
  GROUP BY stadium

-- For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid,mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id
  WHERE teamid = 'GER'
  GROUP BY matchid

-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises. Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.

SELECT mdate, team1, sum(s1) as score1, team2, sum(s2) as score2
FROM
(SELECT mdate,
  id,
  team1,
  CASE WHEN teamid=team1 THEN 1 ELSE 0 END s1,
  team2,
  CASE WHEN teamid=team2 THEN 1 ELSE 0 END s2
  FROM game LEFT JOIN goal ON matchid = id) AS g
GROUP BY id
ORDER BY mdate, id, team1, team2













