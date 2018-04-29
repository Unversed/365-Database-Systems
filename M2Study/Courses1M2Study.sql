DROP DATABASE IF EXISTS Courses1M2Study;
CREATE DATABASE Courses1M2Study;
USE Courses1M2Study;

/* Schema */

CREATE TABLE `Person` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `lastName` VARCHAR(15) DEFAULT NULL,
   `firstName` VARCHAR(15) DEFAULT NULL,
   `gender` CHAR(1) NOT NULL,
   `major` VARCHAR(30) DEFAULT NULL,
   `unitsCompleted` INT(11) DEFAULT NULL,
   `dept` VARCHAR(30) DEFAULT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Term` (
   `id` INT(11) NOT NULL,
   `name` VARCHAR(10) NOT NULL,
   `startDate` DATE NOT NULL,
   `endDate` DATE NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Section` (
   `id` INT(11) NOT NULL,
   `title` VARCHAR(20) NOT NULL,
   `number` VARCHAR(5) NOT NULL,
   `numUnits` INT(11) DEFAULT NULL,
   `dept` VARCHAR(30) DEFAULT NULL,
   `termId` INT(11) NOT NULL,
   PRIMARY KEY (`id`),
   CONSTRAINT `FKSection_termId` FOREIGN KEY (`termId`) 
      REFERENCES `Term` (`id`)
);

CREATE TABLE `Teaches` (
   `teacherId` INT(11) NOT NULL,
   `sectionId` INT(11) NOT NULL,
   PRIMARY KEY (`teacherId`,`sectionId`),
   CONSTRAINT `FKTeaches_teacherId` FOREIGN KEY (`teacherId`)
      REFERENCES `Person` (`id`),
   CONSTRAINT `FKTeaches_sectionId` FOREIGN KEY (`sectionId`)
      REFERENCES `Section` (`id`)
);

