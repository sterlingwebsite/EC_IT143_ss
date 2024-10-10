-- EC_IT143_W4.2_data_science_s1_ss.sql
-- Q: What is the average salary for data scientists in different countries?

-- EC_IT143_W4.2_data_science_s2_ss.sql
-- A: Let's ask SQL Server and find out...

-- EC_IT143_W4.2_data_science_s3_ss.sql

SELECT TOP 100
    company_location, 
    AVG(salary_in_usd) AS average_salary,
	job_title
FROM 
    dbo.ds_salaries
WHERE
	job_title LIKE '%Data Scientist%'
GROUP BY 
    company_location, job_title
ORDER BY average_salary DESC;

-- EC_IT143_W4.2_data_science_s4_ss.sql

DROP VIEW IF EXISTS dbo.v_data_science_load;
GO

CREATE VIEW dbo.v_data_science_load
AS

	SELECT TOP 100
		company_location, 
		AVG(salary_in_usd) AS average_salary,
		job_title
	FROM 
		dbo.ds_salaries
	WHERE
		job_title LIKE '%Data Scientist%'
	GROUP BY 
		company_location, job_title
	ORDER BY average_salary DESC;

-- EC_IT143_W4.2_data_science_s5.1_ss.sql

SELECT v.company_location
	, v.average_salary
	, v.job_title
	INTO dbo.t_data_science
	FROM dbo.v_data_science_load AS v;

-- EC_IT143_W4.2_data_science_s5.2_ss.sql

DROP TABLE IF EXISTS dbo.t_data_science;
GO

CREATE TABLE dbo.t_data_science
(company_location	VARCHAR(2) NOT NULL,
 average_salary		INT NOT NULL,
 job_title			VARCHAR(50) NOT NULL
 );
 GO

 -- EC_IT143_W4.2_data_science_s6_ss.sql

-- 1) Reload data

TRUNCATE TABLE dbo.t_data_science;

INSERT INTO dbo.t_data_science
	SELECT v.company_location
		, v.average_salary
		, v.job_title
	FROM dbo.v_data_science_load AS v;

-- 2) Review results

SELECT t.*
FROM dbo.t_data_science AS t;


-- EC_IT143_W4.2_data_science_s7_ss.sql

CREATE PROCEDURE dbo.usp_data_science_load
AS

	BEGIN
		-- 1) Reload data

		TRUNCATE TABLE dbo.t_data_science;

		INSERT INTO dbo.t_data_science
			SELECT v.company_location
				, v.average_salary
				, v.job_title
			FROM dbo.v_data_science_load AS v;

		-- 2) Review results

		SELECT t.*
		FROM dbo.t_data_science AS t;

	END;
GO

-- EC_IT143_W4.2_data_science_s8_ss.sql

EXEC dbo.usp_data_science_load;