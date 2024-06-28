CREATE PROCEDURE Update_procedure
AS
BEGIN
    DECLARE @current_character NVARCHAR(50);
    DECLARE @lower_character NVARCHAR(50);
    DECLARE @UPPER_character NVARCHAR(50);
    DECLARE @start_time DATETIME2(7), @end_time DATETIME2(7), @execution_time FLOAT;

    DECLARE cur CURSOR FOR
    SELECT char_name FROM characters;

    OPEN cur;
    FETCH NEXT FROM cur INTO @current_character;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @lower_character = LOWER(@current_character);
        SET @UPPER_character = UPPER(@current_character);

        -- Record the start time
        SET @start_time = SYSDATETIME();

        -- Update the play text
        UPDATE amnd
        SET play_text = REPLACE(CAST(play_text AS NVARCHAR(MAX)), @lower_character, @UPPER_character)
        WHERE CHARINDEX(@lower_character, LOWER(CAST(play_text AS NVARCHAR(MAX)))) > 0;

        -- Record the end time
        SET @end_time = SYSDATETIME();

        -- Calculate the execution time in seconds with precision
        SET @execution_time = DATEDIFF_BIG(MICROSECOND, @start_time, @end_time) / 1000000.0;

        -- Insert the action and execution time into the performance table
        INSERT INTO performance (action_TEXT, query_time)
        VALUES ('UPDATE ' + @current_character, @execution_time);

        FETCH NEXT FROM cur INTO @current_character;
    END;

    CLOSE cur;
    DEALLOCATE cur;
END;
drop procedure Update_procedure;
exec Update_procedure

select * from performance