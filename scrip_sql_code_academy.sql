CREATE TABLE newark_airport_2016(
	STATION VARCHAR(20),
	NAME	VARCHAR(100),
	DATE	DATE,
	AWND	FLOAT,
	PGTM	FLOAT,
	PRCP	FLOAT,
	SNOW	FLOAT,
	SNWD	FLOAT,
	TAVG	FLOAT,
	TMAX	FLOAT,
	TMIN	FLOAT,
	TSUN	FLOAT,
	WDF2	FLOAT,
	WDF5	FLOAT,
	WSF2	FLOAT,
	WSF5    FLOAT);

CREATE TABLE STATION AS SELECT DISTINCT STATION AS id, NAME FROM newark_airport_2016;

ALTER TABLE STATION 
ADD UNIQUE (id);

ALTER TABLE newark_airport_2016
ADD FOREIGN KEY (STATION)
REFERENCES STATION (id);

ALTER TABLE newark_airport_2016 
DROP COLUMN NAME;


CREATE TABLE  JC (
	trip_duration INT,
	start_time TIMESTAMP,
	stop_time  TIMESTAMP,
	start_station_id INT,
	start_station_name VARCHAR(100),
	start_station_latitude FLOAT,
	start_station_longitude FLOAT,
	end_station_id INT,
	end_station_name VARCHAR(100),
	end_station_latitude FLOAT,
	end_station_longitude FLOAT,
	bike_id INT,
	user_type VARCHAR(15),
	birth_year INT,
	gender INT);
				  
CREATE TABLE START_STATION AS SELECT DISTINCT start_station_id,start_station_name,start_station_latitude,start_station_longitude FROM JC;
CREATE TABLE END_STATION AS SELECT DISTINCT end_station_id,end_station_name,end_station_latitude,end_station_longitude FROM JC;
CREATE TABLE USER_DEF AS SELECT DISTINCT user_type,CASE WHEN user_type = 'Subscriber' THEN 'Annual Member'
WHEN user_type = 'Customer' THEN '24-hour pass or 3-day pass user'
ELSE NULL END AS DEF FROM JC;
CREATE TABLE gender_DEF AS SELECT DISTINCT gender,CASE WHEN gender = 1 THEN 'MALE'
WHEN gender = '2' THEN 'FEMALE'
ELSE 'UNKNOWN' END AS GENDER_DEF FROM JC;

ALTER TABLE START_STATION
ADD UNIQUE (start_station_id);
ALTER TABLE END_STATION
ADD UNIQUE (end_station_id);
ALTER TABLE USER_DEF
ADD UNIQUE (user_type);

ALTER TABLE JC
ADD FOREIGN KEY (start_station_id)
REFERENCES START_STATION (start_station_id);
ALTER TABLE JC
ADD FOREIGN KEY (end_station_id)
REFERENCES END_STATION (end_station_id);
ALTER TABLE JC
ADD FOREIGN KEY (user_type)
REFERENCES USER_DEF (user_type);

ALTER TABLE JC
DROP COLUMN start_station_name;
ALTER TABLE JC
DROP COLUMN start_station_latitude;
ALTER TABLE JC
DROP COLUMN start_station_longitude;
ALTER TABLE JC
DROP COLUMN end_station_name;
ALTER TABLE JC
DROP COLUMN end_station_latitude;
ALTER TABLE JC
DROP COLUMN end_station_longitude;

CREATE VIEW over_all AS
SELECT
    JC.trip_duration,
    JC.start_time,
    JC.stop_time,
    JC.start_station_id,
    START_STATION.start_station_name,
    START_STATION.start_station_latitude,
    START_STATION.start_station_longitude,
    JC.end_station_id,
    END_STATION.end_station_name,
    END_STATION.end_station_latitude,
    END_STATION.end_station_longitude,
    JC.bike_id,
    JC.user_type,
	user_def.def AS user_def,
    JC.birth_year,
    gender_DEF.GENDER_DEF AS gender
FROM JC 
LEFT JOIN START_STATION ON JC.start_station_id = START_STATION.start_station_id
LEFT JOIN END_STATION ON JC.end_station_id = END_STATION.end_station_id
LEFT JOIN user_def ON JC.user_type = user_def.user_type
LEFT JOIN gender_DEF ON JC.gender = gender_DEF.gender;

