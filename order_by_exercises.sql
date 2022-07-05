-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

USE employees;

-- 2: Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- First Row: Irena Reautenauer
SELECT * 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;

-- Last Person: Vidya Awdeh
SELECT * 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC;

-- 3: Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- First Person: Irean Acton
-- Last Person: Vidya Zeizig
SELECT * 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC ;

-- 4: Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- First Row: Irena Acton
-- Last Person: Maya Zyda --- needed to add DESC to both ORDER BY operations
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;

-- 5: Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
-- returned 899 rows
-- First employee number and name: 100021 Ramzi Erde
-- Last: 499648 Tadahiro Erde -- added DESC
SELECT * 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER by emp_no;

-- 6: Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
-- Returned 899 rows
-- Newest employee: Teiji Eldridge
-- Oldest employee: Sergi Erde
SELECT * 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date ASC;

-- 7: Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
-- Oldest employee hired last: Khun Bernini

SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND DATE_FORMAT(birth_date, '%m%d') = 1225
ORDER BY birth_date, hire_date DESC;

-- Youngest employee hired first: Douadi Pettis
SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND DATE_FORMAT(birth_date, '%m%d') = 1225
ORDER BY birth_date DESC, hire_date ASC;

