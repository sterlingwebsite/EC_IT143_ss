-- EC_IT143_6.3_fwt_s1_ss.sql
-- Q1: How to keep track of when a record was last modified?
-- A1: This works for the initial INSERT ...

ALTER TABLE dbo.t_hello_world
ADD last_modified_date DATETIME DEFAULT GETDATE();

-- Q2: How to keep track of when a record was last modified?

-- EC_IT143_6.3_fwt_s2_ss.sql
-- A2: Maybe use an after update trigger?

-- EC_IT143_6.3_fwt_s3_ss.sql
-- https://stackoverflow.com/questions/9522982/t-sql-trigger-update
-- https://stackoverflow.com/questions/4574010/how-to-create-trigger-to-keep-track-of-last-changed-data

-- EC_IT143_6.3_fwt_s4_ss.sql
Drop Trigger trg_hello_world_last_mod
DROP TRIGGER trg_hello_world_almost_last_mod
CREATE TRIGGER trg_hello_world_last_mod 
ON dbo.t_hello_world
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.t_hello_world
    SET 
        last_modified_date = GETDATE(),
        last_modified_by = SUSER_NAME()
    WHERE my_message IN (SELECT DISTINCT my_message FROM Inserted);
END;
GO


-- EC_IT143_6.3_fwt_s5_ss.sql
-- Q3: Did it work?
-- A3: Well, lets see ... yup

-- Delete existing test rows
DELETE FROM dbo.t_hello_world
WHERE my_message IN ('Hello World2', 'Hello World3', 'Hello World4');

-- Load test rows
INSERT INTO dbo.t_hello_world (my_message)
VALUES ('Hello World2'), ('Hello World3');

-- See if the trigger worked
SELECT t.*
FROM dbo.t_hello_world AS t;

-- Update and test the trigger again
UPDATE dbo.t_hello_world 
SET my_message = 'Hello World4'
WHERE my_message = 'Hello World3';

-- See if the trigger worked
SELECT t.*
FROM dbo.t_hello_world AS t;

-- EC_IT143_6.3_fwt_s6_ss.sql
-- Q4: How to keep track of who last modified a record?
-- A4: This works for server user and the initial INSERT ...

ALTER TABLE dbo.t_hello_world
ADD last_modified_by VARCHAR(50) DEFAULT SUSER_NAME();

-- EC_IT143_6.3_fwt_s1_ss.sql
--How to keep track of who last modified a record.

ALTER TABLE dbo.t_hello_world
ADD last_modified_by VARCHAR(50) DEFAULT SUSER_NAME();

-- EC_IT143_6.3_fwt_s2_ss.sql
-- A2: Maybe use an after update trigger?

-- EC_IT143_6.3_fwt_s3_ss.sql
-- AI

-- EC_IT143_6.3_fwt_s4_ss.sql
CREATE TRIGGER trg_hello_world_last_mod 
ON dbo.t_hello_world
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.t_hello_world
    SET 
        last_modified_date = GETDATE(),
        last_modified_by = SUSER_NAME()
    WHERE my_message IN (SELECT DISTINCT my_message FROM Inserted);
END;
GO

-- EC_IT143_6.3_fwt_s5_ss.sql
-- Q3: Did it work?
-- A3: Well, lets see ... yup

-- Delete existing test rows
DELETE FROM dbo.t_hello_world
WHERE my_message IN ('Hello World2', 'Hello World3', 'Hello World4');

-- Load test rows
INSERT INTO dbo.t_hello_world (my_message)
VALUES ('Hello World2'), ('Hello World3');

-- See if the trigger worked
SELECT t.*
FROM dbo.t_hello_world AS t;

-- Update and test the trigger again
UPDATE dbo.t_hello_world 
SET my_message = 'Hello World4'
WHERE my_message = 'Hello World3';

-- See if the trigger worked
SELECT t.*
FROM dbo.t_hello_world AS t;

-- EC_IT143_6.3_fwt_s6_ss.sql
-- no more questions