DROP DATABASE IF EXISTS Prereqs;
CREATE DATABASE Prereqs;
USE Prereqs;

create table Course (
   id int primary key auto_increment,
   name varchar(50) not null
);

create table Student (
   id int primary key auto_increment,
   firstName varchar(50) not null,
   lastName varchar(50) not null
);

create table Prereq (
   dependent int,
   requirement int,
   foreign key (dependent) references Course(id),
   foreign key (requirement) references Course(id),
   primary key(dependent, requirement)
);

create table Enrollment (
   studentId int,
   courseId int,
   foreign key (studentId) references Student(id),
   foreign key (courseId) references Course(id),
   primary key(studentId, courseId)
);

create table MissingPrereq (
    studentId int,
    courseId int,
    prereqId int,
    constraint FKMissingPrereq_studentId foreign key (studentId) references Student(id),
    constraint FKMissingPrereq_courseId foreign key (courseId) references Course(id),
    constraint FKMissingPrereq_prereqId foreign key (prereqId) references Course(id)
);
INSERT INTO Course VALUES (1,'Course000'),(2,'Course001'),(3,'Course002'),(4,'Course003'),(5,'Course004'),(6,'Course005'),(7,'Course006'),(8,'Course007'),(9,'Course008'),
(10,'Course009'),(11,'Course010'),(12,'Course011'),(13,'Course012'),(14,'Course013'),(15,'Course014'),(16,'Course015'),(17,'Course016'),(18,'Course017'),(19,'Course018'),
(20,'Course019'),(21,'Course020'),(22,'Course021'),(23,'Course022'),(24,'Course023'),(25,'Course024'),(26,'Course025'),(27,'Course026'),(28,'Course027'),(29,'Course028'),
(30,'Course029'),(31,'Course030'),(32,'Course031'),(33,'Course032'),(34,'Course033'),(35,'Course034'),(36,'Course035'),(37,'Course036'),(38,'Course037'),(39,'Course038'),
(40,'Course039'),(41,'Course040'),(42,'Course041'),(43,'Course042'),(44,'Course043'),(45,'Course044'),(46,'Course045'),(47,'Course046'),(48,'Course047'),(49,'Course048'),
(50,'Course049'),(51,'Course050'),(52,'Course051'),(53,'Course052'),(54,'Course053'),(55,'Course054'),(56,'Course055'),(57,'Course056'),(58,'Course057'),(59,'Course058'),
(60,'Course059'),(61,'Course060'),(62,'Course061'),(63,'Course062'),(64,'Course063'),(65,'Course064'),(66,'Course065'),(67,'Course066'),(68,'Course067'),(69,'Course068'),
(70,'Course069'),(71,'Course070'),(72,'Course071'),(73,'Course072'),(74,'Course073'),(75,'Course074'),(76,'Course075'),(77,'Course076'),(78,'Course077'),(79,'Course078'),
(80,'Course079'),(81,'Course080'),(82,'Course081'),(83,'Course082'),(84,'Course083'),(85,'Course084'),(86,'Course085'),(87,'Course086'),(88,'Course087'),(89,'Course088'),
(90,'Course089'),(91,'Course090'),(92,'Course091'),(93,'Course092'),(94,'Course093'),(95,'Course094'),(96,'Course095'),(97,'Course096'),(98,'Course097'),(99,'Course098'),
(100,'Course099'),(101,'Course100'),(102,'Course101'),(103,'Course102'),(104,'Course103'),(105,'Course104'),(106,'Course105'),(107,'Course106'),(108,'Course107'),
(109,'Course108'),(110,'Course109'),(111,'Course110'),(112,'Course111'),(113,'Course112'),(114,'Course113'),(115,'Course114'),(116,'Course115'),(117,'Course116'),
(118,'Course117'),(119,'Course118');

INSERT INTO Student VALUES (1,'First000','Last000'),(2,'First001','Last001'),(3,'First002','Last002'),(4,'First003','Last003'),(5,'First004','Last004'),(6,'First005','Last005'),(7,'First006','Last006'),(8,'First007','Last007'),(9,'First008','Last008'),(10,'First009','Last009'),(11,'First010','Last010'),(12,'First011','Last011'),(13,'First012','Last012'),(14,'First013','Last013'),(15,'First014','Last014'),(16,'First015','Last015'),(17,'First016','Last016'),(18,'First017','Last017'),(19,'First018','Last018'),(20,'First019','Last019'),(21,'First020','Last020'),(22,'First021','Last021'),(23,'First022','Last022'),(24,'First023','Last023'),(25,'First024','Last024'),(26,'First025','Last025'),(27,'First026','Last026'),(28,'First027','Last027'),(29,'First028','Last028');

