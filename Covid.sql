/*
Covid 19 Data Exploration 
*/

select *
FROM dbo.covid
order by  2,3

select *
FROM dbo.overview_covid
order by  4,5


-- GLOBAL NUMBERS
select location,date,total_cases,new_cases,total_deaths,population
FROM dbo.covid
order by  1,2


--countries with highest total cases
select location,Max(cast(total_cases as int)) as total_cases_count
FROM dbo.covid
where location =  'Egypt'  and continent is not null
group by location
order by  total_cases_count desc

--countries with highest total cases
select location,Max(cast(total_cases as int)) as total_cases_count
FROM dbo.covid
where continent is not null
group by location
order by  total_cases_count desc




--countries with highest deaths 
select location,Max(cast(total_deaths as int)) as total_deaths_count
FROM dbo.covid
where location =  'Egypt'
group by location
order by  total_deaths_count desc

-- total cases vs total deths in Egypt
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as deth_perc
FROM dbo.covid
where location =  'Egypt'
order by  1,2


-- perentage of population got infected by covid s in Egypt
select location,date,population,total_cases,(total_cases/population)*100 as infection_per
FROM dbo.covid
where location =  'Egypt'
order by  1,2


--continents with highest cases
select continent,Max(cast(total_cases as int)) as total_cases_count
FROM dbo.covid
where continent is not null
group by continent
order by  total_cases_count desc



--continents with highest death cases
select continent,Max(cast(total_deaths as int)) as total_deaths_count_by_continent
FROM dbo.covid
where continent is not null
group by continent
order by  total_deaths_count_by_continent desc



--joining Vaccination and deth tables

SELECT c.continent, c.location,c.date,c.population,o.new_vaccinations
from dbo.covid c join dbo.overview_covid o
on c.location = o.location
and c.date = o.date
where c.continent is not null 
order by 2,3   



-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From dbo.covid
where continent is not null 
order by 1,2


-- GLOBAL NUMBERS

Select c.continent, c.location, c.date, c.population, ov.new_vaccinations
, SUM(CONVERT(int,ov.new_vaccinations)) OVER (Partition by c.Location Order by c.location, c.Date) as RollingPeopleVaccinated
From dbo.covid c join dbo.overview_covid ov
	On c.location = ov.location
	and c.date = ov.date
	where c.continent is not null 

