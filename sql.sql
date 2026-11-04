USE job_tracker;

show tables;
DESCRIBE applications;


select * from applications;
SELECT COUNT(*) FROM applications;


-- 2. Applications by status
SELECT Status, COUNT(*) AS total
FROM applications
GROUP BY Status
ORDER BY total DESC;


-- 3. Best job source
SELECT
    Job_Source,
    COUNT(*) AS applications,
    SUM(CASE WHEN Status IN
        ('Shortlisted','Interview Scheduled',
         'Interviewed','Offer Received','Rejected')
        THEN 1 ELSE 0 END) AS responses
FROM applications
GROUP BY Job_Source
ORDER BY responses DESC;

-- 4. Top 10 companies
SELECT Company, COUNT(*) AS applications
FROM applications
GROUP BY Company
ORDER BY applications DESC
LIMIT 10;

-- 5. Remote vs Hybrid vs On-site
SELECT Work_Mode, COUNT(*) AS total
FROM applications
GROUP BY Work_Mode;

-- 6. Average salary by job role
SELECT
    Job_Role,
    ROUND(AVG(Expected_Salary_LPA), 2) AS avg_salary
FROM applications
GROUP BY Job_Role
ORDER BY avg_salary DESC;

-- 7. Interview conversion
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN Status IN
    ('Interview Scheduled','Interviewed','Offer Received')
    THEN 1 ELSE 0 END) AS interviews
FROM applications;

-- 8. Offer analysis
SELECT Company, COUNT(*) AS offers
FROM applications
WHERE Status = 'Offer Received'
GROUP BY Company
ORDER BY offers DESC;
