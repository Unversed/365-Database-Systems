DROP DATABASE IF EXISTS Courses2M2Study;
CREATE DATABASE Courses2M2Study;
USE Courses2M2Study;

/* Schema */

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
   PRIMARY KEY (`teacherId`,`sectionId`),
   CONSTRAINT `FKTeaches_teacherId` FOREIGN KEY (`teacherId`)
      REFERENCES `Teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKTeaches_sectionId` FOREIGN KEY (`sectionId`)
      REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Takes` (
   `studentId` INT(11) NOT NULL,
   `sectionId` INT(11) NOT NULL,
   PRIMARY KEY (`studentId`,`sectionId`),
   CONSTRAINT `FKTakes_studentId` FOREIGN KEY (`studentId`)
      REFERENCES `Student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKTakes_sectionId` FOREIGN KEY (`sectionId`) 
      REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Dataset */

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
   (1, 5, 38), (2, 4, 144), (3, 2, 163), (4, 2, 217), (5, 3, 19), (6, 3, 215), (7, 1, 45), (8, 1, 199), (9, 5, 130), (10, 5, 168), 
   (11, 5, 25), (12, 5, 188), (13, 4, 95), (14, 3, 33), (15, 2, 159), (16, 1, 71), (17, 3, 20), (18, 5, 65), (19, 3, 163), (20, 2, 106), 
   (21, 5, 188), (22, 1, 154), (23, 4, 178), (24, 1, 63), (25, 1, 118), (26, 1, 96), (27, 3, 30), (28, 3, 59), (29, 4, 189), (30, 3, 162), 
   (31, 5, 140), (32, 5, 178), (33, 5, 137), (34, 5, 201), (35, 1, 148), (36, 1, 98), (37, 1, 22), (38, 1, 182), (39, 1, 7), (40, 5, 100);

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
   (1, 'Calculus', 127, 5, 5, 46),
   (2, 'Data Structures', 450, 3, 1, 48),
   (3, 'Shakespeare', 418, 5, 4, 43),
   (4, 'Humanities', 118, 7, 5, 47),
   (5, 'Oh, The Humanity!', 189, 3, 5, 48),
   (6, 'Calculus II', 280, 7, 4, 48),
   (7, 'Java Programming', 483, 3, 3, 44),
   (8, 'C Programming', 432, 5, 3, 43),
   (9, 'Systems Programming', 114, 4, 2, 46),
   (10, 'Food Packaging', 376, 7, 2, 48),
   (11, 'Nutrition', 110, 4, 4, 44),
   (12, 'Ancient Greek Lit', 350, 7, 3, 42),
   (13, 'Chemistry', 489, 6, 2, 42),
   (14, 'Physics A: Knmtcs', 409, 4, 1, 44),
   (15, 'Physics B: Waves', 155, 2, 5, 49),
   (16, 'Physics C: Elec', 386, 4, 4, 49),
   (17, 'Kinesiology', 350, 7, 2, 50),
   (18, 'Biology', 341, 2, 1, 43),
   (19, 'Astronomy', 249, 2, 5, 41),
   (20, 'Astrology', 353, 7, 4, 41),
   (21, 'Game Development', 173, 5, 3, 42);

INSERT INTO `Term` VALUES
   (1, 'W11', '2011-1-15', '2011-4-1'),
   (2, 'S11', '2011-4-15', '2011-7-1'),
   (3, 'F11', '2011-9-1', '2011-11-15'),
   (4, 'W12', '2012-1-15', '2012-4-1'),
   (5, 'S12', '2012-4-15', '2012-7-1'),
   (6, 'F12', '2012-9-1', '2012-11-15'),
   (7, 'W13', '2013-1-15', '2013-4-1'),
   (8, 'S13', '2013-4-15', '2013-7-1'),
   (9, 'F13', '2013-9-1', '2013-11-15');

INSERT INTO `Section` VALUES
   (1, 1, 1), (2, 1, 1), (3, 1, 1), (4, 1, 1), (5, 3, 1), (6, 3, 1), (7, 5, 1), (8, 5, 1), (9, 5, 1), (10, 5, 1), (11, 6, 1), (12, 6, 1), (13, 8, 1), 
   (14, 8, 1), (15, 9, 1), (16, 9, 1), (17, 10, 1), (18, 10, 1), (19, 10, 1), (20, 11, 1), (21, 11, 1), (22, 11, 1), (23, 13, 1), (24, 13, 1), (25, 13, 1), 
   (26, 13, 1), (27, 14, 1), (28, 14, 1), (29, 14, 1), (30, 15, 1), (31, 15, 1), (32, 15, 1), (33, 16, 1), (34, 16, 1), (35, 18, 1), (36, 19, 1), 
   (37, 20, 1), (38, 20, 1), (39, 1, 2), (40, 1, 2), (41, 1, 2), (42, 2, 2), (43, 2, 2), (44, 2, 2), (45, 3, 2), (46, 4, 2), (47, 4, 2), (48, 5, 2), 
   (49, 5, 2), (50, 5, 2), (51, 5, 2), (52, 7, 2), (53, 7, 2), (54, 8, 2), (55, 8, 2), (56, 9, 2), (57, 9, 2), (58, 10, 2), (59, 10, 2), (60, 10, 2), 
   (61, 11, 2), (62, 11, 2), (63, 12, 2), (64, 12, 2), (65, 12, 2), (66, 12, 2), (67, 14, 2), (68, 15, 2), (69, 17, 2), (70, 18, 2), (71, 18, 2), 
   (72, 18, 2), (73, 19, 2), (74, 19, 2), (75, 1, 3), (76, 3, 3), (77, 4, 3), (78, 4, 3), (79, 4, 3), (80, 5, 3), (81, 5, 3), (82, 8, 3), (83, 8, 3), 
   (84, 8, 3), (85, 8, 3), (86, 10, 3), (87, 10, 3), (88, 10, 3), (89, 11, 3), (90, 11, 3), (91, 11, 3), (92, 11, 3), (93, 12, 3), (94, 12, 3), 
   (95, 12, 3), (96, 13, 3), (97, 13, 3), (98, 13, 3), (99, 17, 3), (100, 17, 3), (101, 17, 3), (102, 17, 3), (103, 18, 3), (104, 18, 3), (105, 18, 3), 
   (106, 1, 4), (107, 1, 4), (108, 5, 4), (109, 5, 4), (110, 5, 4), (111, 5, 4), (112, 6, 4), (113, 6, 4), (114, 6, 4), (115, 6, 4), (116, 8, 4), 
   (117, 9, 4), (118, 9, 4), (119, 10, 4), (120, 10, 4), (121, 10, 4), (122, 10, 4), (123, 11, 4), (124, 12, 4), (125, 12, 4), (126, 13, 4), (127, 14, 4), 
   (128, 14, 4), (129, 14, 4), (130, 16, 4), (131, 17, 4), (132, 19, 4), (133, 19, 4), (134, 20, 4), (135, 20, 4), (136, 20, 4), (137, 20, 4), (138, 1, 5), 
   (139, 1, 5), (140, 1, 5), (141, 3, 5), (142, 3, 5), (143, 5, 5), (144, 5, 5), (145, 5, 5), (146, 7, 5), (147, 7, 5), (148, 7, 5), (149, 7, 5), 
   (150, 8, 5), (151, 8, 5), (152, 9, 5), (153, 9, 5), (154, 10, 5), (155, 10, 5), (156, 11, 5), (157, 15, 5), (158, 15, 5), (159, 15, 5), (160, 16, 5), 
   (161, 17, 5), (162, 17, 5), (163, 18, 5), (164, 18, 5), (165, 18, 5), (166, 18, 5), (167, 19, 5), (168, 19, 5), (169, 19, 5), (170, 20, 5), (171, 20, 5), 
   (172, 20, 5), (173, 20, 5), (174, 2, 6), (175, 4, 6), (176, 4, 6), (177, 5, 6), (178, 7, 6), (179, 7, 6), (180, 7, 6), (181, 8, 6), (182, 9, 6), 
   (183, 9, 6), (184, 9, 6), (185, 9, 6), (186, 10, 6), (187, 10, 6), (188, 10, 6), (189, 10, 6), (190, 13, 6), (191, 13, 6), (192, 13, 6), (193, 14, 6), 
   (194, 16, 6), (195, 16, 6), (196, 17, 6), (197, 17, 6), (198, 17, 6), (199, 17, 6), (200, 18, 6), (201, 18, 6), (202, 18, 6), (203, 18, 6), (204, 1, 7), 
   (205, 1, 7), (206, 1, 7), (207, 1, 7), (208, 2, 7), (209, 3, 7), (210, 7, 7), (211, 8, 7), (212, 8, 7), (213, 11, 7), (214, 12, 7), (215, 12, 7), 
   (216, 12, 7), (217, 13, 7), (218, 14, 7), (219, 14, 7), (220, 15, 7), (221, 15, 7), (222, 15, 7), (223, 15, 7), (224, 16, 7), (225, 17, 7), (226, 18, 7), 
   (227, 19, 7), (228, 1, 8), (229, 1, 8), (230, 1, 8), (231, 3, 8), (232, 3, 8), (233, 3, 8), (234, 6, 8), (235, 6, 8), (236, 7, 8), (237, 7, 8), 
   (238, 7, 8), (239, 7, 8), (240, 9, 8), (241, 9, 8), (242, 9, 8), (243, 9, 8), (244, 10, 8), (245, 10, 8), (246, 12, 8), (247, 13, 8), (248, 14, 8), 
   (249, 14, 8), (250, 15, 8), (251, 15, 8), (252, 15, 8), (253, 16, 8), (254, 16, 8), (255, 18, 8), (256, 18, 8), (257, 18, 8), (258, 19, 8), (259, 19, 8), 
   (260, 19, 8), (261, 20, 8), (262, 20, 8), (263, 20, 8), (264, 1, 9), (265, 2, 9), (266, 2, 9), (267, 2, 9), (268, 2, 9), (269, 3, 9), (270, 4, 9), 
   (271, 4, 9), (272, 5, 9), (273, 5, 9), (274, 7, 9), (275, 10, 9), (276, 10, 9), (277, 10, 9), (278, 12, 9), (279, 12, 9), (280, 15, 9), (281, 15, 9), 
   (282, 15, 9), (283, 17, 9), (284, 17, 9), (285, 17, 9), (286, 17, 9), (287, 18, 9), (288, 18, 9), (289, 18, 9), (290, 20, 9), (291, 20, 9), (292, 20, 9), 
   (293, 20, 9);

INSERT INTO `Teaches` VALUES
   (60, 1), (45, 2), (52, 3), (45, 4), (60, 5), (53, 6), (42, 7), (51, 8), (53, 9), (56, 10), (57, 11), (44, 12), (59, 13), (56, 14), (54, 15), 
   (51, 16), (46, 17), (47, 18), (50, 19), (54, 20), (55, 21), (55, 22), (49, 23), (52, 24), (58, 25), (45, 26), (54, 27), (51, 28), (51, 29), (57, 30), 
   (53, 31), (58, 32), (41, 33), (49, 34), (50, 35), (44, 36), (50, 37), (56, 38), (52, 39), (44, 40), (50, 41), (41, 42), (50, 43), (57, 44), (51, 45), 
   (41, 46), (43, 47), (58, 48), (43, 49), (57, 50), (60, 51), (56, 52), (57, 53), (41, 54), (41, 55), (44, 56), (58, 57), (55, 58), (44, 59), (42, 60), 
   (52, 61), (42, 62), (41, 63), (44, 64), (60, 65), (59, 66), (45, 67), (50, 68), (53, 69), (59, 70), (49, 71), (52, 72), (49, 73), (54, 74), (41, 75), 
   (47, 76), (47, 77), (44, 78), (54, 79), (59, 80), (55, 81), (41, 82), (54, 83), (45, 84), (55, 85), (47, 86), (58, 87), (52, 88), (53, 89), (54, 90), 
   (50, 91), (47, 92), (42, 93), (42, 94), (55, 95), (50, 96), (53, 97), (58, 98), (54, 99), (59, 100), (41, 101), (48, 102), (44, 103), (52, 104), 
   (49, 105), (41, 106), (55, 107), (48, 108), (58, 109), (57, 110), (43, 111), (42, 112), (56, 113), (50, 114), (44, 115), (52, 116), (58, 117), 
   (59, 118), (46, 119), (46, 120), (58, 121), (50, 122), (49, 123), (46, 124), (47, 125), (47, 126), (50, 127), (51, 128), (41, 129), (44, 130), 
   (48, 131), (57, 132), (47, 133), (53, 134), (58, 135), (50, 136), (48, 137), (50, 138), (47, 139), (42, 140), (57, 141), (42, 142), (56, 143), 
   (45, 144), (46, 145), (51, 146), (60, 147), (43, 148), (58, 149), (51, 150), (44, 151), (50, 152), (48, 153), (53, 154), (55, 155), (53, 156), 
   (46, 157), (57, 158), (55, 159), (56, 160), (47, 161), (59, 162), (49, 163), (52, 164), (51, 165), (43, 166), (48, 167), (41, 168), (43, 169), 
   (56, 170), (42, 171), (53, 172), (46, 173), (41, 174), (56, 175), (47, 176), (60, 177), (55, 178), (45, 179), (58, 180), (58, 181), (47, 182), 
   (48, 183), (43, 184), (59, 185), (41, 186), (44, 187), (55, 188), (48, 189), (41, 190), (49, 191), (55, 192), (50, 193), (59, 194), (45, 195), 
   (60, 196), (50, 197), (46, 198), (51, 199), (44, 200), (47, 201), (59, 202), (48, 203), (49, 204), (45, 205), (41, 206), (58, 207), (44, 208), 
   (51, 209), (50, 210), (52, 211), (56, 212), (51, 213), (41, 214), (45, 215), (57, 216), (48, 217), (46, 218), (49, 219), (48, 220), (52, 221), 
   (60, 222), (42, 223), (56, 224), (60, 225), (55, 226), (46, 227), (60, 228), (47, 229), (57, 230), (51, 231), (58, 232), (55, 233), (57, 234), 
   (55, 235), (55, 236), (56, 237), (57, 238), (60, 239), (60, 240), (50, 241), (56, 242), (41, 243), (42, 244), (50, 245), (51, 246), (47, 247), 
   (41, 248), (59, 249), (51, 250), (50, 251), (42, 252), (41, 253), (54, 254), (50, 255), (50, 256), (47, 257), (49, 258), (59, 259), (57, 260), 
   (48, 261), (47, 262), (48, 263), (55, 264), (47, 265), (44, 266), (50, 267), (43, 268), (55, 269), (43, 270), (44, 271), (55, 272), (55, 273), 
   (42, 274), (59, 275), (60, 276), (53, 277), (53, 278), (56, 279), (58, 280), (55, 281), (44, 282), (50, 283), (42, 284), (44, 285), (47, 286), 
   (44, 287), (58, 288), (58, 289), (47, 290), (55, 291), (42, 292);

INSERT INTO `Takes` VALUES
   (5, 1), (12, 1), (30, 1), (29, 3), (35, 3), (2, 3), (14, 4), (17, 4), (1, 4), (24, 4), (13, 4), (24, 5), (16, 5), (14, 5), (17, 5), (12, 5), 
   (13, 6), (22, 6), (38, 7), (5, 7), (22, 7), (18, 8), (6, 8), (33, 8), (14, 10), (5, 12), (24, 12), (14, 12), (13, 12), (7, 12), (6, 13), (23, 13), 
   (2, 13), (29, 14), (35, 14), (1, 14), (28, 14), (8, 14), (24, 15), (7, 16), (35, 17), (10, 17), (34, 17), (4, 18), (30, 18), (27, 18), (29, 18), 
   (11, 19), (32, 19), (28, 19), (20, 19), (29, 19), (8, 20), (24, 21), (17, 21), (30, 21), (2, 21), (7, 21), (37, 21), (31, 23), (18, 23), (25, 24), 
   (27, 24), (6, 25), (9, 25), (30, 25), (26, 25), (36, 25), (28, 26), (29, 26), (40, 26), (10, 26), (33, 26), (13, 26), (17, 27), (37, 27), (19, 28), 
   (32, 28), (19, 29), (25, 29), (31, 30), (20, 31), (35, 32), (2, 32), (40, 32), (38, 32), (18, 32), (27, 32), (31, 33), (7, 33), (30, 33), (21, 33), 
   (15, 33), (33, 34), (36, 34), (13, 34), (10, 35), (3, 35), (28, 35), (21, 35), (10, 36), (8, 36), (12, 37), (27, 37), (37, 37), (3, 37), (20, 37), 
   (1, 37), (32, 38), (40, 38), (28, 39), (4, 39), (23, 39), (29, 40), (5, 40), (18, 40), (35, 40), (39, 43), (28, 43), (20, 43), (19, 44), (2, 45), 
   (34, 45), (20, 45), (39, 45), (6, 46), (31, 46), (12, 47), (14, 47), (25, 47), (5, 47), (9, 48), (8, 48), (8, 49), (30, 49), (21, 49), (12, 49), 
   (34, 49), (19, 49), (23, 51), (37, 52), (19, 52), (29, 52), (11, 52), (1, 53), (12, 53), (36, 53), (8, 53), (7, 54), (19, 54), (6, 54), (37, 54), 
   (20, 55), (22, 55), (18, 55), (24, 55), (7, 55), (30, 56), (25, 57), (29, 57), (9, 57), (32, 57), (4, 57), (36, 57), (10, 58), (37, 58), (17, 59), 
   (24, 59), (20, 60), (28, 61), (1, 61), (11, 61), (32, 61), (12, 61), (39, 62), (2, 62), (37, 63), (27, 63), (38, 64), (33, 64), (27, 64), (38, 65), 
   (29, 65), (24, 66), (22, 66), (7, 67), (28, 67), (18, 68), (13, 68), (1, 68), (25, 68), (27, 69), (6, 69), (20, 69), (34, 69), (26, 69), (35, 69), 
   (32, 70), (33, 70), (15, 70), (40, 70), (31, 71), (29, 71), (22, 71), (8, 71), (11, 71), (34, 71), (12, 72), (2, 72), (13, 72), (16, 72), (26, 72), 
   (5, 73), (12, 73), (19, 75), (31, 75), (10, 76), (3, 76), (26, 76), (1, 76), (37, 76), (4, 77), (39, 78), (27, 78), (13, 78), (8, 79), (40, 79), 
   (29, 80), (9, 80), (27, 80), (2, 81), (38, 81), (15, 82), (8, 83), (34, 83), (26, 83), (32, 83), (32, 84), (5, 84), (1, 84), (26, 84), (8, 84), 
   (10, 84), (33, 85), (38, 85), (40, 85), (19, 86), (24, 86), (36, 86), (13, 88), (12, 89), (5, 89), (28, 89), (17, 89), (18, 89), (15, 90), (32, 91), 
   (36, 91), (14, 91), (20, 91), (11, 91), (28, 94), (34, 94), (25, 94), (4, 94), (24, 94), (9, 94), (26, 96), (32, 96), (24, 96), (23, 96), (5, 96), 
   (17, 97), (34, 97), (36, 98), (35, 98), (20, 98), (40, 98), (39, 98), (32, 99), (11, 99), (9, 99), (35, 101), (2, 102), (15, 102), (21, 103), 
   (10, 104), (14, 104), (20, 104), (37, 104), (2, 105), (6, 105), (19, 105), (39, 106), (35, 106), (1, 106), (28, 106), (4, 106), (10, 107), (14, 107), 
   (34, 107), (17, 109), (16, 109), (31, 109), (33, 109), (30, 109), (37, 110), (36, 111), (34, 111), (25, 111), (1, 112), (14, 112), (37, 112), 
   (28, 112), (15, 113), (16, 113), (26, 114), (34, 114), (37, 114), (40, 114), (32, 116), (28, 116), (39, 116), (1, 116), (31, 117), (7, 117), 
   (18, 120), (8, 120), (31, 120), (17, 120), (24, 121), (2, 122), (35, 122), (34, 122), (12, 123), (11, 123), (6, 123), (33, 123), (1, 123), (10, 123), 
   (39, 124), (23, 124), (36, 125), (28, 125), (14, 125), (13, 125), (29, 125), (33, 125), (4, 126), (32, 126), (30, 126), (40, 126), (23, 126), 
   (18, 127), (16, 127), (9, 127), (11, 127), (26, 127), (17, 127), (38, 128), (35, 129), (30, 129), (37, 129), (13, 129), (7, 130), (19, 130), 
   (24, 130), (21, 130), (2, 130), (20, 130), (22, 132), (21, 132), (25, 132), (31, 132), (4, 132), (21, 133), (22, 134), (31, 134), (10, 134), 
   (17, 134), (20, 135), (32, 135), (2, 136), (37, 136), (33, 136), (23, 136), (2, 137), (34, 137), (22, 137), (3, 138), (29, 138), (26, 138), (23, 138), 
   (40, 138), (15, 138), (6, 139), (37, 139), (38, 139), (19, 139), (27, 139), (31, 139), (5, 140), (25, 140), (12, 140), (4, 140), (13, 140), (16, 140), 
   (25, 141), (28, 141), (11, 141), (34, 141), (29, 141), (10, 143), (33, 143), (22, 143), (8, 143), (8, 144), (25, 145), (23, 145), (6, 145), (4, 145), 
   (40, 145), (24, 145), (21, 146), (35, 146), (14, 147), (36, 147), (39, 147), (11, 147), (31, 147), (37, 147), (27, 148), (29, 148), (14, 148), 
   (6, 148), (40, 148), (2, 148), (12, 149), (37, 149), (34, 149), (18, 149), (30, 149), (16, 150), (40, 150), (10, 150), (36, 152), (14, 152), 
   (40, 152), (32, 152), (3, 152), (1, 152), (12, 154), (26, 154), (16, 154), (28, 154), (22, 154), (10, 154), (28, 156), (7, 156), (12, 157), (38, 157), 
   (40, 157), (36, 158), (1, 158), (15, 158), (33, 158), (7, 159), (15, 160), (6, 160), (8, 160), (1, 162), (37, 162), (16, 162), (4, 162), (33, 162), 
   (30, 163), (13, 163), (32, 163), (21, 163), (40, 163), (34, 163), (9, 164), (14, 164), (8, 164), (1, 164), (33, 164), (9, 166), (11, 166), (30, 166), 
   (29, 166), (8, 166), (4, 167), (7, 167), (1, 168), (31, 171), (7, 171), (14, 171), (24, 171), (30, 171), (16, 171), (16, 172), (14, 172), (22, 172), 
   (37, 172), (1, 172), (16, 173), (36, 173), (30, 173), (37, 173), (40, 174), (10, 174), (23, 174), (37, 176), (3, 176), (2, 176), (31, 176), (13, 176), 
   (12, 176), (24, 177), (29, 177), (8, 177), (35, 177), (6, 178), (17, 178), (1, 179), (34, 179), (40, 179), (30, 179), (9, 179), (10, 179), (39, 180), 
   (4, 180), (27, 180), (16, 180), (11, 180), (25, 181), (31, 181), (12, 182), (7, 183), (1, 183), (22, 184), (2, 184), (4, 184), (3, 184), (1, 184), 
   (16, 185), (37, 187), (21, 187), (29, 188), (6, 188), (15, 188), (19, 188), (35, 188), (16, 188), (13, 189), (32, 189), (19, 189), (18, 189), 
   (33, 190), (23, 190), (26, 190), (7, 190), (28, 191), (24, 191), (16, 192), (17, 192), (31, 192), (40, 192), (35, 192), (9, 192), (16, 194), 
   (3, 194), (18, 195), (7, 195), (21, 195), (17, 195), (8, 195), (40, 196), (35, 196), (1, 196), (6, 198), (8, 199), (14, 199), (34, 200), (11, 200), 
   (36, 200), (16, 200), (4, 200), (9, 200), (29, 202), (36, 202), (13, 202), (19, 202), (4, 202), (26, 203), (40, 204), (8, 204), (35, 205), (20, 207), 
   (11, 207), (16, 207), (17, 207), (26, 208), (15, 208), (38, 211), (28, 211), (27, 211), (9, 212), (23, 212), (6, 212), (4, 212), (3, 212), (34, 213), 
   (33, 213), (37, 213), (37, 214), (20, 214), (24, 214), (3, 214), (19, 214), (25, 214), (16, 215), (13, 215), (10, 215), (15, 215), (36, 216), 
   (4, 216), (18, 216), (26, 216), (19, 216), (29, 217), (23, 217), (32, 217), (28, 217), (27, 217), (5, 217), (33, 218), (7, 218), (3, 218), (11, 218), 
   (34, 218), (9, 219), (14, 220), (8, 220), (39, 220), (33, 220), (32, 220), (27, 220), (39, 222), (5, 222), (7, 222), (9, 222), (40, 222), (3, 222), 
   (23, 223), (37, 223), (20, 223), (6, 223), (28, 223), (28, 224), (37, 225), (21, 226), (4, 227), (13, 227), (40, 227), (20, 230), (9, 231), (22, 231), 
   (30, 231), (36, 231), (31, 231), (25, 232), (15, 232), (5, 233), (14, 233), (20, 233), (13, 233), (8, 234), (6, 234), (4, 234), (15, 235), (3, 235), 
   (27, 235), (26, 236), (39, 236), (22, 236), (7, 238), (35, 238), (30, 238), (8, 239), (28, 239), (3, 239), (4, 239), (31, 239), (40, 239), (35, 240), 
   (39, 240), (17, 240), (6, 240), (1, 240), (36, 240), (19, 241), (34, 242), (9, 243), (4, 243), (23, 243), (11, 243), (26, 244), (20, 244), (7, 244), 
   (28, 244), (9, 244), (7, 246), (12, 248), (16, 248), (13, 249), (2, 249), (20, 249), (1, 251), (25, 252), (35, 252), (38, 253), (34, 253), (13, 253), 
   (24, 254), (36, 255), (11, 255), (24, 255), (30, 255), (10, 255), (34, 256), (26, 256), (31, 256), (37, 256), (19, 257), (23, 257), (33, 257), 
   (8, 257), (38, 257), (4, 257), (25, 258), (14, 258), (40, 258), (21, 259), (40, 259), (3, 260), (38, 260), (25, 260), (26, 260), (29, 261), (37, 261), 
   (11, 261), (8, 261), (4, 261), (34, 261), (24, 262), (30, 262), (13, 264), (10, 264), (34, 264), (7, 264), (6, 264), (9, 264), (6, 265), (1, 265), 
   (10, 265), (36, 265), (33, 265), (15, 266), (40, 266), (12, 266), (35, 267), (16, 267), (34, 267), (37, 267), (3, 268), (30, 268), (4, 269), 
   (29, 269), (16, 269), (7, 269), (15, 270), (9, 271), (32, 271), (38, 271), (1, 271), (26, 272), (22, 273), (33, 273), (19, 273), (6, 273), (37, 273), 
   (29, 273), (16, 274), (12, 274), (40, 274), (20, 274), (3, 274), (5, 274), (34, 275), (39, 275), (18, 275), (4, 275), (39, 276), (40, 276), (18, 276), 
   (34, 276), (7, 277), (23, 277), (25, 277), (15, 277), (31, 277), (35, 280), (24, 280), (13, 280), (33, 281), (34, 281), (24, 282), (6, 282), 
   (36, 282), (17, 283), (22, 283), (32, 283), (19, 284), (27, 284), (31, 287), (16, 287);
   

/*List all students ever enrolled in any section
taught by a teacher named Rogelio Simpson, 
which teacher is in a dept named just 'Sciences'.
*/

SELECT DISTINCT Stdnt.lastName, Stdnt.firstName, Student.id
FROM Person Teachr, Teacher, Department, Teaches, Person Stdnt, Student, Takes, Section S1, Section S2
WHERE Teachr.id = Teacher.id
&& Teachr.firstName = 'Rogelio' 
&& Teachr.lastName = 'Simpson'
&& Teacher.deptId = Department.id
&& Department.name = 'Sciences'
&& teacherId = Teacher.id
&& Teaches.sectionId = S1.id
&& Stdnt.id = Student.id
&& Student.id = studentId
&& Takes.sectionId = S2.id
&& S1.id = S2.id
ORDER BY Student.id;


#List any students who have taken a course outside their major.

   SELECT DISTINCT firstName, lastName 
   FROM Person, Student, Takes, Section, Course 
   WHERE Student.id = Person.id
   && studentId = Student.id 
   && sectionId = Section.id 
   && courseId = Course.id 
   && Course.deptId <> Student.majorId
   ORDER BY lastName, firstName;


#List teachers who have taught a course outside there department

SELECT DISTINCT c1.id AS 'Course ID', lastName AS 'Last Name'
FROM Person p 
join Teacher t on p.id = t.id 
join Teaches Te on t.id = teacherId
join Section s1 on s1.id = sectionId
join Course c1 on c1.id = s1.courseId
join Term t1 on t.id = s1.termId
WHERE Course.deptId <> t.deptId;

#List teachers whom have taught the same course outside of his/her department, 
#during at least two different terms.  

SELECT DISTINCT c1.id AS 'Course ID', lastName AS 'Last Name'
FROM Person p 
join Teacher t1 on p.id = t1.id
join Teacher t2 on p.id = t2.id && t1.id = t2.id
join Department De on deptId = De.id
join Teaches te on t.id = teacherID
join Section s1 on s1.id = sectionId
join Course c1 on c1.id = s1.courseId
join Term t1 on t.id = s1.termId
join Section s2 on s2.id = sectionId
join Course c2 on c2.id = s2.courseId
join Term t2 on t2.id = s2.termId
WHERE t1.id <> t2.id
&& Teacher.deptId <> Course.deptId
ORDER BY 'Course ID', 'Last Name';

SELECT DISTINCT Course.id AS 'Course ID', lastName AS 'Last Name'
FROM Person, Teacher, Department, Teaches, Section s1, Section s2, Course
WHERE Person.id = Teacher.id
&& Teacher.deptId = Department.id
&& teacherId = Teacher.id
&& sectionId = s1.id
&& s1.courseId = s2.courseId
&& s1.termId <> s2.termId
&& s1.courseId = Course.id
&& s2.courseId = Course.id
&& Course.coordId = Teacher.id
&& Teacher.deptId <> Course.deptId
ORDER BY 'Course ID', 'Last Name';