DROP DATABASE IF EXISTS CoursesSubB;
CREATE DATABASE CoursesSubB;
USE CoursesSubB;

CREATE TABLE `Department` (
   `id` INT(11) NOT NULL,
   `name` VARCHAR(30) DEFAULT NULL,
   PRIMARY KEY (`id`),
   UNIQUE KEY `UKname` (`name`)
);

CREATE TABLE `Person` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `lastName` VARCHAR(15) DEFAULT NULL,
   `firstName` VARCHAR(15) DEFAULT NULL,
   `age` INT(11) DEFAULT NULL,
   `gender` CHAR(1) NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Student` (
   `id` INT(11) NOT NULL,
   `majorId` INT(11) DEFAULT NULL,
   `unitsCompleted` INT(11) DEFAULT NULL,
   `gpa` DOUBLE DEFAULT NULL,
   PRIMARY KEY (`id`),
   CONSTRAINT `FKStudent_id` FOREIGN KEY (`id`)
      REFERENCES `Person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKStudent_majorId` FOREIGN KEY (`majorId`)
      REFERENCES `Department` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Teacher` (
   `id` INT(11) NOT NULL,
   `deptId` INT(11) DEFAULT NULL,
   `difficultyRating` INT(11) NOT NULL DEFAULT '5',
   PRIMARY KEY (`id`),
   CONSTRAINT `FKTeacher_id` FOREIGN KEY (`id`)
      REFERENCES `Person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKTeacher_deptId` FOREIGN KEY (`deptId`)
      REFERENCES `Department` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Course` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `title` VARCHAR(20) DEFAULT NULL,
   `number` VARCHAR(5) DEFAULT NULL,
   `numUnits` INT(11) DEFAULT NULL,
   `deptId` INT(11) DEFAULT NULL,
   `coordId` INT(11) DEFAULT NULL,
  `avgGrade` DOUBLE DEFAULT NULL,
   PRIMARY KEY (`id`),
   CONSTRAINT `FKCourse_deptId` FOREIGN KEY (`deptId`)
      REFERENCES `Department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKCourse_coordId` FOREIGN KEY (`coordId`)
      REFERENCES `Teacher` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Term` (
   `id` INT(11) NOT NULL,
   `name` VARCHAR(10) DEFAULT NULL,
   `startDate` DATE DEFAULT NULL,
   `endDate` DATE DEFAULT NULL,
   `numSections` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Section` (
   `id` INT(11) NOT NULL,
   `courseId` INT(11) DEFAULT NULL,
   `termId` INT(11) DEFAULT NULL,
   PRIMARY KEY (`id`),
   CONSTRAINT `FKSection_courseId` FOREIGN KEY (`courseId`)
      REFERENCES `Course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKSection_termId` FOREIGN KEY (`termId`) 
      REFERENCES `Term` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Teaches` (
   `teacherId` INT(11) NOT NULL,
   `sectionId` INT(11) NOT NULL,
   PRIMARY KEY (`teacherId`, `sectionId`),
   CONSTRAINT `FKTeaches_teacherId` FOREIGN KEY (`teacherId`)
      REFERENCES `Teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKTeaches_sectionId` FOREIGN KEY (`sectionId`)
      REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Takes` (
   `studentId` INT(11) NOT NULL,
   `sectionId` INT(11) NOT NULL,
   `grade` SMALLINT(6) DEFAULT NULL,
   PRIMARY KEY (`studentId`, `sectionId`),
   CONSTRAINT `FKTakes_studentId` FOREIGN KEY (`studentId`)
      REFERENCES `Student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKTakes_sectionId` FOREIGN KEY (`sectionId`) 
      REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `Department` VALUES
   (1, 'Computer Science'),
   (2, 'Liberal Arts'),
   (3, 'Engineering'),
   (4, 'Sciences'),
   (5, 'Food Science');

INSERT INTO `Person` VALUES
   (1, 'Strickland', 'Sheryl', 27, 'F'),
   (2, 'Cox', 'Maggie', 52, 'F'),
   (3, 'Schneider', 'Bill', 97, 'M'),
   (4, 'Barrett', 'Marian', 22, 'F'),
   (5, 'Cohen', 'Lorenzo', 93, 'M'),
   (6, 'Brewer', 'Melissa', 37, 'F'),
   (7, 'Washington', 'Noel', 20, 'M'),
   (8, 'Evans', 'Wilma', 21, 'F'),
   (9, 'Harper', 'Mamie', 37, 'F'),
   (10, 'Rhodes', 'Guadalupe', 62, 'M'),
   (11, 'Richardson', 'Stacy', 50, 'F'),
   (12, 'Lawson', 'Lillie', 97, 'F'),
   (13, 'Clarke', 'Jean', 52, 'M'),
   (14, 'Hubbard', 'Harvey', 93, 'M'),
   (15, 'Ingram', 'Hattie', 38, 'F'),
   (16, 'Estrada', 'Alexander', 37, 'M'),
   (17, 'Jefferson', 'Ted', 75, 'M'),
   (18, 'Ramirez', 'Maxine', 73, 'F'),
   (19, 'Peterson', 'Whitney', 55, 'F'),
   (20, 'Crawford', 'Edna', 56, 'F'),
   (21, 'Curry', 'Sophie', 89, 'F'),
   (22, 'Steele', 'Christine', 28, 'F'),
   (23, 'Adkins', 'Marion', 78, 'F'),
   (24, 'Burke', 'Jody', 85, 'F'),
   (25, 'Ball', 'Darrel', 79, 'M'),
   (26, 'Ryan', 'Sue', 40, 'F'),
   (27, 'Singleton', 'Silvia', 66, 'F'),
   (28, 'Wade', 'Jeannette', 20, 'F'),
   (29, 'Fowler', 'Nick', 18, 'M'),
   (30, 'Houston', 'Doyle', 85, 'M'),
   (31, 'Chambers', 'Nancy', 97, 'F'),
   (32, 'Ramsey', 'Leslie', 66, 'F'),
   (33, 'Allen', 'Roger', 70, 'M'),
   (34, 'Wallace', 'Jon', 43, 'M'),
   (35, 'Harvey', 'Tabitha', 100, 'F'),
   (36, 'Swanson', 'Woodrow', 19, 'M'),
   (37, 'Arnold', 'Mona', 93, 'F'),
   (38, 'Powers', 'Darnell', 49, 'M'),
   (39, 'Hill', 'Jeanette', 62, 'F'),
   (40, 'Joseph', 'Bernard', 95, 'M'),
   (41, 'Willis', 'Beth', 99, 'F'),
   (42, 'Bridges', 'Timmy', 67, 'M'),
   (43, 'Tyler', 'Dana', 31, 'F'),
   (44, 'Daniels', 'Gertrude', 75, 'F'),
   (45, 'Romero', 'Paula', 76, 'F'),
   (46, 'Simpson', 'Rogelio', 100, 'M'),
   (47, 'Turner', 'Alton', 21, 'M'),
   (48, 'Patton', 'Kerry', 27, 'M'),
   (49, 'Day', 'Joseph', 98, 'M'),
   (50, 'Adams', 'Charles', 76, 'M'),
   (51, 'Mills', 'Laurie', 55, 'F'),
   (52, 'Lowe', 'Heidi', 41, 'F'),
   (53, 'Munoz', 'Danielle', 55, 'F'),
   (54, 'Vega', 'Theresa', 33, 'F'),
   (55, 'Saunders', 'Chris', 32, 'M'),
   (56, 'Cobb', 'Delia', 51, 'F'),
   (57, 'Murphy', 'Marta', 52, 'F'),
   (58, 'Santiago', 'Leo', 44, 'M'),
   (59, 'Pittman', 'Roy', 36, 'M'),
   (60, 'Meyer', 'Irving', 33, 'M');

INSERT INTO `Student` VALUES
   (1, 5, 91, 2.1), (2, 4, 69, 2.55), (3, 2, 56, 1.82), (4, 2, 95, 1.9), 
   (5, 3, 55, 2), (6, 3, 73, 2.01), (7, 1, 95, 2.22), (8, 1, 95, 2.23), 
   (9, 5, 74, 2.09), (10, 5, 71, 2.3), (11, 5, 58, 2.06), (12, 5, 71, 2.2), 
   (13, 4, 95, 2.04), (14, 3, 83, 1.87), (15, 2, 55, 1.57), (16, 1, 99, 2.09), 
   (17, 3, 75, 2.09), (18, 5, 67, 2.45), (19, 3, 73, 2.22), (20, 2, 71, 2.17), 
   (21, 5, 34, 2.23), (22, 1, 64, 2.21), (23, 4, 62, 1.96), (24, 1, 74, 1.77), 
   (25, 1, 68, 2.24), (26, 1, 61, 1.56), (27, 3, 67, 1.51), (28, 3, 103, 2.42), 
   (29, 4, 87, 1.99), (30, 3, 82, 2.1), (31, 5, 83, 1.94), (32, 5, 83, 1.85), 
   (33, 5, 79, 2.16), (34, 5, 107, 1.76), (35, 1, 89, 1.99), (36, 1, 83, 2.22), 
   (37, 1, 123, 2.23), (38, 1, 49, 2.31), (39, 1, 53, 2), (40, 5, 105, 2.27);

INSERT INTO `Teacher` VALUES
   (41, 2, 24),
   (42, 4, 42),
   (43, 1, 23),
   (44, 5, 60),
   (45, 3, 89),
   (46, 4, 4),
   (47, 2, 18),
   (48, 1, 81),
   (49, 2, 16),
   (50, 4, 40),
   (51, 2, 24),
   (52, 4, 42),
   (53, 1, 23),
   (54, 5, 60),
   (55, 3, 89),
   (56, 3, 4),
   (57, 2, 18),
   (58, 1, 81),
   (59, 2, 16),
   (60, 1, 40);

INSERT INTO `Course` VALUES 
   (1, 'Calculus', '127', 5, 5, 46, 1.85),
   (2, 'Data Structures', '450', 3, 1, 48, 2.22), 
   (3, 'Shakespeare', '418', 5, 4, 43, 2.14), 
   (4, 'Humanities', '118', 7, 5, 47, 2.22), 
   (5, 'Oh, The Humanity!', '189', 3, 5, 48, 1.92), 
   (6, 'Calculus II', '280', 7, 4, 48, 1.95), 
   (7, 'Java Programming', '483', 3, 3, 44, 2.26), 
   (8, 'C Programming', '432', 5, 3, 43, 1.81), 
   (9, 'Systems Programming', '114', 4, 2, 46, 1.97), 
   (10, 'Food Packaging', '376', 7, 2, 48, 2), 
   (11, 'Nutrition', '110', 4, 4, 44, 2.19), 
   (12, 'Ancient Greek Lit', '350', 7, 3, 42, 2.26), 
   (13, 'Chemistry', '489', 6, 2, 42, 2.18), 
   (14, 'Physics A: Knmtcs', '409', 4, 1, 44, 2.3), 
   (15, 'Physics B: Waves', '155', 2, 5, 49, 2.15), 
   (16, 'Physics C: Elec', '386', 4, 4, 49, 1.97), 
   (17, 'Kinesiology', '350', 7, 2, 50, 1.83), 
   (18, 'Biology', '341', 2, 1, 43, 1.89), 
   (19, 'Astronomy', '249', 2, 5, 41, 2.24), 
   (20, 'Astrology', '353', 7, 4, 41, 2.2), 
   (21, 'Game Development', '173', 5, 3, 42, NULL),
   (22, 'How To Fuck', '69', 69, 4, 58, NULL);

INSERT INTO `Term` VALUES 
   (1, 'W11', '2011-01-15', '2011-04-01', 39), 
   (2, 'S11', '2011-04-15', '2011-07-01', 37), 
   (3, 'F11', '2011-09-01', '2011-11-15', 32), 
   (4, 'W12', '2012-01-15', '2012-04-01', 33), 
   (5, 'S12', '2012-04-15', '2012-07-01', 37), 
   (6, 'F12', '2012-09-01', '2012-11-15', 31), 
   (7, 'W13', '2013-01-15', '2013-04-01', 25), 
   (8, 'S13', '2013-04-15', '2013-07-01', 37), 
   (9, 'F13', '2013-09-01', '2013-11-15', 31);

INSERT INTO `Section` VALUES (1, 1, 1), (2, 1, 1), (3, 1, 1), (4, 1, 1), (5, 3, 1), (6, 3, 1), (7, 5, 1), (8, 5, 1), (9, 5, 1), (10, 5, 1), (11, 6, 1), (12, 6, 1), (13, 8, 1), (14, 8, 1), (15, 9, 1), (16, 9, 1), (17, 10, 1), (18, 10, 1), (19, 10, 1), (20, 11, 1), (21, 11, 1), (22, 11, 1), (23, 13, 1), (24, 13, 1), (25, 13, 1), (26, 13, 1), (27, 14, 1), (28, 14, 1), (29, 14, 1), (30, 15, 1), (31, 15, 1), (32, 15, 1), (33, 16, 1), (34, 16, 1), (35, 18, 1), (36, 19, 1), (37, 20, 1), (38, 20, 1), (39, 1, 2), (40, 1, 2), (41, 1, 2), (42, 2, 2), (43, 2, 2), (44, 2, 2), (45, 3, 2), (46, 4, 2), (47, 4, 2), (48, 5, 2), (49, 5, 2), (50, 5, 2), (51, 5, 2), (52, 7, 2), (53, 7, 2), (54, 8, 2), (55, 8, 2), (56, 9, 2), (57, 9, 2), (58, 10, 2), (59, 10, 2), (60, 10, 2), (61, 11, 2), (62, 11, 2), (63, 12, 2), (64, 12, 2), (65, 12, 2), (66, 12, 2), (67, 14, 2), (68, 15, 2), (69, 17, 2), (70, 18, 2), (71, 18, 2), (72, 18, 2), (73, 19, 2), (74, 19, 2), (75, 1, 3), (76, 3, 3), (77, 4, 3), (78, 4, 3), (79, 4, 3), (80, 5, 3), (81, 5, 3), (82, 8, 3), (83, 8, 3), (84, 8, 3), (85, 8, 3), (86, 10, 3), (87, 10, 3), (88, 10, 3), (89, 11, 3), (90, 11, 3), (91, 11, 3), (92, 11, 3), (93, 12, 3), (94, 12, 3), (95, 12, 3), (96, 13, 3), (97, 13, 3), (98, 13, 3), (99, 17, 3), (100, 17, 3), (101, 17, 3), (102, 17, 3), (103, 18, 3), (104, 18, 3), (105, 18, 3), (106, 1, 4), (107, 1, 4), (108, 5, 4), (109, 5, 4), (110, 5, 4), (111, 5, 4), (112, 6, 4), (113, 6, 4), (114, 6, 4), (115, 6, 4), (116, 8, 4), (117, 9, 4), (118, 9, 4), (119, 10, 4), (120, 10, 4), (121, 10, 4), (122, 10, 4), (123, 11, 4), (124, 12, 4), (125, 12, 4), (126, 13, 4), (127, 14, 4), (128, 14, 4), (129, 14, 4), (130, 16, 4), (131, 17, 4), (132, 19, 4), (133, 19, 4), (134, 20, 4), (135, 20, 4), (136, 20, 4), (137, 20, 4), (138, 1, 5), (139, 1, 5), (140, 1, 5), (141, 3, 5), (142, 3, 5), (143, 5, 5), (144, 5, 5), (145, 5, 5), (146, 7, 5), (147, 7, 5), (148, 7, 5), (149, 7, 5), (150, 8, 5), (151, 8, 5), (152, 9, 5), (153, 9, 5), (154, 10, 5), (155, 10, 5), (156, 11, 5), (157, 15, 5), (158, 15, 5), (159, 15, 5), (160, 16, 5), (161, 17, 5), (162, 17, 5), (163, 18, 5), (164, 18, 5), (165, 18, 5), (166, 18, 5), (167, 19, 5), (168, 19, 5), (169, 19, 5), (170, 20, 5), (171, 20, 5), (172, 20, 5), (173, 20, 5), (174, 2, 6), (175, 4, 6), (176, 4, 6), (177, 5, 6), (178, 7, 6), (179, 7, 6), (180, 7, 6), (181, 8, 6), (182, 9, 6), (183, 9, 6), (184, 9, 6), (185, 9, 6), (186, 10, 6), (187, 10, 6), (188, 10, 6), (189, 10, 6), (190, 13, 6), (191, 13, 6), (192, 13, 6), (193, 14, 6), (194, 16, 6), (195, 16, 6), (196, 17, 6), (197, 17, 6), (198, 17, 6), (199, 17, 6), (200, 18, 6), (201, 18, 6), (202, 18, 6), (203, 18, 6), (204, 1, 7), (205, 1, 7), (206, 1, 7), (207, 1, 7), (208, 2, 7), (209, 3, 7), (210, 7, 7), (211, 8, 7), (212, 8, 7), (213, 11, 7), (214, 12, 7), (215, 12, 7), (216, 12, 7), (217, 13, 7), (218, 14, 7), (219, 14, 7), (220, 15, 7), (221, 15, 7), (222, 15, 7), (223, 15, 7), (224, 16, 7), (225, 17, 7), (226, 18, 7), (227, 19, 7), (228, 1, 8), (229, 1, 8), (230, 1, 8), (231, 3, 8), (232, 3, 8), (233, 3, 8), (234, 6, 8), (235, 6, 8), (236, 7, 8), (237, 7, 8), (238, 7, 8), (239, 7, 8), (240, 9, 8), (241, 9, 8), (242, 9, 8), (243, 9, 8), (244, 10, 8), (245, 10, 8), (246, 12, 8), (247, 13, 8), (248, 14, 8), (249, 14, 8), (250, 15, 8), (251, 15, 8), (252, 15, 8), (253, 16, 8), (254, 16, 8), (255, 18, 8), (256, 18, 8), (257, 18, 8), (258, 19, 8), (259, 19, 8), (260, 19, 8), (261, 20, 8), (262, 20, 8), (263, 20, 8), (264, 1, 9), (265, 2, 9), (266, 2, 9), (267, 2, 9), (268, 2, 9), (269, 3, 9), (270, 4, 9), (271, 4, 9), (272, 5, 9), (273, 5, 9), (274, 7, 9), (275, 10, 9), (276, 10, 9), (277, 10, 9), (278, 12, 9), (279, 12, 9), (280, 15, 9), (281, 15, 9), (282, 15, 9), (283, 17, 9), (284, 17, 9), (285, 17, 9), (286, 17, 9), (287, 18, 9), (288, 18, 9), (289, 18, 9), (290, 20, 9), (291, 20, 9), (292, 20, 9), (293, 20, 9);

INSERT INTO `Section` VALUES (294, 22, 1), (295, 22, 2), (296, 22, 3), (297, 22, 4), (298, 22, 5), (299, 22, 6), (300, 22, 7), (301, 22, 8), (302, 22, 9);

INSERT INTO `Takes` VALUES (1, 4, 0), (1, 14, 0), (1, 37, 3), (1, 53, 4), (1, 61, 2), (1, 68, 4), (1, 76, 2), (1, 84, 0), (1, 106, 2), (1, 112, 3), (1, 116, 2), (1, 123, 4), (1, 152, 3), (1, 158, 4), (1, 162, 3), (1, 164, 0), (1, 168, 4), (1, 172, 3), (1, 179, 0), (1, 183, 4), (1, 184, 0), (1, 196, 2), (1, 240, 1), (1, 251, 2), (1, 265, 1), (1, 271, 2), (2, 3, 0), (2, 13, 0), (2, 21, 3), (2, 32, 4), (2, 45, 2), (2, 62, 4), (2, 72, 4), (2, 81, 3), (2, 102, 4), (2, 105, 2), (2, 122, 4), (2, 130, 2), (2, 136, 3), (2, 137, 4), (2, 148, 0), (2, 176, 3), (2, 184, 1), (2, 249, 1), (3, 35, 3), (3, 37, 0), (3, 76, 4), (3, 138, 1), (3, 152, 0), (3, 176, 4), (3, 184, 2), (3, 194, 2), (3, 212, 0), (3, 214, 2), (3, 218, 1), (3, 222, 0), (3, 235, 3), (3, 239, 2), (3, 260, 3), (3, 268, 1), (3, 274, 2), (4, 18, 2), (4, 39, 3), (4, 57, 1), (4, 77, 1), (4, 94, 3), (4, 106, 0), (4, 126, 0), (4, 132, 1), (4, 140, 4), (4, 145, 4), (4, 162, 1), (4, 167, 1), (4, 180, 4), (4, 184, 3), (4, 200, 4), (4, 202, 1), (4, 212, 1), (4, 216, 0), (4, 227, 1), (4, 234, 3), (4, 239, 3), (4, 243, 2), (4, 257, 1), (4, 261, 0), (4, 269, 3), (4, 275, 4), (5, 1, 1), (5, 7, 2), (5, 12, 2), (5, 40, 0), (5, 47, 2), (5, 73, 3), (5, 84, 4), (5, 89, 4), (5, 96, 1), (5, 140, 0), (5, 217, 2), (5, 222, 2), (5, 233, 3), (5, 274, 4), (6, 8, 4), (6, 13, 4), (6, 25, 1), (6, 46, 2), (6, 54, 0), (6, 69, 0), (6, 105, 1), (6, 123, 4), (6, 139, 0), (6, 145, 1), (6, 148, 4), (6, 160, 1), (6, 178, 4), (6, 188, 4), (6, 198, 4), (6, 212, 3), (6, 223, 4), (6, 234, 0), (6, 240, 1), (6, 264, 0), (6, 265, 1), (6, 273, 4), (6, 282, 3), (7, 12, 4), (7, 16, 3), (7, 21, 3), (7, 33, 0), (7, 54, 1), (7, 55, 2), (7, 67, 4), (7, 117, 4), (7, 130, 2), (7, 156, 3), (7, 159, 1), (7, 167, 4), (7, 171, 3), (7, 183, 0), (7, 190, 2), (7, 195, 2), (7, 218, 0), (7, 222, 4), (7, 238, 0), (7, 244, 1), (7, 246, 3), (7, 264, 1), (7, 269, 1), (7, 277, 4), (8, 14, 2), (8, 20, 3), (8, 36, 4), (8, 48, 1), (8, 49, 2), (8, 53, 1), (8, 71, 4), (8, 79, 2), (8, 83, 1), (8, 84, 2), (8, 120, 3), (8, 143, 1), (8, 144, 2), (8, 160, 3), (8, 164, 2), (8, 166, 4), (8, 177, 0), (8, 195, 3), (8, 199, 2), (8, 204, 2), (8, 220, 3), (8, 234, 2), (8, 239, 2), (8, 257, 0), (8, 261, 4), (9, 25, 4), (9, 48, 2), (9, 57, 1), (9, 80, 4), (9, 94, 3), (9, 99, 3), (9, 127, 1), (9, 164, 3), (9, 166, 0), (9, 179, 3), (9, 192, 1), (9, 200, 4), (9, 212, 1), (9, 219, 3), (9, 222, 1), (9, 231, 0), (9, 243, 2), (9, 244, 3), (9, 264, 3), (9, 271, 0), (10, 17, 2), (10, 26, 1), (10, 35, 0), (10, 36, 1), (10, 58, 3), (10, 76, 1), (10, 84, 4), (10, 104, 4), (10, 107, 2), (10, 123, 3), (10, 134, 4), (10, 143, 3), (10, 150, 0), (10, 154, 4), (10, 174, 4), (10, 179, 4), (10, 215, 0), (10, 255, 0), (10, 264, 4), (10, 265, 0), (11, 19, 0), (11, 52, 3), (11, 61, 2), (11, 71, 2), (11, 91, 2), (11, 99, 0), (11, 123, 4), (11, 127, 3), (11, 141, 2), (11, 147, 3), (11, 166, 2), (11, 180, 1), (11, 200, 1), (11, 207, 3), (11, 218, 4), (11, 243, 4), (11, 255, 1), (11, 261, 2), (12, 1, 3), (12, 5, 2), (12, 37, 4), (12, 47, 4), (12, 49, 1), (12, 53, 0), (12, 61, 3), (12, 72, 4), (12, 73, 0), (12, 89, 1), (12, 123, 0), (12, 140, 2), (12, 149, 1), (12, 154, 1), (12, 157, 4), (12, 176, 3), (12, 182, 4), (12, 248, 0), (12, 266, 3), (12, 274, 1), (13, 4, 2), (13, 6, 4), (13, 12, 0), (13, 26, 4), (13, 34, 2), (13, 68, 1), (13, 72, 0), (13, 78, 1), (13, 88, 1), (13, 125, 3), (13, 129, 2), (13, 140, 3), (13, 163, 1), (13, 176, 4), (13, 189, 2), (13, 202, 0), (13, 215, 3), (13, 227, 0), (13, 233, 1), (13, 249, 2), (13, 253, 1), (13, 264, 2), (13, 280, 3), (14, 4, 3), (14, 5, 4), (14, 10, 4), (14, 12, 1), (14, 47, 1), (14, 91, 0), (14, 104, 3), (14, 107, 1), (14, 112, 1), (14, 125, 4), (14, 147, 1), (14, 148, 2), (14, 152, 1), (14, 164, 3), (14, 171, 0), (14, 172, 1), (14, 199, 3), (14, 220, 4), (14, 233, 2), (14, 258, 2), (15, 33, 3), (15, 70, 0), (15, 82, 2), (15, 90, 0), (15, 102, 2), (15, 113, 3), (15, 138, 3), (15, 158, 3), (15, 160, 0), (15, 188, 3), (15, 208, 3), (15, 215, 0), (15, 232, 2), (15, 235, 0), (15, 266, 1), (15, 270, 0), (15, 277, 2), (16, 5, 1), (16, 72, 3), (16, 109, 0), (16, 113, 4), (16, 127, 3), (16, 140, 1), (16, 150, 1), (16, 154, 0), (16, 162, 3), (16, 171, 2), (16, 172, 3), (16, 173, 4), (16, 180, 1), (16, 185, 1), (16, 188, 4), (16, 192, 3), (16, 194, 0), (16, 200, 1), (16, 207, 3), (16, 215, 1), (16, 248, 4), (16, 267, 3), (16, 269, 0), (16, 274, 0), (16, 287, 3), (17, 4, 1), (17, 5, 2), (17, 21, 3), (17, 27, 4), (17, 59, 1), (17, 89, 1), (17, 97, 4), (17, 109, 1), (17, 120, 2), (17, 127, 4), (17, 134, 1), (17, 178, 0), (17, 192, 4), (17, 195, 2), (17, 207, 4), (17, 240, 2), (17, 283, 0), (18, 8, 1), (18, 23, 1), (18, 32, 0), (18, 40, 3), (18, 55, 3), (18, 68, 1), (18, 89, 2), (18, 120, 3), (18, 127, 0), (18, 149, 2), (18, 189, 2), (18, 195, 3), (18, 216, 4), (18, 275, 3), (18, 276, 4), (19, 28, 2), (19, 29, 3), (19, 44, 3), (19, 49, 3), (19, 52, 1), (19, 54, 3), (19, 75, 4), (19, 86, 0), (19, 105, 4), (19, 130, 4), (19, 139, 3), (19, 188, 2), (19, 189, 3), (19, 202, 1), (19, 214, 3), (19, 216, 0), (19, 241, 0), (19, 257, 1), (19, 273, 2), (19, 284, 3), (20, 19, 4), (20, 31, 1), (20, 37, 2), (20, 43, 3), (20, 45, 0), (20, 55, 0), (20, 60, 0), (20, 69, 4), (20, 91, 1), (20, 98, 3), (20, 104, 4), (20, 130, 0), (20, 135, 0), (20, 207, 2), (20, 214, 4), (20, 223, 3), (20, 230, 0), (20, 233, 3), (20, 244, 4), (20, 249, 4), (20, 274, 4), (21, 33, 4), (21, 35, 1), (21, 49, 0), (21, 103, 4), (21, 130, 1), (21, 132, 3), (21, 133, 4), (21, 146, 2), (21, 163, 4), (21, 187, 3), (21, 195, 1), (21, 226, 2), (21, 259, 0), (22, 6, 3), (22, 7, 4), (22, 55, 2), (22, 66, 3), (22, 71, 3), (22, 132, 4), (22, 134, 1), (22, 137, 4), (22, 143, 0), (22, 154, 1), (22, 172, 4), (22, 184, 1), (22, 231, 3), (22, 236, 3), (22, 273, 0), (22, 283, 0), (23, 13, 1), (23, 39, 2), (23, 51, 4), (23, 96, 4), (23, 124, 2), (23, 126, 4), (23, 136, 4), (23, 138, 1), (23, 145, 3), (23, 174, 2), (23, 190, 3), (23, 212, 0), (23, 217, 0), (23, 223, 1), (23, 243, 1), (23, 257, 0), (23, 277, 0), (24, 4, 3), (24, 5, 4), (24, 12, 1), (24, 15, 4), (24, 21, 0), (24, 55, 4), (24, 59, 3), (24, 66, 0), (24, 86, 0), (24, 94, 3), (24, 96, 0), (24, 121, 0), (24, 130, 4), (24, 145, 4), (24, 171, 0), (24, 177, 1), (24, 191, 0), (24, 214, 3), (24, 254, 3), (24, 255, 4), (24, 262, 1), (24, 280, 4), (24, 282, 1), (25, 24, 4), (25, 29, 4), (25, 47, 2), (25, 57, 2), (25, 68, 3), (25, 94, 4), (25, 111, 1), (25, 132, 2), (25, 140, 0), (25, 141, 1), (25, 145, 0), (25, 181, 1), (25, 214, 4), (25, 232, 2), (25, 252, 2), (25, 258, 3), (25, 260, 0), (25, 277, 2), (26, 25, 1), (26, 69, 0), (26, 72, 3), (26, 76, 2), (26, 83, 4), (26, 84, 0), (26, 96, 2), (26, 114, 0), (26, 127, 3), (26, 138, 4), (26, 154, 0), (26, 190, 1), (26, 203, 4), (26, 208, 4), (26, 216, 2), (26, 236, 2), (26, 244, 0), (26, 256, 2), (26, 260, 1), (26, 272, 3), (27, 18, 0), (27, 24, 1), (27, 32, 4), (27, 37, 4), (27, 63, 0), (27, 64, 1), (27, 69, 1), (27, 78, 0), (27, 80, 2), (27, 139, 1), (27, 148, 0), (27, 180, 2), (27, 211, 3), (27, 217, 4), (27, 220, 2), (27, 235, 2), (27, 284, 1), (28, 14, 2), (28, 19, 2), (28, 26, 4), (28, 35, 3), (28, 39, 2), (28, 43, 1), (28, 61, 4), (28, 67, 0), (28, 89, 2), (28, 94, 2), (28, 106, 4), (28, 112, 0), (28, 116, 4), (28, 125, 3), (28, 141, 4), (28, 154, 2), (28, 156, 4), (28, 191, 4), (28, 211, 4), (28, 217, 0), (28, 223, 1), (28, 224, 2), (28, 239, 2), (28, 244, 2), (29, 3, 2), (29, 14, 3), (29, 18, 2), (29, 19, 3), (29, 26, 0), (29, 40, 4), (29, 52, 1), (29, 57, 1), (29, 65, 4), (29, 71, 0), (29, 80, 4), (29, 125, 4), (29, 138, 2), (29, 141, 0), (29, 148, 2), (29, 166, 0), (29, 177, 1), (29, 188, 2), (29, 202, 1), (29, 217, 1), (29, 261, 0), (29, 269, 3), (29, 273, 2), (30, 1, 1), (30, 18, 3), (30, 21, 1), (30, 25, 0), (30, 33, 3), (30, 49, 4), (30, 56, 1), (30, 109, 4), (30, 126, 1), (30, 129, 4), (30, 149, 4), (30, 163, 3), (30, 166, 1), (30, 171, 1), (30, 173, 3), (30, 179, 4), (30, 231, 1), (30, 238, 3), (30, 255, 0), (30, 262, 2), (30, 268, 3), (31, 23, 4), (31, 30, 1), (31, 33, 4), (31, 46, 2), (31, 71, 2), (31, 75, 1), (31, 109, 0), (31, 117, 3), (31, 120, 1), (31, 132, 3), (31, 134, 0), (31, 139, 0), (31, 147, 3), (31, 171, 2), (31, 176, 2), (31, 181, 2), (31, 192, 3), (31, 231, 2), (31, 239, 0), (31, 256, 2), (31, 277, 3), (31, 287, 3), (32, 19, 1), (32, 28, 0), (32, 38, 0), (32, 57, 4), (32, 61, 3), (32, 70, 2), (32, 83, 0), (32, 84, 1), (32, 91, 3), (32, 96, 3), (32, 99, 1), (32, 116, 3), (32, 126, 3), (32, 135, 2), (32, 152, 4), (32, 163, 0), (32, 189, 1), (32, 217, 4), (32, 220, 2), (32, 271, 3), (32, 283, 0), (33, 8, 1), (33, 26, 4), (33, 34, 2), (33, 64, 2), (33, 70, 3), (33, 85, 3), (33, 109, 2), (33, 123, 1), (33, 125, 3), (33, 136, 4), (33, 143, 1), (33, 158, 1), (33, 162, 0), (33, 164, 2), (33, 190, 3), (33, 213, 1), (33, 218, 1), (33, 220, 3), (33, 257, 0), (33, 265, 3), (33, 273, 1), (33, 281, 4), (34, 17, 1), (34, 45, 4), (34, 49, 3), (34, 69, 3), (34, 71, 0), (34, 83, 2), (34, 94, 3), (34, 97, 1), (34, 107, 1), (34, 111, 0), (34, 114, 3), (34, 122, 1), (34, 137, 1), (34, 141, 0), (34, 149, 3), (34, 163, 2), (34, 179, 3), (34, 200, 4), (34, 213, 2), (34, 218, 2), (34, 242, 1), (34, 253, 2), (34, 256, 0), (34, 261, 0), (34, 264, 3), (34, 267, 1), (34, 275, 4), (34, 276, 0), (34, 281, 0), (35, 3, 3), (35, 14, 4), (35, 17, 2), (35, 32, 2), (35, 40, 0), (35, 69, 4), (35, 98, 3), (35, 101, 1), (35, 106, 1), (35, 122, 2), (35, 129, 4), (35, 146, 1), (35, 177, 2), (35, 188, 3), (35, 192, 2), (35, 196, 1), (35, 205, 0), (35, 238, 3), (35, 240, 0), (35, 252, 2), (35, 267, 2), (35, 280, 0), (36, 25, 1), (36, 34, 0), (36, 53, 4), (36, 57, 3), (36, 86, 2), (36, 91, 2), (36, 98, 4), (36, 111, 2), (36, 125, 1), (36, 147, 3), (36, 152, 3), (36, 158, 4), (36, 173, 4), (36, 200, 1), (36, 202, 3), (36, 216, 2), (36, 231, 2), (36, 240, 1), (36, 255, 1), (36, 265, 1), (36, 282, 3), (37, 21, 3), (37, 27, 4), (37, 37, 4), (37, 52, 4), (37, 54, 1), (37, 58, 0), (37, 63, 0), (37, 76, 3), (37, 104, 1), (37, 110, 2), (37, 112, 4), (37, 114, 1), (37, 129, 1), (37, 136, 3), (37, 139, 1), (37, 147, 4), (37, 149, 1), (37, 162, 4), (37, 172, 4), (37, 173, 0), (37, 176, 3), (37, 187, 4), (37, 213, 0), (37, 214, 1), (37, 223, 0), (37, 225, 2), (37, 256, 3), (37, 261, 3), (37, 267, 4), (37, 273, 0), (38, 7, 0), (38, 32, 0), (38, 64, 2), (38, 65, 3), (38, 81, 4), (38, 85, 3), (38, 128, 1), (38, 139, 2), (38, 157, 0), (38, 211, 4), (38, 253, 1), (38, 257, 0), (38, 260, 3), (38, 271, 4), (39, 43, 2), (39, 45, 4), (39, 62, 1), (39, 78, 2), (39, 98, 2), (39, 106, 0), (39, 116, 0), (39, 124, 3), (39, 147, 1), (39, 180, 4), (39, 220, 4), (39, 222, 1), (39, 236, 0), (39, 240, 4), (39, 275, 4), (39, 276, 0), (40, 26, 1), (40, 32, 2), (40, 38, 3), (40, 70, 0), (40, 79, 4), (40, 85, 0), (40, 98, 3), (40, 114, 4), (40, 126, 1), (40, 138, 3), (40, 145, 0), (40, 148, 3), (40, 150, 0), (40, 152, 2), (40, 157, 2), (40, 163, 3), (40, 174, 4), (40, 179, 4), (40, 192, 2), (40, 196, 1), (40, 204, 4), (40, 222, 2), (40, 227, 2), (40, 239, 4), (40, 258, 3), (40, 259, 4), (40, 266, 1), (40, 274, 4), (40, 276, 1);

INSERT INTO `Teaches` VALUES (60, 1), (45, 2), (52, 3), (45, 4), (60, 5), (53, 6), (42, 7), (51, 8), (53, 9), (56, 10), (57, 11), (44, 12), (59, 13), (56, 14), (54, 15), (51, 16), (46, 17), (47, 18), (50, 19), (54, 20), (55, 21), (55, 22), (49, 23), (52, 24), (58, 25), (45, 26), (54, 27), (51, 28), (51, 29), (57, 30), (53, 31), (58, 32), (41, 33), (49, 34), (50, 35), (44, 36), (50, 37), (56, 38), (52, 39), (44, 40), (50, 41), (41, 42), (50, 43), (57, 44), (51, 45), (41, 46), (43, 47), (58, 48), (43, 49), (57, 50), (60, 51), (56, 52), (57, 53), (41, 54), (41, 55), (44, 56), (58, 57), (55, 58), (44, 59), (42, 60), (52, 61), (42, 62), (41, 63), (44, 64), (60, 65), (59, 66), (45, 67), (50, 68), (53, 69), (59, 70), (49, 71), (52, 72), (49, 73), (54, 74), (41, 75), (47, 76), (47, 77), (44, 78), (54, 79), (59, 80), (55, 81), (41, 82), (54, 83), (45, 84), (55, 85), (47, 86), (58, 87), (52, 88), (53, 89), (54, 90), (50, 91), (47, 92), (42, 93), (42, 94), (55, 95), (50, 96), (53, 97), (58, 98), (54, 99), (59, 100), (41, 101), (48, 102), (44, 103), (52, 104), (49, 105), (41, 106), (55, 107), (48, 108), (58, 109), (57, 110), (43, 111), (42, 112), (56, 113), (50, 114), (44, 115), (52, 116), (58, 117), (59, 118), (46, 119), (46, 120), (58, 121), (50, 122), (49, 123), (46, 124), (47, 125), (47, 126), (50, 127), (51, 128), (41, 129), (44, 130), (48, 131), (57, 132), (47, 133), (53, 134), (58, 135), (50, 136), (48, 137), (50, 138), (47, 139), (42, 140), (57, 141), (42, 142), (56, 143), (45, 144), (46, 145), (51, 146), (60, 147), (43, 148), (58, 149), (51, 150), (44, 151), (50, 152), (48, 153), (53, 154), (55, 155), (53, 156), (46, 157), (57, 158), (55, 159), (56, 160), (47, 161), (59, 162), (49, 163), (52, 164), (51, 165), (43, 166), (48, 167), (41, 168), (43, 169), (56, 170), (42, 171), (53, 172), (46, 173), (41, 174), (56, 175), (47, 176), (60, 177), (55, 178), (45, 179), (58, 180), (58, 181), (47, 182), (48, 183), (43, 184), (59, 185), (41, 186), (44, 187), (55, 188), (48, 189), (41, 190), (49, 191), (55, 192), (50, 193), (59, 194), (45, 195), (60, 196), (50, 197), (46, 198), (51, 199), (44, 200), (47, 201), (59, 202), (48, 203), (49, 204), (45, 205), (41, 206), (58, 207), (44, 208), (51, 209), (50, 210), (52, 211), (56, 212), (51, 213), (41, 214), (45, 215), (57, 216), (48, 217), (46, 218), (49, 219), (48, 220), (52, 221), (60, 222), (42, 223), (56, 224), (60, 225), (55, 226), (46, 227), (60, 228), (47, 229), (57, 230), (51, 231), (58, 232), (55, 233), (57, 234), (55, 235), (55, 236), (56, 237), (57, 238), (60, 239), (60, 240), (50, 241), (56, 242), (41, 243), (42, 244), (50, 245), (51, 246), (47, 247), (41, 248), (59, 249), (51, 250), (50, 251), (42, 252), (41, 253), (54, 254), (50, 255), (50, 256), (47, 257), (49, 258), (59, 259), (57, 260), (48, 261), (47, 262), (48, 263), (55, 264), (47, 265), (44, 266), (50, 267), (43, 268), (55, 269), (43, 270), (44, 271), (55, 272), (55, 273), (42, 274), (59, 275), (60, 276), (53, 277), (53, 278), (56, 279), (58, 280), (55, 281), (44, 282), (50, 283), (42, 284), (44, 285), (47, 286), (44, 287), (58, 288), (58, 289), (47, 290), (55, 291), (42, 292);

#number of terms
select count(*) From Term;

#number of times a course has been offered per term
SELECT courseId 'id', title, count(*)
From Section 
join Term t on termId = t.id
join Course c on courseId = c.id
Group by id, termId
ORDER BY id;

#courses taught in every term
Select distinct CpT.courseId 'id', CpT.title
FROM Section s join (SELECT courseId, title, count(*) 'cnt'
      FROM (SELECT courseId, title, count(*)
            From Section
            join Term t on termId = t.id
            join Course c on courseId = c.id
            Group by courseId, termId
            ORDER BY courseId) Cp
      Group by courseId) CpT on s.courseId = CpT.courseId && cnt = (select count(*) From Term);


# course id in each department
SELECT d.id, c.id
FROM Department d
JOIN Course c ON deptId = d.id
ORDER BY d.id, c.id;


#term count for each course
SELECT c.id, (Select count(Distinct termId) 
FROM Section
where courseId = c.id
Group BY courseId) SCount
From Course c
Order BY c.id;

#courses not offered frequently
SELECT deptId, c.id, (Select count(Distinct termId) 
FROM Section
where courseId = c.id
Group BY courseId) SCount
From Course c
Having SCount < 5;

#departments with courses not offered frequently
SELECT deptId 
From Course c
Having (Select count(Distinct termId) 
FROM Section
where courseId = c.id
Group BY courseId) < 5;

#departments with courses offered frequently
SELECT id
FROM Department d
WHERE NOT EXISTS (SELECT deptId 
From Course c
WHERE d.id = deptId
Having (Select count(Distinct termId) 
FROM Section
where courseId = c.id
Group BY courseId) < 5)
ORDER BY id;

#avg grade for a section
Select sectionId, avg(grade) 
FROM Takes
GROUP BY sectionId
ORDER BY sectionId;

#avg grade for all deptartments each term
SELECT t.id, d.id, avg(grade)'avg'
FROM Term t 
JOIN Section s ON termId = t.id
JOIN Takes ON sectionId = s.id
JOIN Course c ON courseId = c.id
JOIN Department d ON deptId = d.id
GROUP BY termId, deptId;

#term id and avg grade from dept with highest avg grade per term
SELECT Term.id 'term', max(avg) 'avg'
FROM Term JOIN (SELECT t.id, avg(grade) avg
FROM Term t 
JOIN Section s ON termId = t.id
JOIN Takes ON sectionId = s.id
JOIN Course c ON courseId = c.id
JOIN Department d ON deptId = d.id
GROUP BY termId, deptId) Magic ON Term.id = Magic.id
GROUP BY Term.id;

#number of times a course has been offered per term
SELECT t.id 'Term', courseId 'id', count(*)
From Section 
join Term t on termId = t.id
join Course c on courseId = c.id
Group by Term, id
ORDER BY Term, id;

#for each term the courses offered and their counts
SELECT term, GROUP_CONCAT(Courses.id, '(', count, ')' ORDER BY Courses.id SEPARATOR ', ') 'Summary'
FROM (SELECT t.id 'term', courseId 'id', count(*) 'count'
From Section 
join Term t on termId = t.id
join Course c on courseId = c.id
Group by Term, id) Courses
Group BY term;