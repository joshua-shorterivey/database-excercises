USE employees;

-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
	select concat(e.first_name, ' ', e.last_name) as employee, e.hire_date as start_date,
		CASE 
			WHEN de.to_date > now() THEN 1
			ELSE de.to_date 
		END AS is_current_employee
	from employees e -- select employees, 
	join dept_emp de using (emp_no)
	limit 10
;

-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
	SELECT e.last_name, 
		CASE 
			WHEN SUBSTR(e.last_name, 1,1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H' -- ('abcdefg') does not check each letter
			WHEN SUBSTR(e.last_name, 1,1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
			ELSE 'R-Z'
		END AS alpha_group
	FROM employees e
	;

-- How many employees (current or previous) were born in each decade?
	-- 60s: 206012
    -- 50s: 94012
    
	SELECT COUNT(*),
		CASE 
			WHEN DATE_FORMAT(birth_date, '%y') > 60 THEN '50s'
			ELSE '60s'
		END AS decade
	FROM employees
	GROUP BY decade
	;

-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT 
	CASE
		WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE d.dept_name -- to help catch stragglers
	END AS department_group,
	AVG(s.salary)
FROM departments d
JOIN dept_emp de USING(dept_no)
JOIN employees e ON de.emp_no = e.emp_no AND de.to_date > NOW()
JOIN salaries s ON s.emp_no = e.emp_no AND s.to_date > NOW()
GROUP BY department_group
;