ALTER VIEW over_all RENAME TO over_all_JC;

CREATE VIEW over_all_NEW AS
SELECT
    newark.STATION ,
	station.name,
	newark.DATE,
	newark.AWND,
	newark.PGTM	,
	newark.PRCP	,
	newark.SNOW	,
	newark.SNWD	,
	newark.TAVG	,
	newark.TMAX	,
	newark.TMIN	,
	newark.TSUN	,
	newark.WDF2	,
	newark.WDF5	,
	newark.WSF2	,
	newark.WSF5 
FROM newark_airport_2016 AS newark
LEFT JOIN station ON newark.STATION = station.id;




CREATE TABLE newark_airport_2016_clean(
	STATION VARCHAR(20),
	NAME	VARCHAR(100),
	DATE	DATE,
	AWND	FLOAT,
	PGTM	FLOAT,
	PRCP	FLOAT,
	SNOW	FLOAT,
	SNWD	FLOAT,
	TAVG	FLOAT,
	TMAX	FLOAT,
	TMIN	FLOAT,
	TSUN	FLOAT,
	WDF2	FLOAT,
	WDF5	FLOAT,
	WSF2	FLOAT,
	WSF5    FLOAT);


CREATE TABLE STATION_clean AS SELECT DISTINCT STATION AS id, NAME FROM newark_airport_2016_clean;

ALTER TABLE STATION_clean 
ADD UNIQUE (id);

ALTER TABLE newark_airport_2016_clean
ADD FOREIGN KEY (STATION)
REFERENCES STATION_clean (id);

ALTER TABLE newark_airport_2016_clean 
DROP COLUMN NAME;


CREATE TABLE  JC_clean (
	trip_duration INT,
	start_time TIMESTAMP,
	stop_time  TIMESTAMP,
	start_station_id INT,
	start_station_name VARCHAR(100),
	start_station_latitude FLOAT,
	start_station_longitude FLOAT,
	end_station_id INT,
	end_station_name VARCHAR(100),
	end_station_latitude FLOAT,
	end_station_longitude FLOAT,
	bike_id INT,
	user_type VARCHAR(15),
	birth_year INT,
	gender INT);


CREATE TABLE START_STATION_clean AS SELECT DISTINCT start_station_id,start_station_name,start_station_latitude,start_station_longitude FROM JC_clean;
CREATE TABLE END_STATION_clean AS SELECT DISTINCT end_station_id,end_station_name,end_station_latitude,end_station_longitude FROM JC_clean;
CREATE TABLE USER_DEF_clean AS SELECT DISTINCT user_type,CASE WHEN user_type = 'Subscriber' THEN 'Annual Member'
WHEN user_type = 'Customer' THEN '24-hour pass or 3-day pass user'
ELSE NULL END AS DEF FROM JC_clean;
CREATE TABLE gender_DEF_clean AS SELECT DISTINCT gender,CASE WHEN gender = 1 THEN 'MALE'
WHEN gender = '2' THEN 'FEMALE'
ELSE 'UNKNOWN' END AS GENDER_DEF FROM JC_clean;

ALTER TABLE START_STATION_clean
ADD UNIQUE (start_station_id);
ALTER TABLE END_STATION_clean
ADD UNIQUE (end_station_id);
ALTER TABLE USER_DEF_clean
ADD UNIQUE (user_type);

ALTER TABLE JC_clean
ADD FOREIGN KEY (start_station_id)
REFERENCES START_STATION_clean (start_station_id);
ALTER TABLE JC_clean
ADD FOREIGN KEY (end_station_id)
REFERENCES END_STATION_clean (end_station_id);
ALTER TABLE JC_clean
ADD FOREIGN KEY (user_type)
REFERENCES USER_DEF_clean (user_type);

ALTER TABLE JC_clean
DROP COLUMN start_station_name;
ALTER TABLE JC_clean
DROP COLUMN start_station_latitude;
ALTER TABLE JC_clean
DROP COLUMN start_station_longitude;
ALTER TABLE JC_clean
DROP COLUMN end_station_name;
ALTER TABLE JC_clean
DROP COLUMN end_station_latitude;
ALTER TABLE JC_clean
DROP COLUMN end_station_longitude;

