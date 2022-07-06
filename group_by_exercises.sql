USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles;
	-- returns 7 rows

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees 
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%'
GROUP BY first_name, last_name
ORDER BY first_name, last_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name NOT LIKE '%qu%' AND last_name LIKE '%q%'
GROUP BY last_name;
	-- return Chleq, Lindqvist, and Qiwen

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(last_name) as '# of employees' 
FROM employees
WHERE last_name NOT LIKE '%qu%' AND last_name LIKE '%q%'
GROUP BY last_name;
	-- returned Chleq - 189, Lindqvist - 190, Qiwen - 168

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender, COUNT(*) as '# of employees'
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name
;

-- Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),SUBSTR(last_name, 1, 4), '_', DATE_FORMAT(birth_date, '%m%y'))) as username,
	COUNT(*) as occurrences
FROM employees
GROUP BY username
ORDER BY occurrences DESC;
	-- Yes there are duplicate usernames
    
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),SUBSTR(last_name, 1, 4), '_', DATE_FORMAT(birth_date, '%m%y'))) as username,
	COUNT(*) as duplicates
FROM employees
GROUP BY username
HAVING duplicates > 1
ORDER BY COUNT(*) DESC;
    -- Bonus: 13251 duplicates

-- Bonus: More practice with aggregate functions:

-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SELECT employees.first_name, AVG(salary) as 'average salary'
FROM salaries, employees
WHERE salaries.emp_no = employees.emp_no
GROUP BY salaries.emp_no
LIMIT 1000;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
describe dept_emp;
	-- dept_emp has columns emp_no (int), dept_no (char), from_date (date), to_date
SELECT departments.dept_name as Department, COUNT(*) as 'Head Count'
FROM dept_emp
LEFT OUTER JOIN departments
ON departments.dept_no = dept_emp.dept_no
GROUP BY dept_emp.dept_no
; 

-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) as Employee, COUNT(*) as 'Different Salaries'
FROM salaries
LEFT OUTER JOIN employees
ON salaries.emp_no = employees.emp_no
GROUP BY Employee
ORDER BY COUNT(*) DESC
LIMIT 1000; 

-- Find the maximum salary for each employee.


-- Find the minimum salary for each employee.
-- Find the standard deviation of salaries for each employee.
-- Now find the max salary for each employee where that max salary is greater than $150,000.
-- Find the average salary for each employee where that average salary is between $80k and $90k.