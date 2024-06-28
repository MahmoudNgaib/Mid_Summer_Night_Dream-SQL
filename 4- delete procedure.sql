-- Declare variables for performance metrics
DECLARE @start_time DATETIME2(7), @end_time DATETIME2(7), @execution_time FLOAT;
DECLARE @numPlayLines_Before_Delete INT, @numPlayLines_After_Delete INT, @numPlayLines_Deleted INT;

-- Record the start time
SET @start_time = SYSDATETIME();

-- Get the count of lines before deletion
SELECT @numPlayLines_Before_Delete = COUNT(line_index) FROM amnd;

-- Delete stage directions using LIKE with wildcards
DELETE FROM amnd
WHERE play_text LIKE '%Enter%'
   OR play_text LIKE '%Exit%'
   OR play_text LIKE '%Act%'
   OR play_text LIKE '%Scene%'
   OR play_text LIKE '%Exeunt%';

-- Record the end time
SET @end_time = SYSDATETIME();

-- Get the count of lines after deletion
SELECT @numPlayLines_After_Delete = COUNT(line_index) FROM amnd;

-- Calculate number of lines deleted
SET @numPlayLines_Deleted = @numPlayLines_Before_Delete - @numPlayLines_After_Delete;

-- Calculate query execution time in seconds
SET @execution_time = DATEDIFF_BIG(MICROSECOND, @start_time, @end_time) / 1000000.0;

-- Print and record performance metrics
PRINT CONCAT(@numPlayLines_Deleted, ' rows deleted');
PRINT CONCAT('Total query time: ', @execution_time, ' seconds');

-- Insert performance metrics into performance table
INSERT INTO performance (action_TEXT, query_time)
VALUES ('DELETE', @execution_time);

EXEC Delete_procedure;
