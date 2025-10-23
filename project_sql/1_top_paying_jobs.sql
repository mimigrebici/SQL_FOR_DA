/**Question: What are the top-paying data analyst jobs?**

- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries.
- Why? Aims to highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility. **/


SELECT *
from job_postings_fact pf 
where pf.job_title_short IN ('Data Analyst')
and job_work_from_home = false
and job_location = ''
order BY pf.salary_year_avg DESC
limit 10;