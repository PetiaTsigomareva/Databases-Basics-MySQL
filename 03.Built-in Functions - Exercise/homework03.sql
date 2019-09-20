/*1*/
USE soft_uni;
SELECT first_name,last_name
FRom employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;

/*2*/
SELECT first_name,last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

/*3*/
SELECT first_name
FROM employees
WHERE (department_id IN (3,10))
  AND
      (year(hire_date)between '1995'AND '2005')
ORDER BY employee_id;

/*4*/
SELECT first_name,last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

/*5*/
SELECT name
FROM towns
WHERE char_length(name) IN (5,6)
ORDER BY name;

/*6*/
SELECT *
FROM towns
WHERE SUBSTR(name,1,1) IN ('M','K','B','E')
ORDER BY name;

/*7*/
SELECT *
FROM towns
WHERE SUBSTR(name,1,1) NOT IN ('R','B','D')
ORDER BY name;

/*8*/
CREATE view v_employees_hired_after_2000 AS
SELECT first_name,last_name
  FROM employees
  WHERE year(hire_date)>2000;

SELECT *from v_employees_hired_after_2000;

/*9*/
SELECT first_name,last_name
FROM employees
WHERE CHAR_LENGTH(last_name)=5;

/*10*/
USE geography;
SELECT country_name,iso_code
FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

/*11*/
SELECT p.peak_name,r.river_name,
       CONCAT(LOWER(p.peak_name),'',LOWER(SUBSTR(r.river_name,2)))AS mix
FROM peaks AS p,rivers As r
WHERE RIGHT(peak_name,1)=LEFT(river_name,1)
ORDER BY mix;

/*12*/
USE diablo;
SELECT name, DATE_FORMAT(start,'%Y-%m-%d') AS start
FROM games
WHERE year(start) between '2011-01-01' AND '2012-12-31'
ORDER BY start
LIMIT 50;

/*13*/
SELECT u.user_name, SUBSTRING(u.email, position('@' IN u.email)+1)  AS `Email Provider`
FROM users AS u
ORDER BY `Email Provider`,u.user_name;

/*14*/
SELECT user_name,ip_address
FROM users
WHERE ip_address like '___.1%.%.___'
ORDER BY  user_name;

/*15*/
SELECT name ,
       (CASE
           WHEN TIME (start) >='00:00:00' AND TIME (start)<'12:00:00' THEN 'Morning'
           WHEN TIME (start)>='12:00:00' AND TIME (start)<'18:00:00' THEN 'Afternoon'
           WHEN TIME (start)>='18:00:00' AND TIME (start)<'24:00:00' THEN 'Evening'
        END)AS 'Part of the day',
       ( CASE
          WHEN duration<=3 THEN 'Extra Short'
           WHEN duration BETWEEN 3 AND 6 THEN 'Short'
           WHEN duration BETWEEN 6 AND 10 THEN 'Long'
           ELSE 'Extra Long'
      END)AS 'Duration'
FROM games;
/*16*/
USE orders;
SELECT product_name,order_date,
       (DATE_ADD(order_date,INTERVAL 3 DAY ))AS 'pay_due',
       (DATE_ADD(order_date,INTERVAL 1 MONTH ))AS 'deliver_due'
FROM orders;


