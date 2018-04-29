DROP DATABASE IF EXISTS Quadratic1;
CREATE DATABASE Quadratic1;
USE Quadratic1;

CREATE TABLE `Quadratic` (
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  PRIMARY KEY (`a`,`b`,`c`)
);

INSERT INTO `Quadratic` VALUES 
   (-17,-18,17),
   (-17,6,-5),
   (-16,8,5),
   (-14,-2,-5),
   (-13,-9,-19),
   (-12,-3,19),
   (-10,-3,-2),
   (-6,-13,10),
   (-5,-3,10),
   (-2,-10,9),
   (-2,4,13),
   (1, -6, 9),
   (1,2,3),
   (1,11,0),
   (2,-6,20);
   
ALTER TABLE Quadratic ADD discriminant FLOAT(11);
UPDATE Quadratic SET discriminant = (b*b)-(4*a*c);

ALTER TABLE Quadratic 
ADD greaterRoot FLOAT(11),
ADD lesserRoot FLOAT(11);

UPDATE Quadratic 
SET greaterRoot = ((-b)+sqrt(discriminant))/(2*a),
lesserRoot = IF(greaterRoot = ((-b)-sqrt(discriminant))/(2*a), NULL, ((-b)-sqrt(discriminant))/(2*a));

