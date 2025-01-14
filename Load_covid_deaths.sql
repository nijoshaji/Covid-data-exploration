-- Load covid deaths data to MySQL
-- create and empty table with correct headers

drop table if exists covid_deaths;
create table covid_deaths
(
`code` text,
continent text,
country text,
`date` date,
population int,
total_cases varchar(255),
new_cases varchar(255),
total_deaths varchar(255),
new_deaths varchar(255)
);

-- check the directory for MySQL and place the file in that directory to overcome errors
SHOW VARIABLES LIKE "secure_file_priv"; 


-- use load data command to import all data (faster method than import wizard)
load data  infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Covid_deaths.csv'
into table covid_deaths
fields terminated by ','
ignore 1 rows; -- ignores the header of csv

-- check the number of rows loaded
select * from covid_deaths;