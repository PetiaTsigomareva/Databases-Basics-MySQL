/*CREATE DATABASE homework_01;
USE homework_01;*/
/*Task7*/
DROP TABLE users;
CREATE TABLE users(
  id INT(11) primary key auto_increment,
  username VARCHAR(30) unique ,
  password VARCHAR(26),
  profile_picture BLOB(900),
  last_login_time DATETIME,
  is_deleted BOOL
);

INSERT INTO users(username,password,profile_picture,last_login_time,is_deleted)VALUE ('Petia2','fgT2#@','pic','2018-02-12 23:20:00',false );
INSERT INTO users(username,password,profile_picture,last_login_time,is_deleted)VALUE ('Ani','fgT2#@','pic','2018-02-15 23:20:00',true );
INSERT INTO users(username,password,profile_picture,last_login_time,is_deleted)VALUE ('Asen5','fgT2#@','pic','2018-05-25 23:20:00',false );
INSERT INTO users(username,password,profile_picture,last_login_time,is_deleted)VALUE ('Petia1288','fgT2#@','pic','2018-02-12 23:20:00',true );
INSERT INTO users(id,username,password,profile_picture,is_deleted)VALUE (6,'Tony5','fgT2#@','pic',false );

/*Task8*/
ALTER TABLE users ALTER id DROP DEFAULT;
ALTER TABLE users
	CHANGE COLUMN id id INT(11) NOT NULL FIRST,
	DROP PRIMARY KEY;

ALTER TABLE users
ADD CONSTRAINT PRIMARY KEY(id, username) ;
/*Task9*/
ALTER TABLE users
    CHANGE COLUMN last_login_time last_login_time DATETIME DEFAULT current_timestamp;
/*Task10*/
ALTER  TABLE users
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (id);

ALTER TABLE users
    CHANGE COLUMN username username VARCHAR(30) UNIQUE NOT NULL;
/*11*/
CREATE DATABASE movies;
USE movies;

CREATE TABLE directors(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  director_name VARCHAR(50) NOT NULL ,
  notes text
  );

INSERT INTO directors(director_name, notes) VALUE ('Ivan Petrov','hhejhetyjtwkfowe');
INSERT INTO directors(director_name, notes) VALUE ('Lili Petrov','hhejhetyjtwkfowe');
INSERT INTO directors(director_name, notes) VALUE ('Pesho Petrov','hhejhetyjtwkfowe');
INSERT INTO directors(director_name, notes) VALUE ('Stamat Petrov','');
INSERT INTO directors(director_name, notes) VALUE ('Anu Petrov','hhejhetyjtwkfowe');

CREATE TABLE genres(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  genre_name VARCHAR(50) NOT NULL,
  notes text
);
INSERT INTO genres(genre_name, notes) VALUE ('Drama','hhejhetyjtwkfowe');
INSERT INTO genres(genre_name, notes) VALUE ('Comedy','Good movie.');
INSERT INTO genres(genre_name, notes) VALUE ('Scary','OOOOyyyy');
INSERT INTO genres(genre_name, notes) VALUE ('Romantic','hhejhetyjtwkfowe');
INSERT INTO genres(genre_name, notes) VALUE ('Cryme','');

CREATE TABLE categories(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(50) NOT NULL ,
  notes text
  );

INSERT INTO categories(category_name, notes) VALUE ('fjtyfjtfjk','hhejhetyjtwkfowe');
INSERT INTO categories(category_name, notes) VALUE ('Category1','hhejhetyjtwkfowe');
INSERT INTO categories(category_name, notes) VALUE ('Category2','hhejhetyjtwkfowe');
INSERT INTO categories(category_name, notes) VALUE ('Category3','hhejhetyjtwkfowe');
INSERT INTO categories(category_name, notes) VALUE ('Category4','hhejhetyjtwkfowe');

CREATE TABLE movies(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  director_id INT(11) NOT NULL ,
  copyring_year YEAR NOT NULL,
  length TIME NOT NULL,
  genre_id INT(11) NOT NULL,
  category_id INT(11) NOT NULL,
  rating DOUBLE(2,1),
  notes TEXT

  );
INSERT INTO movies(title, director_id, copyring_year, length, genre_id, category_id, rating, notes)
            VALUE ('XMan',3,2010,'020700',1,2,8.5,'shhwryjwtyj');
