-- subqueries & CTEs

--subquery
SELECT *
    FROM(-- SubQuery starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT (MONTH FROM job_posted_date) = 1
    ) AS january_jobs
    -- SubQuery ends here
ORDER BY job_posted_date



-- CTE
WITH january_jobs AS ( -- CTE definition
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here


SELECT *
FROM january_jobs;



-- subqueries
SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT
            company_id     
    FROM
            job_postings_fact
    WHERE
            job_no_degree_mention = true
    ORDER BY company_id
)

-- 


-- Problem
-- Find the companies that have the most job openings.
-- Get the total number of job postings per company id
-- Return the total number of jobs with the company name.

SELECT
    company_id
FROM job_postings_fact

-- solution

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY company_id
)
SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count
ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC


-- *** ADVANCE***
/* Find the count of the number of remote job postings per skill
    -- Display the top 5 skills by their demand in remote jobs
    -- Include skill ID, name, and count of postings requiring the skill

    extra: search for just data analyst job
*/

-- 

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact AS job_postings 
        ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = True  AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY 
        skill_id
)

SELECT
    skills.skill_id,
    skills.skills AS skill_name,
    remote_job_skills.skill_count

FROM remote_job_skills
INNER JOIN 
    skills_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 7

-- 




-- Practice problem 1
-- Question:
-- Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.


-- Solution
WITH top_skill AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    GROUP BY skill_id
)

SELECT
    top_skill.skill_id,
    skills.skills,
    top_skill.skill_count
FROM top_skill
LEFT JOIN skills_dim AS skills
ON skills.skill_id = top_skill.skill_id
ORDER BY skill_count DESC

-- 


-- Practice Problem 2
-- Question:
-- Determine the size category ("Small; Medium; or Large") for each company by first identifying the number of job postings they have. Use a sbquery to calculate the total job postings per company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of postings is between 10 and 50, and 'Large' if it has 50 job postings.
-- Implement a subquery to aggregate job counts per company before classifying them based on size


WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY company_id
)
SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs,
    CASE
        WHEN total_jobs > 50 THEN 'Large Company'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium Company'
        WHEN total_jobs < 10 THEN 'small Company'
        ELSE 'undefined'
     END AS company_size
FROM company_dim
LEFT JOIN company_job_count
ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC












-- /////////////////////////////////


-- check to verify if a set if duplicate

--out of topic scope.
SELECT 
    job_postings.company_id AS id,
    company.name AS company_name,
    job_postings.job_title_short AS job_title,
    job_postings.job_posted_date AS job_date
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS company
ON job_postings.company_id = company.company_id
WHERE company.name = 'Edraak'



-- 

SELECT
    COUNT(jpf.company_id) AS job_count,
    cd.name AS company_name
FROM company_dim AS cd
JOIN job_postings_fact AS jpf
    ON cd.company_id = jpf.company_id
WHERE jpf.job_no_degree_mention = TRUE AND cd.name = 'Edraak' --count the number of posting for this job with no degree as true
GROUP BY cd.company_id, cd.name
ORDER BY job_count ASC;




SELECT *
FROM  job_postings_fact
LIMIT 10;