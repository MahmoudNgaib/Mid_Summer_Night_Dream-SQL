use [Mid summer]

-- CREATE TABLE amnd
if OBJECT_ID('amnd','U') IS not  NULL
	drop table amnd;
CREATE TABLE amnd (
	line_index INT NOT NULL IDENTITY(1,1),
	char_text TEXT,
	play_text TEXT,
	PRIMARY KEY (line_index)
	);	

-- CREATE TABLE performance
if OBJECT_ID('performance','U') IS NOT NULL
	drop table performance;
CREATE TABLE performance (
    action_TEXT NVARCHAR(50),
    query_time FLOAT
);

-- CREATE TABLE PLAY_TEXT and read data from csv file
if OBJECT_ID('PLAY_TEXT','U') IS NOT NULL
	drop table PLAY_TEXT;
CREATE TABLE PLAY_TEXT (line NVARCHAR(MAX))
bulk insert PLAY_TEXT
	from 'F:\data analysis\sequel project\A_Midsummer_Nights_Dream.csv'
	with(ROWTERMINATOR = '.')

-- CREATE TABLE characters and read from csv
if OBJECT_ID('characters','U') IS NOT NULL
	drop table characters;
CREATE TABLE characters (
    char_name NVARCHAR(255));
BULK INSERT characters
	FROM 'F:\data analysis\sequel project\characters.csv'
	WITH ( ROWTERMINATOR = ',');
