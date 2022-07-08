USE employees;

-- Find all the current employees with the same hire date as employee 101010 using a sub-query.
	-- First write subquery that SELECTs (returns) the hire date in order to find others that match it
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
	;
	-- Second: write query that will use previous. Test hard coded value, and then replace if expected behaviour.
    SELECT *
    FROM employees e
    JOIN salaries s -- currently employed if currently drawing salary
    USING (emp_no)
    WHERE s.to_date > NOW()
    AND e.hire_date = 
		(SELECT hire_date
		FROM employees
		WHERE emp_no = 101010)
    ;
    
    
-- Find all the titles ever held by all current employees with the first name Aamod.
SELECT s.emp_no
FROM salaries s
WHERE s.to_date > NOW()
;

SELECT t.title
FROM employees e
JOIN titles t
USING (emp_no)
WHERE e.first_name = 'Aamod'
AND emp_no IN (
	SELECT s.emp_no
	FROM salaries s
	WHERE s.to_date > NOW()
	)
GROUP BY title
;


-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
	-- 59900 people are still in the table that no longer work for the company.
	SELECT s.emp_no -- select employee numbers still getting paid
    FROM salaries s
    WHERE s.to_date > NOW()
    ;
    
	SELECT COUNT(e.emp_no)
    FROM employees e
	WHERE e.emp_no NOT IN -- look for emp_no numbers not in the still getting paid bucket
		(SELECT s.emp_no -- select employees numbers still getting paid
		FROM salaries s
		WHERE s.to_date > NOW())
	;
-- Find all the current department managers that are female. List their names in a comment in your code.
	-- Isamu Legleitner
	-- Karsten Sigstam
	-- Leon DasSarma
	-- Hilary Kambil

    SELECT dm.emp_no
	FROM dept_manager dm
    WHERE dm.to_date > NOW()
    ;
    
    SELECT e.first_name, e.last_name
    FROM employees e
    WHERE e.gender = 'F'
    AND e.emp_no IN (
		SELECT dm.emp_no
		FROM dept_manager dm
		WHERE dm.to_date > NOW()
		);
        
    
-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
	-- returned 
    SELECT AVG(salary)
	FROM salaries 
	;
    
    SELECT e.first_name, e.last_name, s.salary
    FROM employees e
    JOIN salaries s
    USING (emp_no)
    WHERE s.salary > (
		SELECT AVG(salary)
		FROM salaries 
        )
	AND s.to_date > NOW()
    ;
    

-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
 -- 78 lie within 1 standard deviation of the highest salary
 -- .0029%
SELECT MAX(salary), STD(salary), MAX(salary) - STD(salary)
FROM salaries s
;

SELECT 100 * ( COUNT(*) / (SELECT COUNT(*) FROM salaries s))
FROM salaries s 
WHERE s.salary BETWEEN (
	SELECT MAX(salary) - STD(s.salary)
	FROM salaries s
    WHERE s.to_date > NOW()
	)  AND (
	SELECT MAX(s.salary) 
    FROM salaries s
    WHERE s.to_date > NOW()
    ) AND s.to_date > NOW()
;

/* Bonus */
-- Find all the department names that currently have female managers
SELECT e.emp_no
FROM employees e
WHERE e.gender = 'F'
;

SELECT dept_name
FROM dept_manager dm
JOIN departments d
USING (dept_no)
WHERE dm.to_date > NOW()
AND emp_no IN (
	SELECT e.emp_no
	FROM employees e
	WHERE e.gender = 'F'
	)
; 

-- Find the first and last name of the employee with the highest salary
SELECT MAX(salary)
FROM salaries s
;

SELECT e.first_name, e.last_name
FROM employees e
JOIN salaries s
USING (emp_no)
WHERE s.salary = (
	SELECT MAX(s.salary)
    FROM salaries s
    )
;

-- Find the department name that the employee with the highest salar works in 
SELECT MAX(salary)
FROM salaries s
;

SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN salaries s
USING (emp_no)
JOIN dept_emp de
USING (emp_no)
JOIN departments d
USING (dept_no)
WHERE s.salary = (
	SELECT MAX(s.salary)
    FROM salaries s
    )
;