CREATE VIEW over_all_clean AS
SELECT
    JC_clean.trip_duration,
    JC_clean.start_time,
    JC_clean.stop_time,
    JC_clean.start_station_id,
    START_STATION_clean.start_station_name,
    START_STATION_clean.start_station_latitude,
    START_STATION_clean.start_station_longitude,
    JC_clean.end_station_id,
    END_STATION_clean.end_station_name,
    END_STATION_clean.end_station_latitude,
    END_STATION_clean.end_station_longitude,
    JC_clean.bike_id,
    JC_clean.user_type,
	user_def_clean.def AS user_def,
    JC_clean.birth_year,
    gender_DEF_clean.GENDER_DEF AS gender
FROM JC_clean 
LEFT JOIN START_STATION_clean ON JC_clean.start_station_id = START_STATION_clean.start_station_id
LEFT JOIN END_STATION_clean ON JC_clean.end_station_id = END_STATION_clean.end_station_id
LEFT JOIN user_def_clean ON JC_clean.user_type = user_def_clean.user_type
LEFT JOIN gender_DEF_clean ON JC_clean.gender = gender_DEF_clean.gender;

ALTER VIEW over_all_clean RENAME TO over_all_JC_clean;

CREATE VIEW over_all_NEW_clean AS
SELECT
    newark_clean.STATION ,
	station_clean.name,
	newark_clean.DATE,
	newark_clean.AWND,
	newark_clean.PGTM	,
	newark_clean.PRCP	,
	newark_clean.SNOW	,
	newark_clean.SNWD	,
	newark_clean.TAVG	,
	newark_clean.TMAX	,
	newark_clean.TMIN	,
	newark_clean.TSUN	,
	newark_clean.WDF2	,
	newark_clean.WDF5	,
	newark_clean.WSF2	,
	newark_clean.WSF5 
FROM newark_airport_2016_clean AS newark_clean
LEFT JOIN station_clean ON newark_clean.STATION = station_clean.id;

CREATE VIEW JC_Count_start_station AS
SELECT
    over_all_JC_clean.start_station_id,over_all_JC_clean.start_station_name,over_all_JC_clean.start_station_latitude,over_all_JC_clean.start_station_longitude,
	COUNT(*) AS number
FROM over_all_JC_clean GROUP BY over_all_JC_clean.start_station_id,over_all_JC_clean.start_station_name,over_all_JC_clean.start_station_latitude,over_all_JC_clean.start_station_longitude ORDER BY number DESC;

CREATE VIEW JC_Count_end_station AS
SELECT
    over_all_JC_clean.end_station_id,over_all_JC_clean.end_station_name,over_all_JC_clean.end_station_latitude,over_all_JC_clean.end_station_longitude,
	COUNT(*) AS number
FROM over_all_JC_clean GROUP BY over_all_JC_clean.end_station_id,over_all_JC_clean.end_station_name,over_all_JC_clean.end_station_latitude,over_all_JC_clean.end_station_longitude ORDER BY number DESC;

CREATE VIEW JC_Count_Bike_ID AS
SELECT
    over_all_JC_clean.bike_id,
	COUNT(*) AS number
FROM over_all_JC_clean GROUP BY over_all_JC_clean.bike_id;

CREATE VIEW JC_Count_user_type AS
SELECT
    over_all_JC_clean.user_type,
	COUNT(*) AS number
FROM over_all_JC_clean GROUP BY over_all_JC_clean.user_type;

CREATE VIEW JC_Count_trip_duration AS
SELECT
    MAX(over_all_JC_clean.trip_duration),MIN(over_all_JC_clean.trip_duration),AVG(over_all_JC_clean.trip_duration)
	
FROM over_all_JC_clean; 


CREATE VIEW new_AVG_wdf2_wdf5 AS
SELECT
    AVG(over_all_NEW_clean.WDF2)AS WDF2,AVG(over_all_NEW_clean.WDF5) AS WDF5
	
FROM over_all_NEW_clean; 

CREATE VIEW new_AVG_wsf2_wsf5 AS
SELECT
    AVG(over_all_NEW_clean.WSF2)AS WSF2,AVG(over_all_NEW_clean.WSF5) AS WSF5
	
FROM over_all_NEW_clean; 

CREATE VIEW new_AVG_AWND AS
SELECT
    AVG(over_all_NEW_clean.AWND)AS AWND
	
FROM over_all_NEW_clean; 

SELECT * FROM over_all_JC_clean WHERE trip_duration = 16329808;
