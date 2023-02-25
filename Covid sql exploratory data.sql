--To start our querry
SELECT Location,date, total_cases, new_cases,total_deaths, population
FROM covidDeaths

--Total determine the Total cases vs the Total death

SELECT Location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM covidDeaths
 
 --To check the check for united sates only

 SELECT Location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM covidDeaths
WHERE Location Like '%states%'

---We can do the same for Brazil
 SELECT Location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM covidDeaths
WHERE Location Like '%brazil%'



--total determine the Total cases vs the Population (to show what percentage of population got covid)

SELECT Location,date,population,total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM covidDeaths
WHERE Location Like '%states%'

--To know the country with the highest infection rate compared to the population

SELECT Location,population,MAX(total_cases) AS HighestInfectionCount , MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM covidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

--To show the country with the highest death counte per population
SELECT Location,MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
GROUP BY location
ORDER BY TotalDeathCount DESC

--Showing the continent witht highest death count
 
SELECT continent,MAX (CAST(Total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC



---Now we join our table for further analysis
SELECT*
FROM CovidDeaths
JOIN Covidvaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date= CovidVaccinations.date

--Looking at the Total population vs vaccinations

SELECT CovidDeaths.continent, CovidDeaths.location,CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations
FROM CovidDeaths
JOIN Covidvaccinations
ON CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date= CovidVaccinations.date
WHERE CovidDeaths.continent IS NOT NULL
ORDER BY 1,2,3



--Creating a view
CREATE VIEW PercentagePopulationInfection as
SELECT Location,date,population,total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM covidDeaths
WHERE Location Like '%states%'


CREATE VIEW DeathPercentage AS
SELECT Location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM covidDeaths
WHERE Location Like '%brazil%'
