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
-- *returned 1000
SELECT * 
FROM employees
WHERE last_name LIKE 'E%';

-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
DESCRIBE employees;

-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?