INSERT INTO movies(title, director_id, copyring_year, length, genre_id, category_id, rating, notes)
            VALUE ('Fthrwhwth',1,2011,'022600',3,4,2,'shhwryjwtyj');

INSERT INTO movies(title, director_id, copyring_year, length, genre_id, category_id, rating, notes)
            VALUE ('XMan2',3,2002,'022900',4,4,1,'shhwryjwtyj');

INSERT INTO movies(title, director_id, copyring_year, length, genre_id, category_id, rating, notes)
            VALUE ('XMan1',3,2010,'022900',1,2,8.5,'shhwryjwtyj');

INSERT INTO movies(title, director_id, copyring_year, length, genre_id, category_id, rating, notes)
            VALUE ('XMan5',3,2010,'022900',1,2,2,'shhwryjwtyj');
/*12*/

CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  category VARCHAR(50),
  daily_rate DOUBLE,
  weekly_rate DOUBLE,
  monthly_rate DOUBLE,
  weekend_rate DOUBLE

);

INSERT INTO categories(category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
                VALUE ("Category1",20,35.5,50,6);
INSERT INTO categories(category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
                VALUE ("Category2",20,23,50,10.6);

INSERT INTO categories(category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
                VALUE ("Category3",25,35.5,100,12);

CREATE TABLE cars(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  plate_number VARCHAR(10),
  make VARCHAR(20),
  model VARCHAR(30),
  car_year YEAR,
  category_id INT(11),
  doors INT,
  picture BLOB,
  car_condition varchar(20),
  available enum('Yes','No')
);

INSERT INTO cars(plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
            VALUE ('CA1232EF','Germany','Opel Astra',1992,2,4,'pic','Good','Yes');

INSERT INTO cars(plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
            VALUE ('CA1232EF','Bulgaria','Lada Niva',1990,3,2,'pic','Not Well Condition','Yes');

INSERT INTO cars(plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
            VALUE ('CA1232EF','USA','BMW',1992,2,4,'pic','Good','No');



CREATE TABLE employees(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  title VARCHAR(20),
  notes TEXT

);

INSERT INTO employees(first_name, last_name, title, notes)
                  VALUE ('Pesho','Iliev','Title1','Notes1');

INSERT INTO employees(first_name, last_name, title, notes)
                  VALUE ('Ani','Petrova','Title2','Notes2');

INSERT INTO employees(first_name, last_name, title, notes)
                  VALUE ('Ilko','Ivanov','Title3','Notes3');




CREATE TABLE customers(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  driver_licence_number VARCHAR(20),
  full_name VARCHAR(30),
  address TEXT,
  city VARCHAR(30),
  zip_code VARCHAR(20),
  notes TEXT
);
 INSERT INTO customers(driver_licence_number, full_name, address, city, zip_code, notes)
                VALUE ('FF1236587GH','Petia Petrova','Adress','Sofia','2546','Notes');

INSERT INTO customers(driver_licence_number, full_name, address, city, zip_code, notes)
                VALUE ('FF1236587GH','Petia Petrova2','Adress2','Sofia','2546','Notes2');

INSERT INTO customers(driver_licence_number, full_name, address, city, zip_code, notes)
                VALUE ('FF1236587GH','Petia Petrova3','Adress3','Sofia','2546','Notes3');

CREATE TABLE rental_orders(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  employee_id INT(11),
  customer_id INT(11),
  car_id INT(11),
  car_condition VARCHAR(20),
  tank_level DOUBLE,
  kilometrage_start DOUBLE,
  kilometrage_end DOUBLE,
  total_kilometrage DOUBLE,
  start_date DATE,
  end_date DATE,
  total_days INT,
  rate_applied DOUBLE,
  tax_rate DOUBLE,
  order_status enum('Yes','No'),
  notes TEXT
);

INSERT INTO rental_orders(employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
                    VALUE (1,2,2,'Good',50,123654,56352,253666,'2018-02-15','2018-02-25',10,25.3,20,'Yes','shfjhsjh');

INSERT INTO rental_orders(employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
                    VALUE (2,3,1,'Good',50,123654,56352,253666,'2018-02-15','2018-03-30',20,25.3,20,'No','shfjhsjh');
INSERT INTO rental_orders(employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
                    VALUE (1,2,2,'Good',50,123654,56352,253666,'2018-12-15','2019-01-05',21,25.3,20,'Yes','shfjhsjh');

/*13*/
DROP DATABASE hotel;
CREATE DATABASE hotel;
USE hotel;

CREATE TABLE employees(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  title VARCHAR(20) NOT NULL,
  notes TEXT

);

INSERT INTO employees(first_name, last_name, title, notes) VALUE ('Petia','Petrova','Weitress','agsgaeshgas');
INSERT INTO employees(first_name, last_name, title, notes) VALUE ('Ivo','Petrov','Coocer','agsgaeshgas');
INSERT INTO employees(first_name, last_name, title, notes) VALUE ('Ani','Petrova','Cleaner',' ');

CREATE TABLE customers(
  account_number INT PRIMARY KEY NOT NULL ,
  first_name VARCHAR(20) NOT NULL ,
  last_name VARCHAR(20) NOT NULL ,
  phone_number VARCHAR(20) NOT NULL ,
  emergency_name VARCHAR(20) NOT NULL ,
  emergency_number VARCHAR(20) NOT NULL ,
  notes TEXT
);

INSERT INTO customers(account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)
               VALUE (23568,'Pepe1','Dihgdeg','028563694','EmergebcyName1','EmergencyPhone1','ehgerg');

INSERT INTO customers(account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)
               VALUE (23569,'Pepe2','Dihgdeg','028563694','EmergebcyName2','EmergencyPhone1','ehgerg');
INSERT INTO customers(account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)
               VALUE (23570,'Pepe3','Dihgdeg','028563694','EmergebcyName3','EmergencyPhone3','ehgerg');

CREATE TABLE room_status(

  room_status INT PRIMARY KEY NOT NULL ,
  notes TEXT
);

INSERT INTO room_status(room_status, notes) VALUE (1 ,'sbgfhbsrhb');
INSERT INTO room_status(room_status, notes) VALUE (2 ,'sbgfhbsrhb');
INSERT INTO room_status(room_status, notes) VALUE (3 ,'sbgfhbsrhb');

CREATE TABLE room_types (

  room_type INT PRIMARY KEY NOT NULL ,
  notes TEXT
);

INSERT INTO room_types(room_type, notes) VALUE (1 ,'adfgdf');
INSERT INTO room_types(room_type, notes) VALUE (2 ,'');
INSERT INTO room_types(room_type, notes) VALUE (5 ,'adfgdf');

CREATE TABLE bed_types (

  bed_type INT PRIMARY KEY NOT NULL ,
  notes TEXT

);


INSERT INTO bed_types(bed_type, notes) VALUE (2,'rrgeadfb');
INSERT INTO bed_types(bed_type, notes) VALUE (3,'dfbhgfb');
INSERT INTO bed_types(bed_type, notes) VALUE (5,'rrgeadfb');

CREATE TABLE rooms(

  room_number INT PRIMARY KEY NOT NULL ,
  room_type INT NOT NULL ,
  bed_type INT NOT NULL ,
  rate VARCHAR(50) NOT NULL ,
  room_status INT NOT NULL ,
  notes TEXT


);

INSERT INTO rooms(room_number, room_type, bed_type, rate, room_status, notes)
              VALUE (302,2,2,'rate1',2,'dvasdfg');
INSERT INTO rooms(room_number, room_type, bed_type, rate, room_status, notes)
              VALUE (405,4,3,'rate2',3 ,'');
INSERT INTO rooms(room_number, room_type, bed_type, rate, room_status, notes)
              VALUE (303,3,4,'rate3',4,'dvasdfg');

CREATE TABLE payments(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  employee_id INT(11)NOT NULL ,
  payment_date DATETIME NOT NULL ,
  account_number VARCHAR(20) NOT NULL ,
  first_date_occupied DATETIME NOT NULL,
  last_date_occupied DATETIME NOT NULL ,
  total_days INT NOT NULL ,
  amount_charged DOUBLE(10,2),
  tax_rate DOUBLE(10,2),
  tax_amount DOUBLE(10,2),
  payment_total DOUBLE(10,2) NOT NULL,
  notes TEXT

);

INSERT INTO payments(employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)
                 VALUE (2,'2015-02-03 15:00:02','sdfhge235','2015-01-28 12:00:00','2015-02-03 15:00:00',6,20.5,2,5,200,'hdrhev');

INSERT INTO payments(employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)
                 VALUE (1,'2015-02-03 15:00:02','sdfhge235','2015-01-28 12:00:00','2015-02-03 15:00:00',6,20.5,2,5,200,'hdrhev');

INSERT INTO payments(employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)
                 VALUE (3,'2015-02-03 15:00:02','sdfhge235','2015-01-28 12:00:00','2015-02-03 15:00:00',6,20.5,2,5,200,'hdrhev');
CREATE TABLE occupancies(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
   employee_id INT(11)NOT NULL ,
   date_occupied DATETIME NOT NULL,
   account_number VARCHAR(20) NOT NULL ,
   room_number INT NOT NULL ,
   rate_applied VARCHAR(10) NOT NULL ,
   phone_charge VARCHAR(20) NOT NULL,
   notes TEXT
);

INSERT INTO occupancies(employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes)
                  VALUE (2,'2015-01-28 12:00:00','dffhsrth25',303,'rate6','2568232265','dfher');

INSERT INTO occupancies(employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes)
                  VALUE (1,'2015-01-28 12:00:00','dffhsrth25',302,'rate5','2568232265','dfher');
INSERT INTO occupancies(employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes)
                  VALUE (3,'2015-01-28 12:00:00','dffhsrth25',405,'rate1','2568232265','dfher');
/*14*/
CREATE DATABASE soft_uni COLLATE = utf8_general_ci;
USE soft_uni;
 CREATE TABLE towns(
   id INT(11) PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(20) NOT NULL
 );

CREATE TABLE addresses(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  address_text TEXT NOT NULL ,
  town_id INT(11)

);

ALTER TABLE addresses
    ADD CONSTRAINT fk_towns_addresses foreign key (town_id)references towns(id);

 CREATE TABLE departments(
   id INT(11) PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(20) NOT NULL
 );

CREATE TABLE employees(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20),
  middle_name VARCHAR(20),
  last_name VARCHAR(20),
  job_title VARCHAR(50),
  department_id INT(11),
  hire_date DATE,
  salary DOUBLE,
  address_id INT(11)
);
ALTER TABLE employees
    ADD CONSTRAINT fk_department_employees foreign key (department_id)references departments(id);

ALTER TABLE employees
    ADD CONSTRAINT fk_address_employees foreign key (address_id)references addresses(id);
/*16*/
USE soft_uni;

INSERT INTO towns(name)VALUE ('Sofia');
INSERT INTO towns(name)VALUE ('Plovdiv');
INSERT INTO towns(name)VALUE ('Varna');
INSERT INTO towns(name)VALUE ('Burgas');

INSERT INTO departments(name)VALUE ('Engineering');
INSERT INTO departments(name)VALUE ('Sales');
INSERT INTO departments(name)VALUE ('Marketing');
INSERT INTO departments(name)VALUE ('Software Development');
INSERT INTO departments(name)VALUE ('Quality Assurance');


INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
                 VALUE ('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01',3500.00);
INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
                 VALUE ('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00);
INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
                 VALUE ('Maria','Petrova','Ivanova','Intern',5,'2016-08-28',525.25);
INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
                 VALUE ('Georgi','Terziev','Ivanov','CEO',2,'2007-12-09',3000.00);
INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
                 VALUE ('Peter','Pan','Pan','Intern',3,'2016-08-28',599.88);

/*17*/
SELECT *from towns;
SELECT * from departments;
SELECT * from employees;

/*18*/

SELECT *from towns ORDER BY name;
SELECT * from departments ORDER BY name;
SELECT * from employees ORDER BY salary DESC ;

/*19*/
SELECT name from towns ORDER BY name;
SELECT name from departments ORDER BY name;
SELECT first_name,last_name,job_title,salary from employees ORDER BY salary DESC ;

/*20*/
UPDATE employees
SET salary=salary*1.1;

SELECT salary
   from employees;
/*21*/
USE hotel;
SELECT tax_rate * 0.97 FROM payments;
/*22*/
SELECT *from occupancies;
TRUNCATE occupancies;