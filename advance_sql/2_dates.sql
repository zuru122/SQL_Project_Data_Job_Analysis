SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT (YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
LIMIT 5;



SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month 
ORDER BY
    job_posted_count DESC;


-- Practice
-- write a query to find the average salary both yearly [salary_year_avg] and hourly [salary_hour_avg] for job postings that were posted after June 1, 2023. Group the results by job schedule type.



SELECT
    job_schedule_type AS schedule_type,
    AVG(salary_year_avg) AS yearly_avg,
    AVG(salary_hour_avg) AS hourly_avg
   

FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'

GROUP BY schedule_type;


-- Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in 'America, New_york' time zone before extracting (hint) the month. Assume the job_posted_date is stored in UTC. Group by and order by the month

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'AMERICA/NEW_YORK') AS month
   

FROM job_postings_fact
WHERE job_posted_date >= '2023-01-01' AND job_posted_date < '2024-01-01'
GROUP BY month 
ORDER BY month


-- Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.

SELECT
    companies.name AS company_name,
    job_postings.job_health_insurance AS health_insurance  
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
ON job_postings.company_id = companies.company_id

WHERE job_postings.job_health_insurance = TRUE AND EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2


-- /////

SELECT DISTINCT
    companies.name AS company_name,
    job_postings.job_health_insurance AS health_insurance
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id
WHERE job_postings.job_health_insurance = true
    AND EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2;



-- Advance problem
-- Create Tables from other Tables
-- Create three (3) tables: Jan 2023 jobs, Feb 2023 jobs, Mar 2023 jobs
-- Foreshadowing: This will be used in another practice problem below.
-- Hints: Use CREATE TABLE table_name AS syntax to create your table
-- Look at a way to filter out specific months (EXTRACT)


-- January 
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


-- February
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;



-- VIEW THE TABLE CREATED
SELECT job_posted_date
FROM  march_jobs
-- I used order by just to filter it orderly
ORDER BY job_posted_date