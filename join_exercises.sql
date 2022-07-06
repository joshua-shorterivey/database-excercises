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
-- Find the number of current employees in each department.
-- Which department has the highest average salary? Hint: Use current not historic information.
-- Who is the highest paid employee in the Marketing department?
-- Which current department manager has the highest salary?
-- Determine the average salary for each department. Use all salary information and round your results.
-- Bonus Find the names of all current employees, their department name, and their current manager's name.
-- Bonus Who is the highest paid employee within each department.
