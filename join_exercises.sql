/* Join Example Database */
USE join_example_db;
-- Use the join_example_db. Select all the records from both the users and roles tables.
SELECT *
FROM users;
	-- returned 6 rows, has fields id, name, email, and role_id

SELECT * 
FROM roles;
	-- returned 4 rows, has fiedls id, and name. names (job titles) are admin, author, reviewer, and commenter

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles
ON users.role_id = roles.id;
 -- Guess: 3 rows returned
 -- Actual: 4 rows returned
 
SELECT *
FROM users
LEFT JOIN roles
ON users.role_id = roles.id;
 -- Guess: 3 rows returned
 -- Actual: 6 rows returned
 
SELECT *
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;
 -- Guess: 3 rows returned
 -- Actual: 5 rows returned

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT role.name as title, COUNT(*) as "# in role"
FROM roles AS role
LEFT JOIN users AS user
ON user.role_id = role.id
GROUP BY title
;

/* Employees Database */
-- Use the employees database
USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SHOW TABLES; -- figure out which tables can/should be used
DESCRIBE departments; -- has fields dept_no and dept_name
DESCRIBE dept_manager; -- has fields emp_no, dept_no, from_date, and to_date
DESCRIBE employees; -- will use fields emp_no and first/last.name

SELECT d.dept_name as Department, CONCAT(e.first_name, ' ', e.last_name) as 'Current Manager'
FROM departments d -- aliased 
JOIN dept_manager dm -- aliased
USING(dept_no)
JOIN employees e -- aliased
USING(emp_no)
WHERE to_date = '9999-01-01'
ORDER BY d.dept_name
;

-- Find the name of all departments currently managed by women.
SELECT d.dept_name Department, CONCAT (e.first_name, ' ', e.last_name) 'Current Manager'
FROM departments d 
JOIN dept_manager dm
USING(dept_no)
JOIN employees e
USING(emp_no)
WHERE to_date = '9999-01-01'
	AND e.gender = 'F'
ORDER BY d.dept_name
;

-- Find the current titles of employees currently working in the Customer Service department.
-- 
describe dept_emp;
SELECT * from departments;
SELECT titles.title, COUNT(*)
FROM titles
JOIN employees
USING(emp_no)
JOIN dept_emp
USING(emp_no)
JOIN departments
USING (dept_no)
WHERE departments.dept_no = 'd009'
	AND dept_emp.to_date = '9999-01-01'
    AND titles.to_date = '9999-01-01'
GROUP BY title
;
 
-- Find the current salary of all current managers.
describe salaries;
SELECT d.dept_name as Department, CONCAT(e.first_name, ' ', e.last_name) as Manager, s.salary as Salary
FROM dept_manager dm
JOIN salaries s
USING(emp_no)
JOIN departments d
USING(dept_no)
JOIN employees e 
USING (emp_no)
WHERE dm.to_date = '9999-01-01'
	AND s.to_date = '9999-01-01'
ORDER BY Department;


-- Find the number of current employees in each department.
SELECT dept_no, d.dept_name, COUNT(*)
FROM departments d
JOIN dept_emp de
USING (dept_no)
JOIN employees e
USING (emp_no)
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY dept_no
;

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT dept_no, dept_name, AVG(salary)
FROM departments d
JOIN dept_emp de
USING (dept_no)
JOIN salaries s
USING (emp_no)
WHERE s.to_date = '9999-01-01'
	AND de.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(salary) DESC
LIMIT 1
;

-- Who is the highest paid employee in the Marketing department?
SELECT CONCAT(e.first_name, ' ', e.last_name) as Employee, s.salary
FROM employees e 
JOIN salaries s
USING (emp_no)
JOIN dept_emp de
USING (emp_no)
WHERE de.dept_no = 'd001'
ORDER BY s.salary DESC
LIMIT 1
;
-- Which current department manager has the highest salary?
SELECT CONCAT (e.first_name, ' ', e.last_name) AS manager, s.salary, d.dept_name as department
FROM employees e
JOIN dept_manager dm
USING(emp_no)
JOIN departments d
USING (dept_no)
JOIN salaries s
USING (emp_no)
WHERE dm.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1
;

-- Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name, ROUND(AVG(s.salary)) average_salary
FROM departments d
JOIN dept_emp de
USING(dept_no)
JOIN employees e
USING (emp_no)
JOIN salaries s
USING (emp_no)
GROUP BY d.dept_name
ORDER by average_salary DESC
;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT employees.first_name, employees.last_name, departments.dept_name, managers.first_name
FROM employees
JOIN dept_emp
USING(emp_no)
JOIN departments 
USING(dept_no)
JOIN dept_manager
USING (dept_no)
JOIN employees managers
ON dept_manager.emp_no = managers.emp_no
WHERE dept_emp.to_date = '9999-01-01'
	AND dept_manager.to_date = '9999-01-01'
ORDER BY departments.dept_name
LIMIT 1
;

-- Bonus Who is the highest paid employee within each department.
SELECT d.dept_name, MAX(s.salary) max_salary, e.emp_no
FROM employees e
JOIN dept_emp de
USING(emp_no)
JOIN departments d
USING(dept_no)
JOIN salaries s
USING (emp_no)
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name, e.emp_no
ORDER by max_salary DESC
;


-- SELECT d.dept_name, MAX(s.salary) max_salary
-- FROM departments d
-- JOIN dept_emp de
-- USING(dept_no)
-- JOIN salaries s
-- USING (emp_no)
-- JOIN employees e 
-- ON s.emp_no = e.emp_no
-- WHERE s.to_date = '9999-01-01'
-- GROUP BY d.dept_name
-- ORDER by max_salary DESC
-- ;