--EC_IT143_6.3_fwf_s1_ss.sql
--How to extract the first name from the contact name.

--EC_IT143_6.3_fwf_s2_ss.sql
--A: Well, here is your problem ...
--CustomerName = Alejandra Camino -> Alejandra

--EC_IT143_6.3_fwf_s3_ss.sql
SELECT t. ContactName
FROM dbo.t_w3_schools_customers AS t
ORDER BY 1;

--EC_IT143_6.3_fwf_s4_ss.sql
-- Google search "How to extract first name from combined name tsql stack overflow"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name
SELECT 
    t.ContactName, 
    LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') - 1) AS first_name
FROM 
    dbo.t_w3_schools_customers AS t
ORDER BY 
    1;

--EC_IT143_6.3_fwf_s5_ss.sql
CREATE FUNCTION [dbo].[udf_parse_first_name]
(@v_combined_name AS VARCHAR(500)
)
RETURNS VARCHAR(100)

	BEGIN

		DECLARE @v_first_name AS VARCHAR(100);

		SET @v_first_name = LEFT(@v_combined_name, CHARINDEX(' ', @v_combined_name +' ') - 1);

		RETURN @v_first_name;

	END;

GO

--EC_IT143_6.3_fwf_s6_ss.sql
SELECT 
    t.ContactName, 
    LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') - 1) AS first_name, 
    dbo.udf_parse_first_name(t.ContactName) AS first_name2
FROM 
    dbo.t_w3_schools_customers AS t
ORDER BY 
    1;

--EC_IT143_6.3_fwf_s7_ss.sql
WITH s1 AS (
    SELECT 
        t.ContactName, 
        LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') - 1) AS first_name, 
        dbo.udf_parse_first_name(t.ContactName) AS first_name2
    FROM 
        dbo.t_w3_schools_customers AS t
)
SELECT 
    s1.*
FROM 
    s1
WHERE 
    s1.first_name <> s1.first_name2;

--EC_IT143_6.3_fwf_s8_ss.sql
SELECT 
    t.CustomerID,
    t.CustomerName,
    t.ContactName,
    dbo.udf_parse_first_name(t.ContactName) AS ContactName_first_name,
    LTRIM(RIGHT(t.ContactName, LEN(t.ContactName) - CHARINDEX(' ', t.ContactName + ' ') + 1)) AS ContactName_last_name,
    t.Address,
    t.City,
    t.Country
FROM 
    dbo.t_w3_schools_customers AS t
ORDER BY 
    t.ContactName;

--EC_IT143_6.3_fwf_s1_ss.sql
--How to extract the last name from the contact name.

--EC_IT143_6.3_fwf_s2_ss.sql
--A: Well, here is your problem ...
--CustomerName = Alejandra Camino -> Camino

--EC_IT143_6.3_fwf_s3_ss.sql
SELECT t. ContactName
FROM dbo.t_w3_schools_customers AS t
ORDER BY 1;

--EC_IT143_6.3_fwf_s4_ss.sql
-- help from AI
SELECT 
    t.ContactName,
    LTRIM(RIGHT(t.ContactName, LEN(t.ContactName) - CHARINDEX(' ', t.ContactName + ' ') + 1)) AS last_name
FROM 
    dbo.t_w3_schools_customers AS t
ORDER BY 
    1;

--EC_IT143_6.3_fwf_s5_ss.sql
CREATE FUNCTION [dbo].[udf_parse_last_name]
(@v_combined_name AS VARCHAR(500)
)
RETURNS VARCHAR(100)

	BEGIN

		DECLARE @v_last_name AS VARCHAR(100);

		SET @v_last_name = LTRIM(RIGHT(@v_combined_name, LEN(@v_combined_name) - CHARINDEX(' ', @v_combined_name +' ') + 1));

		RETURN @v_last_name;

	END;

GO

--EC_IT143_6.3_fwf_s6_ss.sql
SELECT 
    t.ContactName, 
    LTRIM(RIGHT(t.ContactName, LEN(t.ContactName) - CHARINDEX(' ', t.ContactName + ' ') + 1)) AS last_name, 
    dbo.udf_parse_last_name(t.ContactName) AS last_name2
FROM 
    dbo.t_w3_schools_customers AS t
ORDER BY 
    1;

--EC_IT143_6.3_fwf_s7_ss.sql
WITH s1 AS (
    SELECT 
        t.ContactName, 
		LTRIM(RIGHT(t.ContactName, LEN(t.ContactName) - CHARINDEX(' ', t.ContactName + ' ') + 1)) AS last_name, 
        dbo.udf_parse_last_name(t.ContactName) AS last_name2
    FROM 
        dbo.t_w3_schools_customers AS t
)
SELECT 
    s1.*
FROM 
    s1
WHERE 
    s1.last_name <> s1.last_name2;

--EC_IT143_6.3_fwf_s8_ss.sql
SELECT 
    t.CustomerID,
    t.CustomerName,
    t.ContactName,
    dbo.udf_parse_first_name(t.ContactName) AS ContactName_first_name,
    LTRIM(RIGHT(t.ContactName, LEN(t.ContactName) - CHARINDEX(' ', t.ContactName + ' ') + 1)) AS ContactName_last_name,
    t.Address,
    t.City,
    t.Country
FROM 
    dbo.t_w3_schools_customers AS t
ORDER BY 
    t.ContactName;