CREATE TABLE `Takes` (
   `studentId` INT(11) NOT NULL,
   `sectionId` INT(11) NOT NULL,
   PRIMARY KEY (`studentId`,`sectionId`),
   CONSTRAINT `FKTakes_studentId` FOREIGN KEY (`studentId`)
      REFERENCES `Person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKTakes_sectionId` FOREIGN KEY (`sectionId`) 
      REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Dataset */

INSERT INTO `Person` VALUES
   (1, 'Logan', 'Juliet', 'F', 'Math', 60, NULL),
   (2, 'Arzt', 'Terrell', 'M', NULL, NULL, 'English'),
   (3, 'Esposita', 'Travis', 'M', 'Math', 15, NULL),
   (4, 'Engley', 'Sixta', 'F', NULL, NULL, 'Computer Science'),
   (5, 'Dunlow', 'Travis', 'M', 'English', 40, NULL),
   (6, 'Slingland', 'Josette', 'F', 'Computer Science', 10, 'Math'),
   (7, 'Toussand', 'Sharron', 'F', 'English', 20, NULL),
   (8, 'Esposita', 'Rupert', 'M', 'English', 125, NULL),
   (9, 'Hafferkamp', 'Cuc', 'F', 'Math', 0, NULL),
   (10, 'Dukelow', 'Coretta', 'F', 'Computer Science', 120, NULL);
   
INSERT INTO `Term` VALUES
   (1, 'S13', '2013-4-5', '2013-6-15'),
   (2, 'F13', '2013-9-20', '2013-12-11'),
   (3, 'W14', '2014-1-4', '2014-3-20');

INSERT INTO `Section` VALUES
   (1, 'Calculus 1', '101', 4, 'Math', 2),
   (2, 'Calculus 1', '101', 4, 'Math', 1),
   (3, 'Calculus 2', '102', 4, 'Math', 3),
   (4, 'Shakespeare', '222', 5, 'English', 1),
   (5, 'Shakespeare', '222', 5, 'English', 3),
   (6, 'Databases', '465', 4, 'Computer Science', 2),
   (7, 'Databases', '465', 4, 'Computer Science', 3),
   (8, 'Databases', '465', 4, 'Computer Science', 3);
   
INSERT INTO `Teaches` VALUES
   (4, 6), (6, 7), (6, 1), (4, 2), (4, 3), (2, 4), (2, 5);

INSERT INTO `Takes` VALUES
   (1, 1), (1, 4), (1, 6), (1, 3),
   (10, 1), (10, 4), (10, 6), (10, 3),
   (6, 4), (6, 6), (6, 3),
   (8, 1), (8, 2), (8, 6), (8, 7),
   (9, 4), (9, 5), (9, 2), (9, 3),
   (3, 3), (3, 5), (3, 7),
   (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7),
   (7, 8);
   







ALTER TABLE Person ADD age INT(1);
UPDATE Person 
SET age = 20
WHERE major IS NOT NULL;
UPDATE Person 
SET age = 40
WHERE dept IS NOT NULL ;

CREATE TABLE Student (
id int primary key,
unitsCompleted INT(11),
major varchar(30) not null
);
CREATE TABLE Teacher (
id INT PRIMARY KEY,
dept varchar(30) not null
);
INSERT INTO Student(id, unitsCompleted, major)
SELECT id, unitsCompleted, major 
FROM Person 
WHERE major IS NOT NULL;
INSERT INTO Teacher(id, dept)
SELECT id, dept 
FROM Person 
WHERE dept IS NOT NULL;
ALTER TABLE Person 
DROP COLUMN major, 
DROP COLUMN unitsCompleted, 
DROP COLUMN dept;

ALTER TABLE Teaches DROP FOREIGN KEY FKTeaches_teacherId;
ALTER TABLE Takes DROP FOREIGN KEY FKTakes_studentId;
ALTER TABLE Student ADD CONSTRAINT FKStudent_id FOREIGN KEY(id)
REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Teacher ADD CONSTRAINT FKTeacher_id FOREIGN KEY(id)
REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Teaches ADD CONSTRAINT FKTeaches_teacherId FOREIGN KEY(teacherId)
REFERENCES Teacher(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Takes ADD CONSTRAINT FKTakes_studentId FOREIGN KEY(studentId)
REFERENCES Student(id) ON DELETE CASCADE ON UPDATE CASCADE;

DROP TABLE IF EXISTS DeptNames;   
   
CREATE TEMPORARY TABLE DeptNames (
name VARCHAR(30)
);
INSERT INTO DeptNames SELECT dept FROM Teacher;
INSERT INTO DeptNames SELECT dept FROM Section;
INSERT INTO DeptNames SELECT major FROM Student;

CREATE TABLE Department (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30),
CONSTRAINT `UKname` UNIQUE(name)
);

INSERT INTO Department(name)
SELECT DISTINCT name
FROM DeptNames
ORDER BY name;

ALTER TABLE Student ADD COLUMN majorId INT AFTER unitsCompleted;
UPDATE Student 
SET majorId = (SELECT Department.id FROM Department WHERE Student.major = Department.name);
ALTER TABLE Teacher ADD COLUMN deptId INT AFTER id;
UPDATE Teacher 
SET deptId = (SELECT Department.id FROM Department WHERE Teacher.dept = Department.name);
ALTER TABLE Section ADD COLUMN deptId INT AFTER termId;
UPDATE Section 
SET deptId = (SELECT Department.id FROM Department WHERE Section.dept = Department.name);

ALTER TABLE Student 
DROP major,
ADD CONSTRAINT FKStudent_majorId
FOREIGN KEY (majorId)
REFERENCES Department(id) ON DELETE SET NULL;
ALTER TABLE Section
DROP dept,
ADD CONSTRAINT FKSection_deptId 
FOREIGN KEY (deptId)
REFERENCES Department(id) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Teacher
DROP dept,
ADD CONSTRAINT FKTeacher_deptId 
FOREIGN KEY (deptId)
REFERENCES Department(id) ON DELETE SET NULL;

CREATE TABLE Course (
   id INT AUTO_INCREMENT PRIMARY KEY,
   title varchar(20),
   number varchar(5), 
   numUnits INT,
   deptId INT,
   CONSTRAINT `UKnumber_deptId` UNIQUE(number, deptId),
   CONSTRAINT `FKCourse_deptId` FOREIGN KEY (`deptId`) 
      REFERENCES `Department`(`id`) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO Course(title, number, numUnits, deptId)
SELECT DISTINCT title, number, numUnits, deptId
FROM Section;

ALTER TABLE Section
ADD COLUMN courseId INT AFTER termId;
UPDATE Section 
SET courseId = (SELECT Course.id FROM Course WHERE Section.title = Course.title);
ALTER TABLE Section
DROP title,
DROP number,
DROP numUnits,
DROP FOREIGN KEY FKSection_deptId,
DROP deptId,
ADD CONSTRAINT FKSection_courseId 
FOREIGN KEY (courseId)
REFERENCES Course(id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Teacher
ADD COLUMN difficultyRating INT NOT NULL DEFAULT 5 AFTER id;

ALTER TABLE Course
ADD COLUMN coordId INT NULL,
ADD CONSTRAINT FKCourse_coordId 
FOREIGN KEY (coordId)
REFERENCES Teacher(id) ON DELETE SET NULL;

ALTER TABLE Teaches DROP FOREIGN KEY FKTeaches_sectionId;
ALTER TABLE Teaches ADD CONSTRAINT FKTeaches_sectionId 
FOREIGN KEY (sectionId) 
REFERENCES Section(id) ON DELETE CASCADE ON UPDATE CASCADE;







ALTER TABLE Person
DROP age,
ADD COLUMN `major` VARCHAR(30) DEFAULT NULL,
ADD COLUMN `unitsCompleted` INT(11) DEFAULT NULL,
ADD COLUMN `dept` VARCHAR(30) DEFAULT NULL;

UPDATE Person 
SET unitsCompleted = (SELECT unitsCompleted FROM Student WHERE Person.id = Student.id),
major = (SELECT majorId FROM Student WHERE Person.id = Student.id),
major = (SELECT name FROM Department WHERE major = Department.id),
dept = (SELECT deptId FROM Teacher WHERE Person.id = Teacher.id),
dept = (SELECT name FROM Department WHERE dept = Department.id);

ALTER TABLE Takes 
DROP FOREIGN KEY FKTakes_studentId;

ALTER TABLE Takes
ADD CONSTRAINT FKTakes_studentId 
FOREIGN KEY(studentId)
REFERENCES Person(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Teaches 
DROP FOREIGN KEY FKTeaches_sectionId,
DROP FOREIGN KEY FKTeaches_teacherId;

ALTER TABLE Teaches
ADD CONSTRAINT FKTeaches_sectionId 
FOREIGN KEY(sectionId) 
REFERENCES Section(id), 
ADD CONSTRAINT FKTeaches_teacherId
FOREIGN KEY(teacherId)
REFERENCES Person(id);

ALTER TABLE Section
ADD COLUMN dept VARCHAR(30) DEFAULT NULL AFTER id,
ADD COLUMN `numUnits` INT(11) DEFAULT NULL AFTER id,
ADD COLUMN `number` VARCHAR(5) NOT NULL AFTER id,
ADD COLUMN `title` VARCHAR(20) NOT NULL AFTER id;

UPDATE Section
SET title = (SELECT title FROM Course WHERE courseId = Course.id),
number = (SELECT number FROM Course WHERE courseId = Course.id),
numUnits = (SELECT numUnits FROM Course WHERE courseId = Course.id),
dept = (SELECT deptId FROM Course WHERE courseId = Course.id),
dept = (SELECT name FROM Department WHERE dept = Department.id);

ALTER TABLE Section
DROP FOREIGN KEY FKSection_courseId,
DROP courseId;

ALTER TABLE Course
DROP FOREIGN KEY FKCourse_coordId,
DROP FOREIGN KEY FKCourse_deptId;

DROP TABLE Course;
DROP TABLE Student;
DROP TABLE Teacher;
DROP TABLE Department;