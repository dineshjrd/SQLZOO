/*1.  Modify it to show the matchid and player name for all goals scored by Germany. */
SELECT matchid,player FROM goal 
  WHERE teamid = 'GER'

/*2. Show id, stadium, team1, team2 for just game 1012 */  
SELECT id,stadium,team1,team2
  FROM game
where id =1012

/* 3. Modify it to show the player, teamid, stadium and mdate and for every German goal.*/
Select player,teamid, stadium, mdate
from game join goal
on matchid=id
where goal.teamid='GER'

/* 4. Show the team1, team2 and player for every goal scored by a player called Mario*/

select game.team1,game.team2,goal.player 
from game,goal
where game.id=goal.matchid and
goal.player like 'Mario%'

/*5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */
Select goal.player, goal.teamid,eteam.coach,goal.gtime
from goal,eteam
where goal.teamid=eteam.id
and goal.gtime <=10

/*6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */
Select game.mdate,eteam.teamname
from game join eteam on game.team1=eteam.id
where eteam.coach='Fernando Santos'

/* 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */
Select goal.player from goal,game
where goal.matchid=game.id
and game.stadium='National Stadium, Warsaw'

/* 8. Instead show the name of all players who scored a goal against Germany.*/
SELECT distinct player
FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER') and goal.teamid <> 'GER'
    
/*9. Show teamname and the total number of goals scored. */    
Select eteam.teamname,count(matchid) as total_goals
from goal join eteam on goal.teamid=eteam.id
group by eteam.teamname

/*10.  Show the stadium and the number of goals scored in each stadium. */
Select game.stadium,count(goal.matchid) as Number_of_goals_scored
from game join goal on game.id=goal.matchid
group by game.stadium

/*11. For every match involving 'POL', show the matchid, date and the number of goals scored. */
Select goal.matchid,game.mdate, count(goal.matchid) as Number_of_goals_scored
from game join goal on game.id=goal.matchid
where game.team1='POL' or game.team2='POL'
group by 1,2

/* 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'*/

Select goal.matchid,game.mdate, count(goal.matchid) as Number_of_goals_scored
from game join goal on game.id=goal.matchid
where game.team1='POL' or game.team2='POL'
group by 1,2

/* 13. List every match with the goals scored by each team as shown.*/
SELECT mdate,  team1,  sum(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2, sum(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON id=matchid
group by  1,2,4
order by mdate,matchid,team1,team2
