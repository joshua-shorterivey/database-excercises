-- 1: Create a new SQL script named limit_exercises.sql.
-- accomplished 
USE employees;

-- 2: List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- 3: Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
-- First Five: Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup
SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND DATE_FORMAT(birth_date, '%m%d') = 1225
ORDER BY hire_date
LIMIT 5;

-- 4: Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-- Relationship: (OFFEST / LIMIT) + 1 ~ not really sure how to answer this one, as the metaphor is pretty tough for me to wrap my head aroud.

SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND DATE_FORMAT(birth_date, '%m%d') = 1225
ORDER BY hire_date
LIMIT 45, 5;
 


