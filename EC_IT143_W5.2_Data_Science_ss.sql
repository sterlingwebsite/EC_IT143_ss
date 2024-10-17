/*
EC_IT143_W5.2_Data_Science_ss
5.2 Final Project: My Communities Analysis—Create Answers
*/

--Simpsons

-- Who is spending the most? They are trying to make a budget and want to find out where the money is going
-- to. How much is going to each category? (from Eric Roe)
SELECT 
    fd.Name AS Card_Owner,
    pe.Category,
    SUM(pe.Amount) AS Total_Charges
FROM 
    dbo.Planet_Express pe
JOIN 
    dbo.Family_Data fd ON LOWER(pe.Card_Member) = LOWER(fd.Name)
GROUP BY 
    fd.Name, pe.Category
ORDER BY 
    fd.Name, pe.Category;

--Which character appears in the most episodes?
SELECT 
    c.name, 
    COUNT(DISTINCT s.episode_id) AS Episode_Count
FROM 
    dbo.simpsons_characters c
JOIN 
    dbo.simpsons_script_lines s ON c.id = s.character_id
GROUP BY 
    c.name
ORDER BY 
    Episode_Count DESC;

--What is the average IMDb rating of episodes for each season of “The Simpsons” and how many
--characters appeared in each season?
SELECT 
    se.season, 
    AVG(se.imdb_rating) AS average_rating, 
    COUNT(DISTINCT ssl.character_id) AS character_count
FROM 
    dbo.simpsons_episodes se
JOIN 
    dbo.simpsons_script_lines ssl 
    ON se.id = ssl.episode_id
GROUP BY 
    se.season
ORDER BY 
    se.season;

--Which characters have spoken the most lines in episodes with an IMDb rating of 8.0 or higher?
SELECT 
    sc.name, 
    COUNT(ssl.id) AS line_count
FROM 
    dbo.simpsons_characters sc
JOIN 
    dbo.simpsons_script_lines ssl 
    ON sc.id = ssl.character_id
JOIN 
    dbo.simpsons_episodes se 
    ON ssl.episode_id = se.id
WHERE 
    se.imdb_rating >= 8.0
GROUP BY 
    sc.name
ORDER BY 
    line_count DESC;

