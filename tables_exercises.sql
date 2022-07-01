SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM employees LIMIT 5;

DESCRIBE employees;

-- Q5: Explore the emplyees table. What different data types are present on this table?
DESCRIBE employees;
-- A5: int, date, varchar, enum

-- Q6: Which table(s) do you think contain a numeric type column?
DESCRIBE departments; DESCRIBE dept_emp; DESCRIBE dept_manager; DESCRIBE salaries; DESCRIBE titles;
-- A6: All of them. I think would have to because they need primary keys. 

-- Q7: Which table(s) do you think contain a string type column?
SELECT * FROM dept_emp LIMIT 5;
-- A7: employees, departments, dept_emp, dept_manager, titles

-- Q8: Which tables(s) do you think contain a date type column?
-- A8: employees, dept_emp, dept_manager, salaries, titles

-- Q9: What is the relationship between the employees and the departments tables?
-- A9: there is no explicit relationship. columns from both tables, emp_no and dept_no, respectively appear in other keys

-- E10: Show the SQL that created the dept_manager table
SHOW CREATE TABLE dept_manager;
