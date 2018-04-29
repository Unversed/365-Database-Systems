DROP DATABASE IF EXISTS Student1;
CREATE DATABASE Student1;
USE Student1;

CREATE TABLE `Student` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `lastName` varchar(25) DEFAULT NULL,
   `firstName` varchar(25) DEFAULT NULL,
   `middleInitial` char(1) DEFAULT NULL,
   `essaySubmitted` timestamp NULL,
   `exam1Score` int(11) DEFAULT NULL,
   `exam2Score` int(11) DEFAULT NULL,
   PRIMARY KEY (`id`)
);

INSERT INTO `Student` VALUES 
   (1, 'Logan', 'Juliet', 'S', '2016-04-26 17:07:15', 32, NULL),   
   (2, 'Arzt', 'Terrell', 'T', '2016-04-02 18:36:10', NULL, 8),   
   (3, 'Esposita', 'Travis', 'H', '2016-04-15 20:39:04', 99, 77),   
   (4, 'Engley', 'Sixta', NULL, '2016-04-13 02:26:53', 37, 62),   
   (5, 'Dunlow', 'Travis', 'E', '2016-04-16 01:17:12', 87, 79),   
   (6, 'Slingland', 'Josette', 'I', '2016-04-11 02:05:20', 26, 10),   
   (7, 'Toussand', 'Sharron', 'J', '2016-04-05 09:35:06', NULL, NULL),   
   (8, 'Esposita', 'Rupert', 'S', '2016-04-19 20:39:27', 66, 35),   
   (9, 'Hafferkamp', 'Cuc', 'N', '2016-04-25 05:32:00', 21, 37),   
   (10, 'Dukelow', 'Coretta', NULL, '2016-04-08 16:41:40', NULL, 80);
   
SELECT lower(CONCAT(substr(firstName, 1, 1), substr(lastName, 1, 6), '@sql.edu')) AS 'email' FROM Student ORDER BY id;
#SELECT CONCAT(substr(quote(firstName), 1, 1), substr(quote(lastName), 1, 6), '@sql.edu') FROM Student ORDER BY id;
#SELECT CONCAT(ifnull(substr(TRIM(BOTH '"' FROM quote(firstName)), 1, 1),''), ifnull(substring(TRIM(BOTH '"' FROM quote(lastName)), 1, 7), ''), '@sql.edu') FROM Student ORDER BY id;

SELECT greatest(datediff(essaySubmitted, "2016-4-15"), 0) AS 'Days Late' FROM Student ORDER BY id;
SELECT (ABS(datediff(essaySubmitted, "2016-4-15"))+datediff(essaySubmitted, "2016-4-15")) DIV 2 AS 'Days Late' FROM Student ORDER BY id;


SELECT IFNULL(ABS(exam1Score-exam2Score), 'N/A') AS 'Diff' FROM Student ORDER BY id;

SELECT greatest(datediff(essaySubmitted, "2016-4-15"), 0) AS 'Days Late' FROM Student ORDER BY id;




SELECT id, IF(exam1Score IS NULL, 'N/A', IF(exam1Score >= 90, 'A',IF(exam1Score >= 80, 'B',IF(exam1Score >= 70, 'C', IF(exam1Score >= 60, 'D', 'F'))))) AS 'Grade' FROM Student ORDER BY Grade, id;



SELECT id, CONCAT(firstName, IF(middleInitial IS NOT NULL, CONCAT(' ', middleInitial, '. '), ' '), lastName) AS 'Name' FROM Student ORDER BY id;

SELECT id, essaySubmitted, CAST(LEAST(GREATEST(CEIL((TIMESTAMPDIFF(HOUR, '2016-4-15 18:00:00', essaySubmitted)/24)), 0), 10)*5 AS UNSIGNED INT) AS 'Deduction' FROM Student ORDER BY id;


SELECT TIMESTAMPDIFF(HOUR, '2016-4-15 18:00:00', essaySubmitted)/24 FROM Student ORDER BY id; 
SELECT CEIL(TIMESTAMPDIFF(HOUR, '2016-4-15 18:00:00', essaySubmitted)/24) FROM Student ORDER BY id; 
SELECT GREATEST(CEIL(TIMESTAMPDIFF(HOUR, '2016-4-15 18:00:00', essaySubmitted)/24), 0) FROM Student ORDER BY id; 
SELECT LEAST(GREATEST(CEIL(TIMESTAMPDIFF(HOUR, '2016-4-15 18:00:00', essaySubmitted)/24), 0), 10) FROM Student ORDER BY id; 