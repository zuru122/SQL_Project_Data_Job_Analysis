SELECT
    job_title_short,
    job_location,
    salary_year_avg
FROM job_postings_fact
ORDER BY salary_year_avg DESC NULLS LAST
WHERE job_location = 'Anywhere';

-- 

SELECT
    job_title_short,
    job_location
FROM job_postings_fact
WHERE job_location = 'Anywhere';

-- Task
-- Label new column as follows:
-- 'Anywhere' jobs as 'Remote'
-- 'New York, NY' jobs as 'local'
-- Otherwise 'Onsite'

SELECT
    job_title_short,
    job_location,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst';



-- Getting the available job counts due to location

SELECT
    COUNT(job_id) AS number_of_jobs,
  
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;


-- Practice Problem 1
-- I want to categorize the salary from each job postings. To see if it fits in my desired salary range.
-- Put salary into different buckets
-- Define what's high, standard, or low salary with our own conditions
-- Why? it is easy to determine which job postings are worth looking at based on salary. Bucketing is a common practice in data analysis when viewing categories.
-- I only want to look at data analyst roles
-- Order from highest to lowest


SELECT
    job_title_short,
    job_location,
    salary_year_avg,
    CASE 
        WHEN salary_year_avg > 100000 THEN 'High salary'
        WHEN salary_year_avg >= 50000 THEN 'Standard'
        WHEN salary_year_avg < 50000 THEN 'Low Salary'
        ELSE 'undefined'
    END AS salary_range
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC NULLS LAST;



SELECT *
FROM job_postings_fact
WHERE salary_year_avg > 1
LIMIT 10;