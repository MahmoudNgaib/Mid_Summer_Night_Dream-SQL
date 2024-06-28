use [Mid summer]

/* 
	let's insert data into table : amnd,
	using a procedure
*/
CREATE PROCEDURE PRO_1
AS
BEGIN
    DECLARE @current_character NVARCHAR(255);
    DECLARE @currentLine NVARCHAR(MAX);
    DECLARE @start_time DATETIME2(7), @end_time DATETIME2(7), @execution_time FLOAT;

    SET @start_time = SYSDATETIME();

    -- Declare the first cursor for characters
    DECLARE cur_first CURSOR FOR 
    SELECT char_name FROM characters;

    -- Declare the second cursor for play text
    DECLARE cur_second CURSOR FOR 
    SELECT line FROM #PLAY_TEXT;

    -- Open the first cursor
    OPEN cur_first;
    FETCH NEXT FROM cur_first INTO @current_character;

    WHILE @@FETCH_STATUS = 0 
    BEGIN
        -- Open the second cursor
        OPEN cur_second;
        FETCH NEXT FROM cur_second INTO @currentLine;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF CHARINDEX(@current_character, UPPER(@currentLine)) > 0
            BEGIN
                INSERT INTO amnd(char_text, play_text)
                VALUES(@current_character, @currentLine);
            END

            FETCH NEXT FROM cur_second INTO @currentLine;
        END

        -- Close the second cursor after processing all lines
        CLOSE cur_second;

        FETCH NEXT FROM cur_first INTO @current_character;
    END

    -- Deallocate cursors
    DEALLOCATE cur_second;

    SET @end_time = SYSDATETIME();
    SET @execution_time = DATEDIFF_BIG(MICROSECOND, @start_time, @end_time) / 1000000.0;
    
    INSERT INTO performance (action_TEXT, query_time) VALUES ('CREATE', @execution_time);
    
    CLOSE cur_first;
    DEALLOCATE cur_first;
END;

exec PRO_1
