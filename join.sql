create DATABASE STUDENTS;
USE STUDENTS;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE,
    gender ENUM('M', 'F', 'O'),
    enrollment_date DATE NOT NULL
);
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    credits INT CHECK (credits > 0),
    CONSTRAINT fk_department
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
);
SELECT * FROM enrollments;
SELECT * FROM enrollments;
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'F')),
    CONSTRAINT fk_student
        FOREIGN KEY (student_id) 
        REFERENCES students(student_id),
    CONSTRAINT fk_course
        FOREIGN KEY (course_id) 
        REFERENCES courses(course_id)
);
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    department_id INT,
    CONSTRAINT fk_instructor_department
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
);
INSERT INTO departments (department_name)
VALUES ('Computer Science'), ('Mathematics'), ('Physics'), ('Biology'), ('Chemistry');
INSERT INTO students (first_name, last_name, birthdate, gender, enrollment_date)
VALUES 
('John', 'Doe', '2000-01-15', 'M', '2018-09-01'),
('Jane', 'Smith', '1999-04-22', 'F', '2017-09-01'),
('Alice', 'Johnson', '2001-07-10', 'F', '2019-09-01'),
('Bob', 'Brown', '1998-11-30', 'M', '2016-09-01');
INSERT INTO courses (course_name, department_id, credits)
VALUES 
('Introduction to Computer Science', 1, 3),
('Calculus I', 2, 4),
('General Physics', 3, 4),
('Organic Chemistry', 5, 4);
INSERT INTO instructors (first_name, last_name, hire_date, department_id)
VALUES 
('Dr. Emily', 'Stone', '2010-08-15', 1),
('Dr. William', 'Green', '2008-06-20', 2),
('Dr. Charlotte', 'Adams', '2012-01-10', 3),
('Dr. Michael', 'Taylor', '2009-03-25', 5);

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES 
(1, 1, '2018-09-01', 'A'),
(1, 2, '2018-09-01', 'B'),
(2, 3, '2017-09-01', 'A'),
(3, 1, '2019-09-01', 'B'),
(4, 4, '2016-09-01', 'C');

SELECT S.FIRST_NAME , S.STUDENT_ID , E.GRADE ,C.course_name ,C.COURSE_ID FROM STUDENTS AS S 
JOIN enrollments AS E ON S.STUDENT_ID = E.STUDENT_ID 
JOIN courses AS C ON E.STUDENT_ID =  C.course_id ;
SELECT  S.FIRST_NAME , S.STUDENT_ID , D.DEPARTMENT_NAME FROM STUDENTS AS S 
JOIN DEPARTMENTS AS D ON  D.DEPARTMENT_ID = S.STUDENT_ID;
-- STUDENTS FROM DEPT
SELECT s.first_name, s.last_name, c.course_name, e.grade 
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
 -- DEPT OF EACH STUDENT
SELECT s.first_name, s.last_name, c.course_name, e.grade ,d.department_name
FROM students s 
JOIN  enrollments AS E ON E.student_id = S.STUDENT_ID
join courses as C ON  C.course_id = E.COURSE_ID
JOIN DEPARTMENTS AS D ON C.department_id= D.DEPARTMENT_ID;

SELECT I.first_name, I.last_name , D.DEPARTMENT_NAME FROM instructors AS I
JOIN departments AS D ON I.DEPARTMENT_ID = D.department_id;

SELECT s.first_name, s.last_name, C.COURSE_NAME , E.GRADE
FROM STUDENTS AS S
JOIN enrollments AS E  ON E.STUDENT_ID = S.STUDENT_ID
JOIN COURSES AS C ON  C.COURSE_ID = E.COURSE_ID WHERE C.CREDITS > 3;

select I.first_name from instructors as I LEFT JOIN DEPARTMENTS AS D ON I.department_id = D.DEPARTMENT_ID;
SELECT *FROM departments AS D INNER JOIN courses AS C ON C.department_id = D.DEPARTMENT_ID; 

-- SUB QUERIES

select FIRST_NAME,GENDER FROM STUDENTS WHERE GENDER in (select  gender from students  WHERE Gender  = 'f');


-- WHERE CLAUSE DIFF TABLE

SELECT FIRST_NAME FROM students WHERE STUDENT_ID IN ( SELECT COURSE_ID FROM ENROLLMENTS group by  COURSE_ID HAVING COUNT(COURSE_ID) >2);

select * from students union select * from enrollments; 

-- VIEW

CREATE VIEW SIMRAH_VIEW AS SELECT STUDENT_ID, FIRST_NAME,BIRTHDATE FROM STUDENTS;
SELECT *FROM SIMRAH_VIEW;

ALTER VIEW SIMRAH_VIEW AS SELECT GENDER,STUDENT_ID, FIRST_NAME,BIRTHDATE  FROM STUDENTS;
