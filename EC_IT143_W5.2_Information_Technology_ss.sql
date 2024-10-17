/*
EC_IT143_W5.2_Information_Technology_ss
5.2 Final Project: My Communities Analysis—Create Answers
*/

--I would like to know the total salary of Santiago Martinez and his player ID. Using the tblPlayerDim
--and tblPlayerFact tables; Can you list his player ID (pl_id) and the sum of all of his mtd_salary?
--From Justin Hemmert
SELECT 
    pd.pl_id,
    SUM(pf.mtd_salary) AS total_salary
FROM 
    dbo.tblPlayerDim pd
JOIN 
    dbo.tblPlayerFact pf ON pd.pl_id = pf.pl_id
WHERE 
    pd.pl_name = 'MARTINEZ, SANTIAGO'
GROUP BY 
    pd.pl_id;

--List all players and their respective teams.
SELECT 
    pd.pl_id,
    pd.pl_name,
    td.t_code
FROM 
    dbo.tblPlayerDim pd
JOIN 
    dbo.tblTeamDim td ON pd.t_id = td.t_id;


--Find the total number of players in each position.
SELECT 
    pd.p_name,
    COUNT(pdim.pl_id) AS total_players
FROM 
    dbo.tblPlayerDim pdim
JOIN 
    dbo.tblPositionDim pd ON pdim.p_id = pd.p_id
GROUP BY 
    pd.p_name;

--Calculate the average monthly salary for each team.
SELECT 
    td.t_code,
    AVG(pf.mtd_salary) AS avg_salary
FROM 
    dbo.tblPlayerFact pf
JOIN 
    dbo.tblPlayerDim pd ON pf.pl_id = pd.pl_id
JOIN 
    dbo.tblTeamDim td ON pd.t_id = td.t_id
GROUP BY 
    td.t_code;
