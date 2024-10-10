-- EC_IT143_W4.2_hello_world_s1_ss.sql
-- Q: What is the current date and time?

-- EC_IT143_W4.2_hello_world_s2_ss.sql
-- A: Let's ask SQL Server and find out...

-- EC_IT143_W4.2_hello_world_s3_ss.sql
SELECT 'Hello World' AS my_message
	, GETDATE() AS current_date_time;

-- EC_IT143_W4.2_hello_world_s4_ss.sql
DROP VIEW IF EXISTS dbo.v_hello_world_load;
GO

CREATE VIEW dbo.v_hello_world_load
AS

	SELECT 'Hello World' AS my_message
		, GETDATE() AS current_date_time;

-- EC_IT143_W4.2_hello_world_s5.1_ss.sql
SELECT v.my_message
	, v.current_date_time
	INTO dbo.t_hello_world
  FROM dbo.v_hello_world_load AS v;

-- EC_IT143_W4.2_hello_world_s5.2_ss.sql
DROP TABLE IF EXISTS dbo.t_hello_world;
GO

CREATE TABLE dbo.t_hello_world
(my_message		VARCHAR(25) NOT NULL,
 current_date_time DATETIME NOT NULL
							DEFAULT GETDATE(),
 CONSTRAINT PK_t_hello_world PRIMARY KEY CLUSTERED(my_message ASC)
 );
 GO

-- EC_IT143_W4.2_hello_world_s6_ss.sql
-- 1) Reload data

TRUNCATE TABLE dbo.t_hello_world;

INSERT INTO dbo.t_hello_world
		SELECT v.my_message
			, v.current_date_time
		  FROM dbo.v_hello_world_load AS v;

-- 2) Review results

SELECT t.*
	FROM dbo.t_hello_world AS t;

-- EC_IT143_W4.2_hello_world_s7_ss.sql
CREATE PROCEDURE dbo.usp_hello_world_load
AS

	BEGIN
		-- 1) Reload data

		TRUNCATE TABLE dbo.t_hello_world;

		INSERT INTO dbo.t_hello_world
				SELECT v.my_message
					, v.current_date_time
				  FROM dbo.v_hello_world_load AS v;

		-- 2) Review results

		SELECT t.*
			FROM dbo.t_hello_world AS t;

	END;
GO

-- EC_IT143_W4.2_hello_world_s8_ss.sql
EXEC dbo.usp_hello_world_load;