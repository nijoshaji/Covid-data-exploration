-- Upload covid_vaccinations csv file to MySQL
-- Create an empty table with correct headers

drop table if exists covid_vaccinations;
create table covid_vaccinations
(
`code` text,
continent text,
country text,
`date` date,
new_vaccinations varchar(255)
);

-- check the directory for MySQL and place the file in that directory to overcome errors
SHOW VARIABLES LIKE "secure_file_priv"; 

-- use load data command to import all data (faster method than import wizard)
load data  infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Covid_vaccinations.csv'
into table covid_vaccinations
fields terminated by ','
ignore 1 rows; -- ignores the header of csv


-- select count(*) from covid_vaccinations; -- check number of rows imported



