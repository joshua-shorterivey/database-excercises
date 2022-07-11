USE leavitt_1865;
SHOW databases;
USE employees;

-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
	CREATE TEMPORARY TABLE leavitt_1865.employees_with_departments AS -- creates create as temp table in personal schema
	SELECT e.first_name, e.last_name, d.dept_name
	FROM employees e
	JOIN dept_emp de
	USING (emp_no)
	JOIN departments d
	USING (dept_no)
	;
    USE leavitt_1865;
	SELECT * -- check to see if rows copied over properly. test = good
	FROM employees_with_departments
	;
    
-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
	ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
	SELECT * -- check to see if rows copied over properly. test = good
	FROM employees_with_departments
	LIMIT 10
	;
	describe employees_with_departments;

-- Update the table so that full name column contains the correct data
	UPDATE employees_with_departments
    SET full_name = 
	CONCAT(employees_with_departments.first_name, ' ', employees_with_departments.last_name)
    ;
-- Remove the first_name and last_name columns from the table.
	ALTER TABLE employees_with_departments 
    DROP COLUMN first_name,
    DROP COLUMN last_name;
    
    select full_name, dept_name
    from employees_with_departments
    limit 10; 
    
    
-- What is another way you could have ended up with this same table?
	USE employees;
    CREATE TEMPORARY TABLE leavitt_1865.temp2 AS
    SELECT CONCAT(e.first_name, ' ', e.last_name) as full_name, d.dept_name
    FROM employees e
    JOIN dept_emp de
    USING (emp_no)
    JOIN departments d
    USING (dept_no)
    ;
    
    USE leavitt_1865;
    SELECT *
    FROM temp2
    LIMIT 10
    ;
    
/* Question 2 */
-- Create a temporary table based on the payment table from the sakila database.
	USE sakila;
    CREATE TEMPORARY TABLE leavitt_1865.temp_payments AS
    SELECT *
    FROM payment
    ;
    USE leavitt_1865;
    
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
	SELECT amount
    FROM temp_payments
    LIMIT 50
    ;

    describe temp_payments;
    ALTER TABLE temp_payments MODIFY amount DECIMAL (7,2);
    UPDATE temp_payments SET amount = amount * 100;
	ALTER TABLE temp_payments MODIFY amount SMALLINT UNSIGNED;

/* Question 3 */

-- Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
		-- Sales is the best department right now, and Human Resources is the worst. 
		-- Hint Consider that the following code will produce the z score for current salaries.
		-- Returns the historic z-scores for each salary
		-- Notice that there are 2 separate scalar subqueries involved
		-- SELECT salary,
		--     (salary - (SELECT AVG(salary) FROM salaries))
		--     /
		--     (SELECT stddev(salary) FROM salaries) AS zscore
		-- FROM salaries;

	USE employees;
	CREATE TEMPORARY TABLE leavitt_1865.current_salaries AS
    SELECT dept_no, emp_no, salary, dept_name, 
		(salary - (SELECT AVG(salary) FROM salaries))
		/
		(SELECT stddev(salary) FROM salaries
		) AS zscore
    FROM salaries s
    JOIN dept_emp de
    USING (emp_no)
    JOIN departments
    USING (dept_no)
    WHERE s.to_date > NOW() 
		AND de.to_date > NOW()
	;
    
    USE leavitt_1865;

	SELECT dept_name, AVG(salary) as dept_average, AVG(zscore)
    FROM current_salaries
    GROUP BY dept_name
    ORDER BY AVG(zscore) DESC
	;

    
