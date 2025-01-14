Covid Data exploration in MySQL

The dataset has been downloaded from :
https://docs.owid.io/projects/etl/api/covid/#download-data

The raw data set has been processed in excel before loading into MySQL.
The raw data set was divided into 2 csv files by filtering the pertinent data.
The 2 files are - Covid_deaths and Covid_vaccinations.

Excel steps:
1. Removed unwanted columns
2. Removed world, world exclusive China etc and continent data. 
3. Removed all rows where population was blank
4. Changed date from general to date format : yyyy-mm-dd

MySQL steps:
1. Load the files to MySQL
2. Time-series analysis: 
 a. Cases vs Deaths   
 b. total cases vs population
3. Country-wise analysis: 
 a. Infection rate 
 b. Death count
4. Continent analysis:
 a. Death count
5. Global numbers:
 a. Total cases and deaths
6. Vaccination analysis:
 a. Vaccination progress over time
 b. Percent of population vaccinated
