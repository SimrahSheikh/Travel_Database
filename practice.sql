create database institute;
use institute;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE workers (
    worker_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
);
CREATE TABLE bonuses (
    bonus_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_id INT,
    bonus_amount DECIMAL(10, 2) NOT NULL,
    bonus_date DATE NOT NULL,
    CONSTRAINT fk_worker
        FOREIGN KEY (worker_id) 
        REFERENCES workers(worker_id) on delete cascade
);
CREATE TABLE salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    effective_date DATE NOT NULL,
    CONSTRAINT fk_worker_salary
        FOREIGN KEY (worker_id) 
        REFERENCES workers(worker_id) on delete cascade
);
INSERT INTO departments (department_name)
VALUES ('Human Resources'), ('Finance'), ('IT'), ('Sales');
INSERT INTO workers (first_name, last_name, department_id, hire_date, salary)
VALUES 
('John', 'Doe', 1, '2015-02-25', 55000.00),
('Jane', 'Smith', 2, '2016-07-14', 65000.00),
('Alice', 'Johnson', 3, '2018-03-20', 72000.00),
('Bob', 'Brown', 4, '2019-08-09', 48000.00),
('Charlie', 'Davis', 2, '2017-12-02', 69000.00);
INSERT INTO bonuses (worker_id, bonus_amount, bonus_date)
VALUES 
(1, 5000.00, '2021-12-25'),
(2, 3000.00, '2021-12-20'),
(3, 7000.00, '2021-12-22'),
(1, 4500.00, '2022-06-15'),
(4, 2500.00, '2022-01-10');
INSERT INTO salaries (worker_id, salary, effective_date)
VALUES 
(1, 56000.00, '2020-01-01'),
(1, 57000.00, '2021-01-01'),
(2, 66000.00, '2020-01-01'),
(3, 73000.00, '2020-01-01'),
(3, 74000.00, '2021-01-01'),
(4, 49000.00, '2021-01-01');
select * from workers;
select * from departments;
select * from salaries;
select * from bonuses;

-- Aliasing
select  first_name  as worker_name from  workers;

-- 2 uprcase first name
select UPPER(first_name ) from workers;

-- DISTINCT
SELECT distinct DEPARTMENT_ID FROM WORKERS;
SELECT DEPARTMENT_ID FROM WORKERS GROUP BY DEPARTMENT_id;
-- PRE PROCESSING
-- PRINT FIRST 3 CHAR
SELECT UPPER(substring( FIRST_NAME ,1,3)) FROM WORKERS ;
-- starting chars/letters
select instr(first_name , 's') from workers where first_name = 'alice';
-- select distinct departments_id from ;

select replace(first_name ,'a','A')from workers;

-- print first and last name togethr
select concat(first_name ,'  _ ' , last_name) as FUll_NAME FROM WORKERS;