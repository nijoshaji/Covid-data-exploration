/*
Covid 19 Data Exploration 
Skills used:  CTE's, Aggregate Functions, Joins, Create Views
*/

-- First, we will analyse covid_deaths data

-- monthly statistics of cases vs deaths for all countries

select country, substr(`date`,1,7) as date_ym , sum(new_cases) as monthly_cases, 
sum(new_deaths) as monthly_deaths, 
round((sum(new_deaths)/sum(new_cases)) *100,2) as percent_deathVcase
from covid_deaths
where country = 'India'
group by country,substr(`date`,1,7)
order by country, substr(`date`,1,7);


-- month wise progression of cases vs deaths for all countries

select country, substr(`date`,1,7) as date_ym , max(total_cases) as Total_cases, 
max(total_deaths) as Total_deaths,
round((max(total_deaths)/max(total_cases)) *100,2) as percent_totaldeathVsTotalcases
from covid_deaths
where country = 'India'
group by country,substr(`date`,1,7)
order by country, substr(`date`,1,7);

-- yearly statistics of cases vs deaths
select country, year(`date`) as date_y , sum(new_cases) as Yearly_cases, 
sum(new_deaths) as Yearly_deaths,
 round((sum(new_deaths)/sum(new_cases)) *100,2) as percent_totaldeathVsTotalcases
from covid_deaths
where country = 'India'
group by country, year(`date`)
order by country, year(`date`);

-- year wise progression of cases vs deaths for all countries

select country, year(`date`) as date_y , max(total_cases) as Total_cases, 
max(total_deaths) as Total_deaths,
round((max(total_deaths)/max(total_cases)) *100,2) as percent_totaldeathVsTotalcases
from covid_deaths
where country = 'India'
group by country, year(`date`) 
order by country, year(`date`) ;

-- Cases vs Population

-- progressive percentage of population infected over months 

select country, substr(`date`,1,7) as date_ym, max(total_cases) as total_cases,
floor(avg(population)) as population_avg,
round((max(total_cases)/avg(population)) * 100, 2) as percent_population_infected
from covid_deaths
where country = 'India'
group by country, substr(`date`,1,7)
order by country, substr(`date`,1,7);

-- Total percent of people infected over population by country from 2020 - 2024

select country, sum(new_cases) as total_cases ,  population,
round((sum(new_cases)/population) *100,2) as percent_infected
from covid_deaths
group by country, population
order by infection_rate desc;


-- Total death count and death percentage for every country from 2020-2024

select country, sum(new_deaths) as total_deaths, population, 
round((sum(new_deaths)/population) *100,2) as percent_death
from covid_deaths
group by country, population
order by total_deaths desc;

-- Global analysis

-- Total cases and deaths worldwide
select sum(new_cases) as world_total_cases, sum(new_deaths) as world_total_deaths,
round((sum(new_deaths)/ sum(new_cases)) *100,4) as percent_deathsVscases
from covid_deaths;

-- global death rate and infection rate from 2020 - 2024
with country_summary as 
(
select country, max(population) as population, sum(new_cases) as total_cases,
sum(new_deaths) as total_deaths
from covid_deaths group by country
)
select 
round((sum(total_cases)/sum(population))*100,2) as global_infection_percent,
round((sum(total_deaths)/sum(population))*100,2) as global_death_percent
from country_summary;

-- -- Vaccination Analysis

-- Population vs Vaccinations. 
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

select d.continent, d.country, d.date, d.population, v.new_vaccinations,
sum(v.new_vaccinations) over(partition by d.country order by d.country, d.date) as rolling_total
from covid_deaths  d join covid_vaccinations v
on d.country = v.country and d.date = v.date
where v.new_vaccinations is not null 
and d.country = 'India'
order by d.country, d.date ;

-- need to put this in a cte to calculate percent vaccinated

with pop_vaccinated as 
(
select d.continent as continent, d.country as country, d.date as `date`,
 d.population as population , v.new_vaccinations as vaccination_per_day,
sum(v.new_vaccinations) over(partition by d.country order by d.country, d.date) as rolling_total
from covid_deaths  d join covid_vaccinations v
on d.country = v.country and d.date = v.date
)
select *, (rolling_total/population) *100 as percent_vaccinated
from pop_vaccinated
where rolling_total >0;


-- create a view to store data for later visualizations

create view vaccination_progress as 
select d.continent, d.country, d.date, d.population, v.new_vaccinations,
sum(v.new_vaccinations) over(partition by d.country order by d.country, d.date) as rolling_total
from covid_deaths  d join covid_vaccinations v
on d.country = v.country and d.date = v.date
order by d.country, d.date ;
