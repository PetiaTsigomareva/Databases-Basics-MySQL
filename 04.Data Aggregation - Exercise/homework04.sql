/*1*/
USE gringotts;
SELECT COUNT(*) AS 'count'
FROM wizzard_deposits;

/*2*/
SELECT MAX(magic_wand_size)AS longest_magic_wand
FROM wizzard_deposits;

/*3*/
SELECT deposit_group,MAX(magic_wand_size)AS `longest_magic_wand`
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand,deposit_group;

/*4*/
SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

/*5*/
SELECT deposit_group,SUM(deposit_amount)AS `total_sum`
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `total_sum`;

/*6*/
SELECT w.deposit_group,SUM(w.deposit_amount)AS `total_sum`
FROM wizzard_deposits AS w
WHERE w.magic_wand_creator ='Ollivander family'
GROUP BY w.deposit_group;

/*7*/
SELECT w.deposit_group,SUM(w.deposit_amount)AS `total_sum`
FROM wizzard_deposits AS w
WHERE w.magic_wand_creator ='Ollivander family'
GROUP BY w.deposit_group
HAVING `total_sum`<150000
ORDER BY `total_sum`DESC ;

/*8*/
SELECT deposit_group,magic_wand_creator,MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group,magic_wand_creator
ORDER BY magic_wand_creator,deposit_group;

/*9*/
SELECT (CASE
         WHEN age >=0 AND age<=10 THEN '[0-10]'
         WHEN age >=11 AND age<=20 THEN '[11-20]'
         WHEN age >=21 AND age<=30 THEN '[21-30]'
         WHEN age >=31 AND age<=40 THEN '[31-40]'
         WHEN age >=41 AND age<=50 THEN '[41-50]'
         WHEN age >=51 AND age<=60 THEN '[51-60]'
         ELSE '[61+]'
        END)AS age_group,COUNT(age) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group;

/*10*/
SELECT SUBSTR(first_name,1,1)AS first_letter
FROM wizzard_deposits
WHERE deposit_group ='Troll Chest'
GROUP BY first_letter;

/*11*/
SELECT w.deposit_group,w.is_deposit_expired,AVG(w.deposit_interest) AS `average_interest`
FROM wizzard_deposits AS w
WHERE w.deposit_start_date > '1985-01-01'
GROUP BY w.deposit_group,w.is_deposit_expired
ORDER BY w.deposit_group DESC ,w.is_deposit_expired;

/*12*/
SELECT SUM(`difference`)AS `sum_difference`
FROM (SELECT (wd1.deposit_amount - (SELECT wd2.deposit_amount
                                    FROM wizzard_deposits wd2
                                    WHERE wd2.id=wd1.id+1)
             )AS `difference`
FROM wizzard_deposits wd1) d;

/*13*/
USE soft_uni;
SELECT department_id,MIN(salary)AS `minimum_salary`
FROM employees
WHERE DATE(hire_date) >'2000-01-01'
GROUP BY department_id
HAVING department_id IN (2,5,7);

/*14*/
CREATE TABLE highest_paid_employees AS
SELECT *
FROM employees e
WHERE e.salary>30000;

DELETE FROM highest_paid_employees
WHERE manager_id=42;

UPDATE  highest_paid_employees
SET salary=salary+5000
WHERE department_id=1;

SELECT department_id, avg(salary)AS avg_salary
FROM highest_paid_employees
GROUP BY department_id
ORDER BY department_id;

/*15*/
SELECT department_id, MAX(salary) AS `max_salary`
FROM employees
GROUP BY department_id
HAVING `max_salary` < 30000 OR `max_salary`>70000
ORDER BY department_id;

/*16*/
SELECT COUNT(salary)
FROM employees
WHERE manager_id IS NULL ;

/*17 TODO*/
SELECT e1.department_id,e1.salary
from employees e1
GROUP BY e1.department_id,e1.employee_id
ORDER BY e1.department_id,e1.salary DESC;

/*18*/
SELECT e.first_name,e.last_name,e.department_id
FROM (SELECT e1.department_id, AVG(e1.salary) AS average_salary
      FROM employees AS e1
      GROUP BY e1.department_id)AS departments_avg_salaries,employees AS e
WHERE e.department_id= departments_avg_salaries.department_id
  AND e.salary > departments_avg_salaries.`average_salary`

ORDER BY e.department_id
LIMIT 10;

SELECT e.first_name, e.last_name, e.department_id
FROM
	(SELECT e.department_id, AVG(e.salary) AS avg_salary
	FROM `employees` AS e
	GROUP BY e.department_id) AS `department_salary`, `employees` AS e
WHERE e.department_id = department_salary.department_id
	AND e.salary > department_salary.avg_salary
ORDER BY e.department_id ASC
LIMIT 10;

SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

/*19*/
SELECT department_id,SUM(salary)AS total_salary
from employees
GROUP BY department_id;





