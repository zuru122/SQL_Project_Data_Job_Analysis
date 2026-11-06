/* 
Query 2
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? it provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        job_title_short,
        salary_year_avg,
        company_dim.name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC 
    LIMIT 10
   
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC


-- Getting insight with AI
/*
- This are the top 10 data analyst roles I found in job postings in 2023, can you analyze the skill column and display insights?
*/

/*
Key findings:
- SQL is the most consistently requested skill, appearing in all 8 postings (100%).
- Python comes second, appearing in 7 postings (87.5%).
- Tableau ranks third, appearing in 6 postings (75%).
- R appears in 4 postings (50%).
- Excel, Pandas and Snowflake each appear in 3 postings (37.5%).
Insight: SQL and Python are the strongest foundational technical skills in this dataset. Tableau is also particularly important, highlighting the value of data visualization alongside data manipulation.



Key takeaways and recommendations
Based on the analysis, here are the most important conclusions:
1. SQL is essential: Every job posting requires SQL. It should be a priority for anyone pursuing a Data Analyst career.
2. Python is highly valuable: Its presence in almost 9 out of 10 postings shows the importance of programming and automation.
3. Visualization matters: Tableau and Power BI demonstrate that employers want analysts who can communicate insights, not just process data.
4. Cloud skills are emerging requirements: AWS, Azure, Snowflake and Databricks suggest that familiarity with cloud-based data environments is beneficial.
5. Advanced analytical roles require broader skills: PySpark, Hadoop, Pandas and NumPy point towards the growing overlap between data analysis and data engineering.
 */