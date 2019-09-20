USE soft_uni;
/*1*/
SELECT * FROM departments ORDER BY department_id;

/*2*/
SELECT name FROM departments ORDER BY department_id;
/*3*/
SELECT first_name,last_name,salary
FROM employees
ORDER BY employee_id;
/*4*/
SELECT first_name,middle_name,last_name
FROM employees
ORDER BY employee_id;
/*5*/
SELECT concat_ws('@',concat_ws('.',first_name,last_name),'softuni.bg')
AS full_email_address
from employees;

/*6*/
SELECT DISTINCT salary FROM employees ORDER BY employee_id;

/*7*/
SELECT * FROM employees
WHERE job_title='Sales Representative'
ORDER BY employee_id;

/*8*/
SELECT first_name,last_name,job_title
FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id;

/*9*/
SELECT concat_ws(' ',concat_ws(' ',first_name,middle_name),last_name) AS 'Full Name'
FROM employees
WHERE salary IN (25000,14000,12500,23600);

/*10*/
SELECT first_name,last_name
FROM employees
WHERE manager_id IS NULL ;

/*11*/
SELECT first_name,last_name,salary
FROM employees
WHERE salary>50000
ORDER BY salary DESC;

/*12*/
SELECT first_name,last_name
FROM employees
ORDER BY salary desc
LIMIT 5;

/*13*/
SELECT first_name,last_name
FROM employees
WHERE NOT department_id = 4;

/*14*/
SELECT *
FROM employees
ORDER BY salary DESC ,first_name,last_name DESC ,middle_name;

/*15*/
CREATE VIEW v_employees_salaries
AS SELECT first_name,last_name,salary
FROM employees;

SELECT * from v_employees_salaries;

/*16*/

/*
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN "The quantity is greater than 30"
    WHEN Quantity = 30 THEN "The quantity is 30"
    ELSE "The quantity is something else"
END
FROM OrderDetails; */

CREATE VIEW v_employees_job_titles
AS SELECT CONCAT(e.first_name,' ',
                 (CASE
    WHEN e.middle_name IS NULL THEN ''
    ELSE e.middle_name
    END),' ',
    e.last_name) As `full_name`,e.job_title

  FROM employees AS e ;

SELECT * from v_employees_job_titles;

DROP VIEW v_employees_job_titles;

/*17*/
SELECT DISTINCT job_title FROM employees ORDER BY job_title;

/*18*/
SELECT * FROM projects
ORDER BY start_date,name
LIMIT 10;

/*19*/
SELECT first_name,last_name,hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 7;

/*20*/
USE soft_uni;

/*first variant*/
UPDATE employees
SET salary=salary*1.12
WHERE department_id  IN (1,2,4,11);

SELECT salary from employees;

/*second variant*/
UPDATE employees
SET salary=salary*1.12
WHERE department_id  IN (SELECT department_id from departments WHERE name IN ('Engineering','Tool Design','Marketing','Information Services'));

SELECT salary from employees;

/*21*/
USE geography;
SELECT peak_name from peaks ORDER BY peak_name;

/*22*/
SELECT c.country_name,
       c.population
FROM countries c
WHERE c.continent_code ='EU'
ORDER BY c.population DESC,c.country_name
LIMIT 30;

/*23*/
SELECT country_name,country_code,
   (CASE
       WHEN currency_code ='EUR' THEN 'Euro'
       ELSE 'Not Euro'
    END)AS currency
FROM countries
ORDER BY country_name;

/*24*/
USE diablo;
SELECT  name FROM characters ORDER BY name;

