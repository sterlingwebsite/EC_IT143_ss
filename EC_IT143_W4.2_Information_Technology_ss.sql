-- EC_IT143_W4.2_information_technology_s1_ss.sql
-- Q: What is the average salary for data science roles in 2023?

-- EC_IT143_W4.2_information_technology_s2_ss.sql
-- A: Let's ask SQL Server and find out...

-- EC_IT143_W4.2_information_technology_s3_ss.sql

SELECT TOP 100
	job_title,
	AVG(salary_in_usd) AS average_salary
FROM
	dbo.[ds_salaries (2)]
WHERE
	work_year = 2023
GROUP BY
	job_title
ORDER BY
	average_salary DESC;

-- EC_IT143_W4.2_information_technology_s4_ss.sql

DROP VIEW IF EXISTS dbo.v_information_technology_load;
GO

CREATE VIEW dbo.v_information_technology_load
AS
	SELECT TOP 100
		job_title,
		AVG(salary_in_usd) AS average_salary
	FROM
		dbo.[ds_salaries (2)]
	WHERE
		work_year = 2023
	GROUP BY
		job_title
	ORDER BY
		average_salary DESC;

-- EC_IT143_W4.2_information_technology_s5.1_ss.sql

SELECT v.job_title,
	v.average_salary
INTO dbo.t_information_technology
FROM dbo.v_information_technology_load AS v;

-- EC_IT143_W4.2_information_technology_s5.2_ss.sql

DROP TABLE IF EXISTS dbo.t_information_technology;
GO

CREATE TABLE dbo.t_information_technology
(job_title		VARCHAR(50) NOT NULL,
average_salary	INT NOT NULL
);
GO

 -- EC_IT143_W4.2_information_technology_s6_ss.sql

-- 1) Reload data

TRUNCATE TABLE dbo.t_information_technology;

INSERT INTO dbo.t_information_technology
	SELECT v.job_title,
		v.average_salary
	FROM dbo.v_information_technology_load AS v;

-- 2) Review results

SELECT t.*
FROM dbo.t_information_technology AS t;

-- EC_IT143_W4.2_information_technology_s7_ss.sql

CREATE PROCEDURE dbo.usp_information_technology_load
AS

	BEGIN
		-- 1) Reload data

		TRUNCATE TABLE dbo.t_information_technology;

		INSERT INTO dbo.t_information_technology
			SELECT v.job_title,
				v.average_salary
			FROM dbo.v_information_technology_load AS v;

		 --2) Review results

		SELECT t.*
		FROM dbo.t_information_technology AS t;

	END;
GO

-- EC_IT143_W4.2_information_technology_s8_ss.sql

EXEC dbo.usp_information_technology_load;