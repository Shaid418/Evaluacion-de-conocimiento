 create database WORLD_CU
 
 
 
 create table teams (
      team_id integer not null,
      team_name varchar(30) not null,
      unique(team_id)
  );

  create table matches (
      match_id integer not null,
      host_team integer not null,
      guest_team integer not null,
      host_goals integer not null,
      guest_goals integer not null,
      unique(match_id)
  );

  Insert into teams values (10,'Give')
  
  Insert into teams values (20,'Never')
  
  Insert into teams values (30,'You')
  
  Insert into teams values (40,'UP')
  
  Insert into teams values (50,'GONNA')
  
 Insert into matches values (1,30,20,1,0)
 Insert into matches values (2,10,20,1,2)
 Insert into matches values (3,20,50,2,2)
 Insert into matches values (4,10,30,1,0)
 Insert into matches values (5,30,50,0,1)




    SELECT t.team_id, t.team_name, COALESCE(SUM(num_points), 0) AS num_points
    FROM(
         SELECT t.team_id, t.team_name,
          (CASE WHEN m.host_goals > m.guest_goals THEN 3
                WHEN m.host_goals = m.guest_goals THEN 1
                WHEN m.host_goals < m.guest_goals THEN 0
                END) AS num_points
         FROM teams t
         JOIN matches m
         ON t.team_id = m.host_team
         UNION
         SELECT t.team_id, t.team_name,
          (CASE WHEN m.guest_goals > m.host_goals THEN 3
                WHEN m.guest_goals = m.host_goals THEN 1
                WHEN m.guest_goals < m.host_goals THEN 0
                END) AS num_points
         FROM teams t
         JOIN matches m
         ON t.team_id = m.guest_team
    ) AS c
    RIGHT JOIN teams t
    ON t.team_id = c.team_id
    GROUP BY t.team_id, t.team_name
    ORDER BY COALESCE(SUM(num_points), 0) DESC, t.team_id


