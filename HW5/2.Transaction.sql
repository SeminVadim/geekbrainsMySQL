begin;
	SELECT * FROM emploers.employees;
    DELETE FROM emploers.employees WHERE (emp_no = 11000);
    INSERT INTO emploers.employees (emp_no, birth_date, first_name, last_name, gender, hire_date) 
                            VALUES ('11000', '1956-02-17', 'vadim', 'semin', 'm', '2020-11-15');
Commit;