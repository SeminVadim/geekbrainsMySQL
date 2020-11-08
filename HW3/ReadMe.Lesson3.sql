-- База данных «Страны и города мира»:

-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
SELECT 
    *
FROM
    _countries
JOIN _regions ON _regions.country_id = _countries.id
JOIN _cities ON _cities.region_id = _regions.id
WHERE
	_cities.title = 'Москва'


-- 2. Выбрать все города из Московской области.
SELECT 
    _cities.title
FROM
    _cities
JOIN _regions ON _cities.region_id = _regions.id
WHERE
	_regions.title = 'Московская область'
order by _cities.title

 

-- База данных «Сотрудники»:

-- 1. Выбрать среднюю зарплату по отделам.
SELECT dept_emp.dept_no, departments.dept_name, avg(salaries.salary)
FROM salaries 
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
GROUP BY dept_emp.dept_no
ORDER BY  salary DESC

-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT employees.emp_no, employees.first_name, employees.last_name, MAX(salaries.salary) 
FROM emploers.salaries
JOIN employees ON employees.emp_no = salaries.emp_no

-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM emploers.employees 
Where employees.emp_no = (
	SELECT salaries.emp_no FROM emploers.salaries 
	WHERE salary = (SELECT MAX(salary) FROM emploers.salaries)) 


-- 4. Посчитать количество сотрудников во всех отделах.
SELECT dept_emp.dept_no, departments.dept_name, count(employees.emp_no)
FROM employees 
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
GROUP BY dept_emp.dept_no                   
ORDER BY  employees.emp_no 


-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT dept_emp.dept_no, departments.dept_name, count(employees.emp_no), sum(sal.salary)
FROM employees 
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN (
	SELECT emp_no, sum(salary) as salary FROM salaries
    GROUP BY emp_no   
) as sal ON sal.emp_no = dept_emp.emp_no
GROUP BY dept_emp.dept_no
ORDER BY dept_emp.dept_no 







