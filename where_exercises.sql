-- Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
-- *returned 709
SELECT * 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
-- *returned 709. This does match Q2
SELECT *
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
    OR first_name = 'Maya';

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
-- *returned 441 
SELECT * 
FROM employees
WHERE gender = 'M'
	AND (first_name = 'Irena'
		OR first_name = 'Vidya'
        OR first_name = 'Maya');

-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
-- *returned 1000 (limit)
SELECT * 
FROM employees
WHERE last_name LIKE 'E%';

-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
-- 30723 start or end with E.
SELECT *
FROM employees
WHERE last_name LIKE '%e'
	OR last_name LIKE 'E%';
-- 23393 end with an E but do not begin with one.
SELECT *
FROM employees
WHERE last_name LIKE '%e'
	AND last_name NOT LIKE 'E%';

-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
-- 899 employee last names start and end with E
SELECT * 
FROM employees
WHERE last_name LIKE 'e%e';

-- 24292 employee last names end with E
SELECT * 
FROM employees
WHERE last_name LIKE '%e';


-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
-- 135214 employees were hired in the 90s. 
SELECT *
FROM employees 
WHERE hire_date BETWEEN 19900101 AND 19991231;

-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
-- 842 employees were born on Christmas.
SELECT *
FROM employees 
WHERE DATE_FORMAT(birth_date, '%m%d') = 1225;

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
-- 362 employees were hired in the 90s and born on Christmas.
SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND DATE_FORMAT(birth_date, '%m%d') = 1225;

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
-- 1873 employees have a 'q' in their last name. 
SELECT *
FROM employees
WHERE last_name LIKE '%q%';


-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
-- 547 employees meet the criteria
SELECT * 
FROM employees 
WHERE last_name NOT LIKE '%qu%'
	AND last_name LIKE '%q%';
    