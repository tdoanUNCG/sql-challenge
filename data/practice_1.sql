CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	gender VARCHAR(1),
	hire_date DATE
);

SELECT * FROM employees;

CREATE TABLE departments(
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR
);

SELECT * FROM departments;

CREATE TABLE dept_manager(
	dept_no VARCHAR,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date DATE,
	to_date DATE
);

SELECT * FROM dept_manager;

CREATE TABLE salaries(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT,
	from_date DATE,
	to_date DATE
);

SELECT * FROM salaries;

CREATE TABLE titles(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(255),
	from_date DATE,
	to_date DATE
);

SELECT * FROM titles;

CREATE TABLE dept_emp(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date DATE,
	to_date DATE
);

SELECT * FROM dept_emp;

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



SELECT * FROM departments;