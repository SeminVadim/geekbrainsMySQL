#1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.
-- 2. Выбрать максимальную зарплату у сотрудника.
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `new_view` AS
    SELECT 
        `employees`.`emp_no` AS `emp_no`,
        `employees`.`first_name` AS `first_name`,
        `employees`.`last_name` AS `last_name`,
        MAX(`salaries`.`salary`) AS `MAX(salaries.salary)`
    FROM
        (`salaries`
        JOIN `employees` ON ((`employees`.`emp_no` = `salaries`.`emp_no`)))


#2. Создать функцию, которая найдет менеджера по имени и фамилии.
USE `emploers`;
DROP function IF EXISTS `find_emp`;

DELIMITER $$
USE `emploers`$$
CREATE FUNCTION `find_emp` (find_f_n varchar(14), find_l_n varchar(16))
RETURNS varchar(50) deterministic
BEGIN
	DECLARE query_emp varchar(50);
    SELECT 
		CONCAT(emp_no,' ',
			birth_date,' ',
			first_name,' ',
			last_name,' ',
			gender, ' ',
			hire_date) AS find_emp
	INTO query_emp
    FROM
		emploers.employees
	WHERE
		fist_name = find_f_n and 
		last_name = find_l_n;
	
RETURN  query_emp;
END$$

DELIMITER ;



#3. Создать триггер, который при добавлении нового сотрудника будет 
#выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.

CREATE DEFINER=`root`@`localhost` TRIGGER `employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW BEGIN
	Insert into salaries (emp_no, salary, from_date, to_date ) values 
    (NEW.emp_no, 100, current_date(), current_date());
END