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




SELECT T4.team_id, TE.team_name, SUM(POINTS) Num_Points 
FROM(
	SELECT T.team_id, CASE WHEN host_goals > guest_goals THEN 3 WHEN host_goals = guest_goals THEN 1 WHEN host_goals < guest_goals THEN 0 END POINTS
	FROM (
		SELECT T.team_id, guest_team, host_goals, guest_goals
		FROM teams T 
		JOIN matches H ON T.team_id = H.host_team
	) T

	UNION ALL

	SELECT T3.team_id, CASE WHEN guest_goals > host_goals THEN 3 WHEN host_goals = guest_goals THEN 1 WHEN guest_goals < host_goals THEN 0 END POINTS
	FROM (
		SELECT T2.team_id, guest_team, host_goals, guest_goals
		FROM teams T2 
		JOIN matches G ON T2.team_id = G.guest_team
	) T3
) T4 
LEFT JOIN teams TE ON T4.team_id = TE.team_id
GROUP BY T4.team_id, TE.team_name



