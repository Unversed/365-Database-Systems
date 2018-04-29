DROP DATABASE IF EXISTS Courses1;
CREATE DATABASE Courses1;
USE Courses1;

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
   

show create table Person;
show create table Term;
show create table Section;
show create table Teaches;
show create table Takes;