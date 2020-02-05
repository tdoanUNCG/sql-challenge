--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.
--Using . (dot) notation.
SELECT employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees, salaries
WHERE employees.emp_no = salaries.emp_no;

--List employees who were hired in 1986.
SELECT employees.last_name, employees.first_name, employees.hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--List the manager of each department with the following 
--information: department number, department name, the manager's 
--employee number, last name, first name, and start and end 
--employment dates.

SELECT dept_manager.dept_no,
(
	SELECT departments.dept_name 
 	FROM departments 
 	WHERE departments.dept_no = dept_manager.dept_no
),
dept_manager.emp_no,
(
	SELECT employees.last_name 
 	FROM employees 
 	WHERE employees.emp_no = dept_manager.emp_no
),
(
	SELECT employees.first_name 
 	FROM employees 
 	WHERE employees.emp_no = dept_manager.emp_no
),
(
	SELECT dept_emp.from_date 
 	FROM dept_emp 
 	WHERE dept_emp.emp_no = dept_manager.emp_no
),
(
	SELECT dept_emp.to_date 
 	FROM dept_emp 
 	WHERE dept_emp.emp_no = dept_manager.emp_no
)

FROM dept_manager;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT employees.emp_no,
	employees.last_name, 
	employees.first_name, 
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "last_name count"
FROM employees
GROUP BY last_name
ORDER BY "last_name count" DESC;