INSERT INTO Enrollment VALUES (1,1),(2,1),(4,1),(5,1),(7,1),(8,1),(10,1),(11,1),(13,1),(14,1),(16,1),(17,1),(18,1),(19,1),(21,1),(22,1),(24,1),(25,1),(27,1),(28,1),(2,2),(4,2),(5,2),(7,2),(8,2),(10,2),(11,2),(13,2),(14,2),(16,2),(17,2),(19,2),(21,2),(22,2),(24,2),(25,2),(27,2),(28,2),(3,3),(6,3),(9,3),(12,3),(15,3),(20,3),(23,3),(26,3),(29,3),(4,4),(5,4),(7,4),(8,4),(10,4),(11,4),(13,4),(14,4),(16,4),(17,4),(21,4),(22,4),(24,4),(25,4),(27,4),(28,4),(5,5),(7,5),(8,5),(10,5),(11,5),(13,5),(14,5),(16,5),(17,5),(22,5),(24,5),(25,5),(27,5),(28,5),(6,6),(9,6),(12,6),(15,6),(23,6),(26,6),(29,6),(7,7),(8,7),(10,7),(11,7),(13,7),(14,7),(16,7),(17,7),(24,7),(25,7),(27,7),(28,7),(8,8),(10,8),(11,8),(13,8),(14,8),(16,8),(17,8),(25,8),(27,8),(28,8),(9,9),(12,9),(15,9),(26,9),(29,9),(10,10),(11,10),(13,10),(14,10),(16,10),(17,10),(27,10),(28,10),(11,11),(13,11),(14,11),(16,11),(17,11),(28,11),(12,12),(15,12),(29,12),(13,13),(14,13),(16,13),(17,13),(14,14),(16,14),(17,14),(15,15),(16,16),(17,16),(17,17);

INSERT INTO Prereq VALUES (2,1),(5,1),(8,1),(11,1),(14,1),(17,1),(4,2),(7,2),(10,2),(13,2),(16,2),(6,3),(9,3),(12,3),(15,3),(5,4),(8,4),(11,4),(14,4),(17,4),(7,5),(10,5),(13,5),(16,5),(9,6),(12,6),(15,6),(8,7),(11,7),(14,7),(17,7),(10,8),(13,8),(16,8),(12,9),(15,9),(11,10),(14,10),(17,10),(13,11),(16,11),(15,12),(14,13),(17,13),(16,14),(17,16);

SELECT courseId FROM Enrollment WHERE studentId = 2

SELECT max(requirement) FROM Prereq WHERE dependent = 1



/*SELECT * FROM Course;
SELECT * FROM Student;
SELECT * FROM Enrollment;
SELECT * FROM Prereq;

SET foreign_key_checks = 0;
DELETE FROM Course;
DELETE FROM Student;
DELETE FROM Enrollment;
DELETE FROM Prereq;
SET foreign_key_checks = 1;

SELECT * FROM Course;
SELECT * FROM Student;
SELECT * FROM Enrollment;
SELECT * FROM Prereq;

Alter Table astatments
ALTER TABLE Prereq
DROP FOREIGN KEY prereq_ibfk_1;
ALTER TABLE Prereq
DROP FOREIGN KEY prereq_ibfk_2;
ALTER TABLE Prereq
DROP PRIMARY KEY;
Truncate TABLE Prereq;


ALTER TABLE Enrollment 
DROP FOREIGN KEY enrollment_ibfk_1;
ALTER TABLE Enrollment
DROP FOREIGN KEY enrollment_ibfk_2;
ALTER TABLE Enrollment
DROP PRIMARY Key;
Truncate TABLE Enrollment;

TRUNCATE TABLE Course;
TRUNCATE TABLE Student;

ALTER TABLE Prereq
ADD CONSTRAINT foreign key (dependent) references Course(id),
ADD CONSTRAINT foreign key (requirement) references Course(id),
ADD primary key(dependent, requirement);


ALTER TABLE Enrollment
ADD CONSTRAINT foreign key (studentId) references Student(id),
ADD CONSTRAINT foreign key (courseId) references Course(id),
ADD primary key(studentId, courseId);




*/