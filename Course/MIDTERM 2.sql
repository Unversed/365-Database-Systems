DROP DATABASE IF EXISTS Courses4;
CREATE DATABASE Courses4;
USE Courses4;

CREATE TABLE `Customer` (
   `id` INT(11) NOT NULL,
   `lastName` VARCHAR(30) NOT NULL,
   `firstName` VARCHAR(30) DEFAULT NULL,
   `age` INT(11) DEFAULT NULL,
   `gender` CHAR(1) DEFAULT NULL,
   `street` VARCHAR(50) DEFAULT NULL,
   `city` VARCHAR(50) DEFAULT NULL,
   `state` CHAR(2) DEFAULT NULL,
   `favorites` VARCHAR(255) DEFAULT NULL,
   `lastVisit` DATE DEFAULT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Product` (
   `id` VARCHAR(20) NOT NULL,
   `flavor` VARCHAR(30) DEFAULT NULL,
   `kind` VARCHAR(30) DEFAULT NULL,
   `price` DECIMAL(6,2),
   INDEX `INprice` (price),
   PRIMARY KEY (`id`),
   UNIQUE KEY `UKkind_flavor` (`kind`, `flavor`)
);

CREATE TABLE `Receipt` (
   `id` INT(11) PRIMARY KEY,                       
   `purchaseDate` DATE DEFAULT NULL,
   `customerId` INT(11) NOT NULL,
   CONSTRAINT `FKReceipt_customerId` FOREIGN KEY (`customerId`)
      REFERENCES `Customer` (`id`)
);

CREATE TABLE `LineItem` (
   `receiptId` INT(11) NOT NULL,
   `lineNum` INT(11) NOT NULL DEFAULT 1,
   `productId` VARCHAR(20) NOT NULL,
   PRIMARY KEY (`receiptId`, `lineNum`),
   CONSTRAINT `FKLineItem_receiptId` FOREIGN KEY (`receiptId`)
      REFERENCES `Receipt` (`id`),
   CONSTRAINT `FKLineItem_productId` FOREIGN KEY (`productId`) 
      REFERENCES `Product` (`id`)
);

CREATE TABLE `Rating` (
   `customerId` INT(11) DEFAULT NULL,
   `productId` VARCHAR(20) NOT NULL,
   `score` INT(11) DEFAULT NULL,
   `comment` VARCHAR(1024) DEFAULT NULL,
   UNIQUE KEY UKcustomerId_productId (customerId, productId),
   CONSTRAINT `FKRating_customerId` FOREIGN KEY (`customerId`) 
      REFERENCES `Customer` (`id`),
   CONSTRAINT `FKRating_productId` FOREIGN KEY (`productId`) 
      REFERENCES `Product` (`id`)
);

CREATE TABLE `Discount` (
   `id` INT(11) NOT NULL,
   `startDate` DATE DEFAULT NULL,
   `endDate` DATE DEFAULT NULL,
   `percentOff` INT(11) NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `DiscountXProduct` (
   `discountId` INT(11) NOT NULL,
   `productId` VARCHAR(20) NOT NULL,
   CONSTRAINT `FKDiscountXProduct_discountId` FOREIGN KEY (`discountId`) 
      REFERENCES `Discount` (`id`),
   CONSTRAINT `FKDiscountXProduct_productId` FOREIGN KEY (`productId`) 
      REFERENCES `Product` (`id`)
);

/* Dataset */

INSERT INTO `Customer` VALUES
   (1,'Logan','Juliet', 17, 'F', '402 Paradise Rd', 'Harrisburg', 'OR', 'Napolean, Cake', '2008-12-23'),
   (2,'Arzt','Terrell', 18, 'M', '8101 72nd Ave', 'Phoenix', 'AZ', 'Apricot, Strawberry, Cookie', '2013-11-02'),
   (3,'Esposita','Travis', 87, 'M', '1819 Monument Way', 'Walnut Creek', 'CA', 'Cheese, Strawberry, Cake', '2013-01-13'),
   (4,'Engley','Sixta', 18, 'F', '192 Lexington St', 'Fort Pierce', 'FL', 'Truffle, Eclair', '2012-01-13'),
   (5,'Dunlow','Travis', 13, 'M', '6500 Filbert Ct', 'Campbell', 'OH', 'Chocolate, Bear Claw', '2009-02-02'),
   (6,'Slingland','Josette', 14, 'F', '333 Park Ave', 'Santa Rosa', 'CA', 'Lemon, Tart', '2010-09-20'),
   (7,'Toussand','Sharron', 77, 'F', '2581 Crystal Lake Dr', 'Cedar City', 'UT', 'Lemon, Tart', '2012-07-25'),
   (8,'Esposita','Rupert', 65, 'M', '4531 Westray Dr', 'Orange', 'CA', 'Blackberry, Cookie', '2013-03-08'),
   (9,'Hafferkamp','Cuc', 46, 'F', '2832 Amerson Way', 'Bend', 'OR', 'Vanilla, Blueberry, Cake', '2013-09-18'),
   (10,'Dukelow','Coretta', 78, 'F', '314 Pecan St', 'Eugene', 'OR', 'Almond, Croissant', '2011-05-09'),
   (11,'Stadick','Migdalia', 16, 'F', '24816 20Th Ave', 'Bellevue', 'WA', 'Chocolate, Cake', '2011-05-22'),
   (12,'McMahan','Mellie', 65, 'F', '90 Creekside Dr', 'Redmond', 'WA', 'Vanilla, Strawberry Twist', '2012-10-19'),
   (13,'Arnn','Kip', 28, 'M', '1654 Pine Valley Dr', 'Hilo', 'HI', 'Casino, Danish', '2013-09-30'),
   (14,'Sopko','Rayford', 64, 'M', '148 Blackburn St', 'Rock Springs', 'WY', 'Casino, Opera, Croissant, Twist', '2012-02-24'),
   (15,'Callendar','David', 67, 'M', '27 Mildred Rd', 'Sterling', 'AK', 'Chocolate, Berry, Cake', '2012-03-01'),
   (16,'Cruzen','Ariane', 17, 'F', '700 Midland Ave', 'Fulton', 'NY', 'Pecan, Berry, Danish, Strawberry, Meringue', '2011-01-06'),
   (17,'Mesdaq','Charlene', 17, 'F', '650 Spruce St', 'Fulton', 'NY', 'Almond, Strawberry, Cookie', '2013-01-01'),
   (18,'Domkowski','Almeta', 15, 'F', '11 Philadelphia St', 'Providence', 'RI', 'Strawberry, Coffee, Cookie', '2012-12-31'),
   (19,'Stenz','Natacha', 34, 'F', '30 Bank St', 'Chico', 'CA', 'Berry, Apple, Chocolate, Pie, Tart', '2013-12-29'),
   (20,'Zeme','Stephen', 18, 'M', '3133 Maple Ct', 'Walnut Creek', 'CA', 'Lemon, Pecan, Tart, Eclair', '2012-03-04'),
   (21,'Cheap', 'Joe', 20, 'M', '123 Skinflint Dr', 'Fulton', 'CA', '', NULL);

INSERT INTO `Product` VALUES
   ('20-BC-C-10','Chocolate','Cake', 8.95),
   ('20-BC-L-10','Lemon','Cake', 8.95),
   ('20-CA-7.5','Casino','Cake', 15.95),
   ('24-8x10','Opera','Cake', 15.95),
   ('25-STR-9','Strawberry','Cake', 11.95),
   ('26-8x10','Truffle','Cake', 15.95),
   ('45-CH','Chocolate','Eclair', 3.25),
   ('45-CO','Coffee','Eclair', 3.5),
   ('45-VA','Vanilla','Eclair', 3.25),
   ('46-11','Napoleon','Cake', 13.49),
   ('90-ALM-I','Almond','Tart', 3.75),
   ('90-APIE-10','Apple','Pie', 5.25),
   ('90-APP-11','Apple','Tart', 3.25),
   ('90-APR-PF','Apricot','Tart', 3.25),
   ('90-BER-11','Berry','Tart', 3.25),
   ('90-BLK-PF','Blackberry','Tart', 3.25),
   ('90-BLU-11','Blueberry','Tart', 3.25),
   ('90-CH-PF','Chocolate','Tart', 3.75),
   ('90-CHR-11','Cherry','Tart', 3.25),
   ('90-LEM-11','Lemon','Tart', 3.25),
   ('90-PEC-11','Pecan','Tart', 3.75),
   ('70-GA','Ganache','Cookie', 1.15),
   ('70-GON','Gongolais','Cookie', 1.15),
   ('70-R','Raspberry','Cookie', 1.09),
   ('70-LEM','Lemon','Cookie', 0.79),
   ('70-M-CH-DZ','Chocolate','Meringue', 1.25),
   ('70-M-VA-SM-DZ','Vanilla','Meringue', 1.15),
   ('70-MAR','Marzipan','Cookie', 1.25),
   ('70-TU','Tuile','Cookie', 1.25),
   ('70-W','Walnut','Cookie', 0.79),
   ('50-ALM','Almond','Croissant', 1.45),
   ('50-APP','Apple','Croissant', 1.45),
   ('50-APR','Apricot','Croissant', 1.45),
   ('50-CHS','Cheese','Croissant', 1.75),
   ('50-CH','Chocolate','Croissant', 1.75),
   ('51-APR','Apricot','Danish', 1.15),
   ('51-APP','Apple','Danish', 1.15),
   ('51-ATW','Almond','Twist', 1.15),
   ('51-BC','Almond','Bear Claw', 1.95),
   ('51-BLU','Blueberry','Danish', 1.15);

INSERT INTO `Receipt` VALUES (10013,'2007-10-17',15),(11548,'2007-10-21',13),(11891,'2007-10-30',7),(11923,'2007-10-09',15),(12396,'2007-10-10',10),(12698,'2007-10-23',19),(12800,'2007-10-22',11),(13355,'2007-10-19',7),(13496,'2007-10-30',11),(15286,'2007-10-11',6),(15584,'2007-10-13',3),(15904,'2007-10-06',13),(16034,'2007-10-10',4),(16532,'2007-10-21',4),(17488,'2007-10-20',6),(17685,'2007-10-02',12),(17729,'2007-10-16',16),(17947,'2007-10-27',7),(18129,'2007-10-28',15),(18567,'2007-10-13',7),(18951,'2007-10-14',20),(19002,'2007-10-19',6),(19258,'2007-10-25',5),(20127,'2007-10-07',15),(20411,'2007-10-08',7),(20913,'2007-10-07',8),(21040,'2007-10-03',6),(21162,'2007-10-04',8),(21545,'2007-10-22',12),(21622,'2007-10-10',7),(23034,'2007-10-15',17),(24200,'2007-10-16',9),(24829,'2007-10-07',15),(25121,'2007-10-20',18),(25906,'2007-10-29',15),(26148,'2007-10-19',20),(26198,'2007-10-12',11),(26240,'2007-10-07',16),(26741,'2007-10-24',7),(27192,'2007-10-28',9),(27741,'2007-10-25',8),(28117,'2007-10-09',5),(29226,'2007-10-26',14),(29908,'2007-10-14',13),(31233,'2007-10-20',13),(31874,'2007-10-13',2),(32565,'2007-10-24',14),(32701,'2007-10-19',16),(33060,'2007-10-29',20),(33456,'2007-10-05',16),(34378,'2007-10-23',6),(34579,'2007-10-08',7),(34910,'2007-10-07',20),(35011,'2007-10-10',20),(35073,'2007-10-23',5),(35904,'2007-10-21',10),(36343,'2007-10-31',19),(36423,'2007-10-24',16),(37063,'2007-10-22',14),(37540,'2007-10-03',20),(37586,'2007-10-03',8),(37636,'2007-10-20',1),(38157,'2007-10-23',16),(38849,'2007-10-25',1),(39109,'2007-10-02',16),(39217,'2007-10-19',20),(39575,'2007-10-20',20),(39605,'2007-10-12',12),(39685,'2007-10-28',1),(39829,'2007-10-31',3),(40305,'2007-10-25',8),(41028,'2007-10-06',17),(41064,'2007-10-25',16),(41963,'2007-10-29',8),(42162,'2007-10-16',7),(42166,'2007-10-14',8),(42833,'2007-10-22',3),(43103,'2007-10-07',4),(43752,'2007-10-05',5),(44330,'2007-10-20',18),(44590,'2007-10-12',1),(44798,'2007-10-04',16),(45062,'2007-10-23',1),(45873,'2007-10-05',13),(45976,'2007-10-03',10),(46014,'2007-10-16',15),(46248,'2007-10-12',11),(46598,'2007-10-03',14),(46674,'2007-10-29',15),(46876,'2007-10-06',13),(47353,'2007-10-12',6),(48332,'2007-10-15',20),(48647,'2007-10-09',3),(48981,'2007-10-24',20),(49845,'2007-10-31',20),(49854,'2007-10-12',2),(49977,'2007-10-18',3),(50512,'2007-10-27',8),(50660,'2007-10-18',9),(51991,'2007-10-17',14),(52013,'2007-10-05',13),(52369,'2007-10-15',5),(52761,'2007-10-27',8),(53240,'2007-10-03',14),(53376,'2007-10-30',8),(53922,'2007-10-13',2),(54935,'2007-10-16',14),(55494,'2007-10-20',15),(55690,'2007-10-15',19),(55944,'2007-10-16',19),(56365,'2007-10-14',12),(56724,'2007-10-09',13),(57784,'2007-10-15',7),(58770,'2007-10-22',18),(59716,'2007-10-30',2),(59774,'2007-10-02',16),(60240,'2007-10-17',17),(60270,'2007-10-31',11),(60469,'2007-10-20',4),(61008,'2007-10-09',14),(61378,'2007-10-08',11),(61797,'2007-10-30',8),(61948,'2007-10-04',5),(62707,'2007-10-07',8),(63998,'2007-10-13',20),(64301,'2007-10-12',14),(64451,'2007-10-10',11),(64477,'2007-10-16',6),(64553,'2007-10-08',17),(64574,'2007-10-02',6),(64861,'2007-10-15',10),(65091,'2007-10-09',17),(65165,'2007-10-04',4),(66227,'2007-10-10',1),(66704,'2007-10-29',14),(67314,'2007-10-23',6),(67946,'2007-10-18',7),(68199,'2007-10-04',9),(68753,'2007-10-11',5),(68890,'2007-10-27',7),(70162,'2007-10-09',19),(70655,'2007-10-06',2),(70723,'2007-10-28',20),(70796,'2007-10-31',12),(72207,'2007-10-15',1),(72949,'2007-10-02',6),(73437,'2007-10-01',6),(73438,'2007-10-18',10),(73716,'2007-10-29',18),(74741,'2007-10-12',20),(74952,'2007-10-16',5),(75468,'2007-10-21',10),(75526,'2007-10-22',18),(76663,'2007-10-04',10),(76667,'2007-10-14',15),(76951,'2007-10-27',14),(77032,'2007-10-28',14),(77406,'2007-10-09',13),(78179,'2007-10-24',14),(78187,'2007-10-17',14),(79287,'2007-10-30',8),(79296,'2007-10-03',19),(81368,'2007-10-17',19),(81517,'2007-10-10',1),(82056,'2007-10-07',18),(82795,'2007-10-08',15),(83085,'2007-10-12',7),(83437,'2007-10-15',8),(84258,'2007-10-22',2),(84665,'2007-10-10',6),(85492,'2007-10-20',12),(85858,'2007-10-31',1),(85881,'2007-10-13',1),(86085,'2007-10-16',1),(86162,'2007-10-10',16),(86678,'2007-10-24',3),(86861,'2007-10-26',9),(87454,'2007-10-21',6),(88626,'2007-10-25',17),(89182,'2007-10-29',5),(89588,'2007-10-09',7),(89638,'2007-10-07',4),(89937,'2007-10-20',7),(91192,'2007-10-10',5),(91937,'2007-10-21',12),(92252,'2007-10-25',7),(94371,'2007-10-22',8),(95514,'2007-10-09',10),(95962,'2007-10-26',8),(96258,'2007-10-12',8),(96402,'2007-10-04',6),(96430,'2007-10-04',18),(96531,'2007-10-12',8),(96619,'2007-10-07',18),(96761,'2007-10-14',20),(97097,'2007-10-23',9),(98806,'2007-10-15',17),(99002,'2007-10-13',20),(99058,'2007-10-03',14),(99994,'2007-10-21',6);

INSERT INTO `LineItem` VALUES (18129,1,'70-TU'),(51991,1,'90-APIE-10'),(51991,2,'90-CH-PF'),(51991,3,'90-APP-11'),(51991,4,'26-8x10'),(83085,1,'25-STR-9'),(83085,2,'24-8x10'),(83085,3,'90-APR-PF'),(83085,4,'51-ATW'),(83085,5,'26-8x10'),(70723,1,'45-CO'),(13355,1,'24-8x10'),(13355,2,'70-LEM'),(13355,3,'46-11'),(52761,1,'90-ALM-I'),(52761,2,'26-8x10'),(52761,3,'50-CHS'),(52761,4,'90-BLK-PF'),(52761,5,'90-ALM-I'),(99002,1,'50-CHS'),(99002,2,'45-VA'),(58770,1,'50-CHS'),(58770,2,'46-11'),(58770,3,'45-CH'),(58770,4,'20-CA-7.5'),(84665,1,'90-BER-11'),(55944,1,'20-CA-7.5'),(55944,2,'90-LEM-11'),(55944,3,'70-R'),(55944,4,'70-R'),(55944,5,'50-CHS'),(42166,1,'70-M-VA-SM-DZ'),(16034,1,'46-11'),(16034,2,'26-8x10'),(16034,3,'45-CH'),(16034,4,'70-R'),(16034,5,'46-11'),(25906,1,'25-STR-9'),(27741,1,'90-BLK-PF'),(27741,2,'51-BC'),(27741,3,'90-APR-PF'),(64451,1,'90-BER-11'),(64451,2,'51-BC'),(64451,3,'24-8x10'),(64451,4,'90-BLK-PF'),(41028,1,'90-BER-11'),(73716,1,'90-PEC-11'),(73716,2,'90-ALM-I'),(73716,3,'70-LEM'),(73716,4,'50-CH'),(76667,1,'70-GON'),(76667,2,'90-LEM-11'),(21040,1,'70-R'),(21040,2,'20-BC-L-10'),(21040,3,'90-CH-PF'),(48332,1,'70-GA'),(48332,2,'70-R'),(35011,1,'50-CHS'),(95962,1,'90-APR-PF'),(95962,2,'90-CHR-11'),(95962,3,'50-CH'),(95962,4,'45-VA'),(44798,1,'90-APR-PF'),(44798,2,'90-CH-PF'),(44798,3,'90-APIE-10'),(44798,4,'90-APP-11'),(44798,5,'25-STR-9'),(60270,1,'20-BC-L-10'),(60270,2,'90-BLU-11'),(21162,1,'90-APP-11'),(21162,2,'70-TU'),(21162,3,'90-APR-PF'),(77406,1,'51-ATW'),(77406,2,'90-BLK-PF'),(77406,3,'50-APR'),(77406,4,'50-APR'),(77406,5,'24-8x10'),(32565,1,'50-APP'),(32565,2,'50-APP'),(32565,3,'45-VA'),(36343,1,'51-BC'),(36343,2,'51-BC'),(36343,3,'70-M-VA-SM-DZ'),(36343,4,'50-ALM'),(96619,1,'90-BLK-PF'),(86678,1,'70-M-VA-SM-DZ'),(86678,2,'90-LEM-11'),(44330,1,'70-R'),(44330,2,'90-BLU-11'),(91937,1,'51-BC'),(91937,2,'51-APR'),(21545,1,'90-BER-11'),(21545,2,'70-GA'),(21545,3,'50-ALM'),(21545,4,'90-BER-11'),(21545,5,'45-VA'),(29226,1,'90-PEC-11'),(29226,2,'90-APIE-10'),(29226,3,'51-BC'),(29226,4,'70-W'),(29226,5,'50-ALM'),(25121,1,'50-CHS'),(25121,2,'90-BER-11'),(25121,3,'45-CH'),(54935,1,'70-R'),(54935,2,'45-CH'),(36423,1,'45-VA'),(83437,1,'90-LEM-11'),(83437,2,'51-APR'),(49854,1,'90-BER-11'),(49854,2,'90-APP-11'),(99994,1,'25-STR-9'),(99994,2,'26-8x10'),(99994,3,'90-PEC-11'),(99994,4,'50-CH'),(21622,1,'45-CO'),(64861,1,'50-ALM'),(64861,2,'46-11'),(33456,1,'46-11'),(33456,2,'90-BLK-PF'),(75468,1,'70-M-CH-DZ'),(75468,2,'70-M-CH-DZ'),(75468,3,'90-CHR-11'),(56365,1,'50-APR'),(91192,1,'51-APP'),(91192,2,'51-ATW'),(91192,3,'50-APP'),(82056,1,'90-APP-11'),(82056,2,'50-CH'),(82056,3,'90-BLK-PF'),(82056,4,'45-CO'),(27192,1,'70-R'),(27192,2,'90-BLU-11'),(27192,3,'70-TU'),(59716,1,'51-APR'),(59716,2,'70-MAR'),(59716,3,'90-BLU-11'),(59716,4,'45-CO'),(59716,5,'90-APP-11'),(82795,1,'90-APR-PF'),(26240,1,'20-CA-7.5'),(56724,1,'70-M-VA-SM-DZ'),(70796,1,'45-CO'),(70796,2,'20-BC-L-10'),(70796,3,'45-CH'),(70796,4,'90-BLU-11'),(37636,1,'90-APR-PF'),(37636,2,'90-CH-PF'),(37636,3,'24-8x10'),(63998,1,'70-M-VA-SM-DZ'),(48981,1,'90-CHR-11'),(48981,2,'50-CHS'),(66704,1,'90-BER-11'),(66704,2,'51-APR'),(66704,3,'70-LEM'),(12698,1,'51-APP'),(12698,2,'70-R'),(12698,3,'26-8x10'),(79287,1,'90-PEC-11'),(79287,2,'45-VA'),(79287,3,'90-LEM-11'),(79287,4,'90-APP-11'),(79287,5,'51-BLU'),(55690,1,'70-M-CH-DZ'),(55690,2,'51-BLU'),(55690,3,'90-APP-11'),(94371,1,'51-BLU'),(26148,1,'20-CA-7.5'),(26148,2,'90-BLU-11'),(26148,3,'51-BLU'),(26148,4,'70-M-CH-DZ'),(11923,1,'70-LEM'),(46598,1,'70-R'),(46598,2,'70-W'),(46598,3,'70-R'),(76951,1,'51-BLU'),(85858,1,'20-CA-7.5'),(85858,2,'70-M-VA-SM-DZ'),(85858,3,'51-BLU'),(85881,1,'90-APP-11'),(89937,1,'51-BLU'),(89937,2,'51-BC'),(89937,3,'90-BER-11'),(89937,4,'70-R'),(66227,1,'90-APP-11'),(66227,2,'90-APIE-10'),(66227,3,'70-MAR'),(66227,4,'90-BLK-PF'),(60240,1,'90-APP-11'),(60240,2,'50-ALM'),(86085,1,'50-APR'),(86085,2,'50-APP'),(86085,3,'90-APR-PF'),(86085,4,'51-ATW'),(67314,1,'51-BC'),(67314,2,'50-CHS'),(67314,3,'70-TU'),(67314,4,'20-CA-7.5'),(10013,1,'70-M-CH-DZ'),(26741,1,'70-GA'),(26741,2,'50-APP'),(38157,1,'70-MAR'),(38157,2,'90-CHR-11'),(38157,3,'70-LEM'),(38157,4,'90-CHR-11'),(45873,1,'70-M-VA-SM-DZ'),(37540,1,'45-CO'),(37540,2,'51-APR'),(11891,1,'45-CO'),(11891,2,'50-APR'),(11891,3,'46-11'),(61797,1,'70-GON'),(61797,2,'90-CH-PF'),(61797,3,'70-M-VA-SM-DZ'),(61797,4,'70-M-CH-DZ'),(61797,5,'90-BER-11'),(52369,1,'90-CHR-11'),(52369,2,'70-TU'),(96430,1,'90-PEC-11'),(64301,1,'70-W'),(64301,2,'51-APR'),(64301,3,'90-BER-11'),(45976,1,'24-8x10'),(45976,2,'51-BC'),(39605,1,'90-BER-11'),(52013,1,'70-W'),(52013,2,'50-ALM'),(52013,3,'90-ALM-I'),(52013,4,'90-APP-11'),(88626,1,'90-APP-11'),(53376,1,'51-APR'),(53376,2,'90-CHR-11'),(53376,3,'90-APIE-10'),(53376,4,'46-11'),(53376,5,'90-BLU-11'),(15584,1,'70-LEM'),(73437,1,'70-M-CH-DZ'),(24200,1,'50-CHS'),(92252,1,'70-GON'),(92252,2,'51-ATW'),(92252,3,'51-BLU'),(92252,4,'45-VA'),(92252,5,'70-M-VA-SM-DZ'),(39685,1,'50-APP'),(39685,2,'70-M-CH-DZ'),(39685,3,'90-APR-PF'),(39685,4,'90-APIE-10'),(61378,1,'51-APR'),(61378,2,'90-BLK-PF'),(96761,1,'26-8x10'),(96761,2,'70-LEM'),(96761,3,'50-CHS'),(96761,4,'50-CHS'),(26198,1,'70-GA'),(26198,2,'70-GON'),(26198,3,'50-APP'),(26198,4,'20-BC-L-10'),(26198,5,'70-R'),(78179,1,'51-BLU'),(78179,2,'50-CHS'),(78179,3,'90-BLK-PF'),(78179,4,'45-CO'),(78179,5,'70-R'),(68890,1,'50-ALM'),(75526,1,'90-LEM-11'),(86162,1,'51-BLU'),(86162,2,'50-ALM'),(86162,3,'50-CHS'),(86162,4,'70-TU'),(86162,5,'50-ALM'),(13496,1,'70-W'),(13496,2,'90-ALM-I'),(13496,3,'51-ATW'),(13496,4,'50-APP'),(60469,1,'51-APR'),(50660,1,'70-TU'),(50660,2,'90-APIE-10'),(64553,1,'51-BC'),(64553,2,'90-APP-11'),(64553,3,'70-LEM'),(64553,4,'90-APP-11'),(57784,1,'90-CH-PF'),(84258,1,'51-APP'),(84258,2,'51-BC'),(68199,1,'51-APR'),(68199,2,'24-8x10'),(78187,1,'51-ATW'),(78187,2,'51-ATW'),(81517,1,'70-M-CH-DZ'),(81517,2,'51-ATW'),(18951,1,'51-APR'),(20411,1,'90-APP-11'),(20411,2,'90-APR-PF'),(55494,1,'90-APP-11'),(55494,2,'45-VA'),(42162,1,'70-M-VA-SM-DZ'),(49977,1,'26-8x10'),(49977,2,'45-CO'),(49977,3,'45-CH'),(49977,4,'20-BC-L-10'),(89638,1,'70-M-CH-DZ'),(89638,2,'70-M-CH-DZ'),(89638,3,'50-ALM'),(89638,4,'90-CH-PF'),(73438,1,'90-CHR-11'),(73438,2,'50-APR'),(96258,1,'90-CHR-11'),(96258,2,'90-BLK-PF'),(96258,3,'24-8x10'),(96258,4,'70-LEM'),(19258,1,'90-CHR-11'),(12800,1,'70-LEM'),(12800,2,'20-CA-7.5'),(12800,3,'90-ALM-I'),(12800,4,'90-APR-PF'),(81368,1,'50-CHS'),(81368,2,'90-CH-PF'),(70655,1,'26-8x10'),(70655,2,'70-TU'),(70655,3,'90-ALM-I'),(70655,4,'45-CO'),(19002,1,'26-8x10'),(19002,2,'25-STR-9'),(31874,1,'70-MAR'),(31874,2,'70-MAR'),(31874,3,'90-LEM-11'),(72207,1,'70-MAR'),(72207,2,'20-CA-7.5'),(65091,1,'51-APR'),(42833,1,'90-CHR-11'),(42833,2,'70-W'),(42833,3,'51-BC'),(72949,1,'51-APR'),(72949,2,'70-LEM'),(72949,3,'90-BLK-PF'),(72949,4,'51-BLU'),(72949,5,'70-W'),(46248,1,'70-M-CH-DZ'),(38849,1,'45-VA'),(38849,2,'70-M-VA-SM-DZ'),(38849,3,'46-11'),(38849,4,'51-ATW'),(38849,5,'50-APR'),(86861,1,'20-BC-L-10'),(86861,2,'50-CHS'),(86861,3,'70-GON'),(86861,4,'51-BLU'),(32701,1,'90-BLK-PF'),(32701,2,'50-APR'),(32701,3,'20-CA-7.5'),(89182,1,'51-APR'),(89182,2,'51-APP'),(89182,3,'70-LEM'),(89182,4,'50-ALM'),(89182,5,'45-CH'),(68753,1,'70-R'),(68753,2,'46-11'),(68753,3,'51-BLU'),(68753,4,'70-W'),(68753,5,'51-BC'),(39217,1,'90-ALM-I'),(39217,2,'51-ATW'),(39217,3,'45-CH'),(39217,4,'90-BLK-PF'),(96531,1,'24-8x10'),(96531,2,'50-APP'),(96531,3,'70-GA'),(96531,4,'50-CHS'),(53922,1,'70-M-VA-SM-DZ'),(53922,2,'46-11'),(53922,3,'20-BC-L-10'),(53922,4,'70-GON'),(64477,1,'70-TU'),(64477,2,'90-PEC-11'),(64477,3,'90-BLK-PF'),(64477,4,'51-ATW'),(64477,5,'20-CA-7.5'),(99058,1,'50-CHS'),(99058,2,'90-BLU-11'),(99058,3,'51-BLU'),(99058,4,'45-CH'),(99058,5,'90-CHR-11'),(77032,1,'50-CH'),(77032,2,'46-11'),(77032,3,'50-ALM'),(77032,4,'70-MAR'),(15286,1,'70-MAR'),(15286,2,'50-APP'),(15286,3,'90-APR-PF'),(59774,1,'51-BLU'),(59774,2,'70-GA'),(59774,3,'90-ALM-I'),(35073,1,'90-CHR-11'),(35073,2,'70-GON'),(34910,1,'51-APP'),(34910,2,'24-8x10'),(34910,3,'90-PEC-11'),(34910,4,'51-BC'),(17685,1,'20-BC-L-10'),(17685,2,'50-APP'),(17685,3,'51-ATW'),(17685,4,'70-MAR'),(45062,1,'50-CHS'),(45062,2,'20-CA-7.5'),(39109,1,'90-APIE-10'),(39109,2,'90-APP-11'),(37063,1,'70-TU'),(37063,2,'90-APP-11'),(37063,3,'70-W'),(18567,1,'70-LEM'),(18567,2,'90-APR-PF'),(37586,1,'70-TU'),(62707,1,'70-R'),(62707,2,'90-CHR-11'),(62707,3,'20-BC-L-10'),(62707,4,'90-APR-PF'),(28117,1,'90-CH-PF'),(28117,2,'50-APP'),(28117,3,'25-STR-9'),(64574,1,'51-ATW'),(64574,2,'70-TU'),(64574,3,'70-W'),(40305,1,'20-CA-7.5'),(40305,2,'70-GA'),(33060,1,'45-CO'),(33060,2,'46-11'),(33060,3,'90-BLK-PF'),(12396,1,'90-BER-11'),(12396,2,'70-M-VA-SM-DZ'),(12396,3,'51-BC'),(12396,4,'90-APR-PF'),(12396,5,'20-CA-7.5'),(43103,1,'70-M-CH-DZ'),(39575,1,'70-M-CH-DZ'),(70162,1,'46-11'),(70162,2,'70-M-CH-DZ'),(70162,3,'50-APR'),(70162,4,'70-MAR'),(23034,1,'70-M-CH-DZ'),(23034,2,'90-APR-PF'),(79296,1,'90-PEC-11'),(79296,2,'50-APR'),(79296,3,'90-ALM-I'),(79296,4,'51-BC'),(79296,5,'90-PEC-11'),(74741,1,'90-APP-11'),(74741,2,'51-APP'),(74741,3,'70-MAR'),(98806,1,'26-8x10'),(98806,2,'50-APR'),(98806,3,'90-APIE-10'),(98806,4,'51-APP'),(43752,1,'90-BLU-11'),(47353,1,'90-APR-PF'),(47353,2,'90-APIE-10'),(47353,3,'70-TU'),(47353,4,'90-BLK-PF'),(39829,1,'20-BC-L-10'),(87454,1,'90-APIE-10'),(87454,2,'50-APP'),(76663,1,'25-STR-9'),(76663,2,'90-APP-11'),(85492,1,'70-M-CH-DZ'),(85492,2,'25-STR-9'),(85492,3,'90-BLU-11'),(85492,4,'70-M-CH-DZ'),(48647,1,'51-BC'),(48647,2,'90-APIE-10'),(48647,3,'90-CHR-11'),(61008,1,'20-CA-7.5'),(61008,2,'90-APP-11'),(96402,1,'50-ALM'),(96402,2,'20-CA-7.5'),(96402,3,'90-APP-11'),(35904,1,'46-11'),(35904,2,'90-APR-PF'),(49845,1,'90-BLK-PF'),(49845,2,'70-LEM'),(49845,3,'50-CH'),(49845,4,'90-PEC-11'),(46014,1,'51-ATW'),(46014,2,'90-APR-PF'),(46014,3,'45-VA'),(46014,4,'90-CH-PF'),(46014,5,'90-BLK-PF'),(46876,1,'70-TU'),(46876,2,'51-APP'),(34579,1,'24-8x10'),(34579,2,'70-GA'),(34579,3,'70-TU'),(34579,4,'26-8x10'),(17729,1,'51-ATW'),(17729,2,'50-APP'),(17729,3,'90-BLU-11'),(17729,4,'90-CH-PF'),(17729,5,'20-CA-7.5'),(74952,1,'45-VA'),(74952,2,'90-APP-11'),(74952,3,'90-BER-11'),(61948,1,'70-MAR'),(61948,2,'70-GON'),(61948,3,'45-CH'),(61948,4,'24-8x10'),(41064,1,'70-R'),(41064,2,'90-APR-PF'),(41064,3,'51-APP'),(17947,1,'50-APP'),(20913,1,'90-LEM-11'),(20913,2,'70-M-CH-DZ'),(20913,3,'70-LEM'),(95514,1,'45-CH'),(95514,2,'46-11'),(95514,3,'70-MAR'),(95514,4,'51-APP'),(24829,1,'20-CA-7.5'),(44590,1,'90-BLU-11'),(44590,2,'24-8x10'),(44590,3,'90-BLU-11'),(44590,4,'45-CH'),(44590,5,'90-PEC-11'),(65165,1,'24-8x10'),(65165,2,'90-ALM-I'),(65165,3,'70-R'),(65165,4,'45-CO'),(89588,1,'90-BLK-PF'),(53240,1,'25-STR-9'),(53240,2,'51-ATW'),(46674,1,'51-BC'),(67946,1,'90-PEC-11'),(67946,2,'90-APR-PF'),(67946,3,'90-APR-PF'),(67946,4,'90-LEM-11'),(31233,1,'70-M-VA-SM-DZ'),(31233,2,'50-APR'),(31233,3,'50-CHS'),(31233,4,'51-BC'),(15904,1,'90-CH-PF'),(17488,1,'50-APP'),(97097,1,'70-MAR'),(50512,1,'90-APP-11'),(11548,1,'45-CO'),(11548,2,'90-APIE-10'),(29908,1,'45-VA'),(29908,2,'51-ATW'),(29908,3,'25-STR-9'),(29908,4,'70-GA'),(29908,5,'90-CH-PF'),(20127,1,'90-BER-11'),(20127,2,'70-M-CH-DZ'),(41963,1,'50-ALM'),(41963,2,'90-CH-PF'),(16532,1,'50-APP'),(16532,2,'70-MAR'),(16532,3,'70-TU'),(16532,4,'24-8x10'),(34378,1,'90-CHR-11'),(34378,2,'45-VA');

INSERT INTO `Rating` VALUES 
   (1, '20-BC-C-10', 5, 'Mediocre cake.'),
   (2, '20-BC-L-10', 8, 'Mediocre, yet lemony, cake.'),
   (2, '70-R', 9, 'Can\'t go wrong!'),
   (2, '20-CA-7.5', 1, 'I don\'t even know what casino cake is.'),
   (8, '90-APIE-10', 9, 'Yea, this is OK.'),
   (3, '90-APIE-10', 9, 'Not bad'),
   (3, '24-8x10', 5, 'Or opera cake either.'),
   (4, '46-11', 3, 'Cake was not empirically good.'),
   (4, '90-ALM-I', 2, 'Almond is not meant to be tart.'),
   (5, '90-APIE-10', 10, 'Classic!'),
   (6, '90-APIE-10', 10, 'Superb!'),
   (7, '90-ALM-I', 10, 'Amazing!');

INSERT INTO `Discount` VALUES
   (1, '2007-10-7', '2007-10-9', 30),
   (4, '2007-10-15', '2007-10-28', 25),
   (5, '2007-10-25', '2007-10-27', 5),
   (6, '2007-10-25', '2007-10-30', 90);

INSERT INTO `DiscountXProduct` VALUES
   (1, '20-BC-C-10'),
   (1, '46-11'),
   (1, '20-BC-L-10'),
   (1, '90-APIE-10'),
   (4, '90-APIE-10'),
   (4, '46-11'),
   (5, '46-11'),
   (5, '90-ALM-I'),
   (6, '45-CH'),
   (6, '45-CO'),
   (6, '90-ALM-I');
   


SELECT productId 'ID', max(score) 'Max', count(score) 'Count'
FROM Rating
GROUP BY productId
HAVING Count > 1
ORDER BY ID;

SELECT avg(age) FROM Customer;

 
SELECT lastName
FROM Customer
WHERE age > (SELECT avg(age) FROM Customer)
ORDER BY lastName;










SELECT distinct c.id From Customer c 
join receipt on c.id = customerId && purchaseDate > '2007-10-29' 
ORDER BY c.id;

SELECT c2.id 'id'
FROM Customer c 
JOIN Receipt ON c.id = customerId && purchaseDate > '2007-10-29' 
RIGHT JOIN Customer c2 ON c.id = c2.id
WHERE c.id IS NULL
ORDER BY c2.id;


SELECT distinct c1.id 'id'
FROM Customer c1 
left join Customer c2 on c1.id = c2.id
join Receipt r on c2.id = customerId && r.purchaseDate > '2007-10-29' 
WHERE c2.id IS NULL
ORDER BY id;

SELECT c.id 'id'
FROM Customer c
JOIN Receipt r1 on c.id = customerId
LEFT JOIN Receipt r2 on r1.id = r2.id
WHERE r2.purchaseDate > '2007-10-29' && r2.id IS NULL;






SELECT productId 'ID', GROUP_CONCAT(DISTINCT receiptId ORDER BY receiptId SEPARATOR ',') 'Receipts'
FROM LineItem
GROUP BY productId
HAVING count(Distinct receiptId) > 10
ORDER BY ID;



SELECT lastName FROM Customer 
WHERE state in (SELECT state FROM Customer Group By state having count(id) > 1)
order by lastName;




SELECT lastName FROM Customer c join (
SELECT Distinct r1.customerId
FROM Receipt r1 
Join Receipt r2 on r1.purchaseDate = r2.purchaseDate 
and r1.id <> r2.id and r1.customerId = r2.customerId) r on c.id = r.customerId;



SELECT distinct c1.lastName FROM Customer c1
left join Customer c2 on c1.id = c2.id
join receipt r1 on c2.id = customerId
join receipt r2 on r1.purchaseDate = r2.purchaseDate and r1.id <> r2.id and r1.customerId = r2.customerId
where c2.id is null;


SELECT distinct c1.lastName FROM Customer c1
join receipt r1 on c1.id = r1.customerId
left join receipt r2 on r1.purchaseDate = r2.purchaseDate 
and r1.id <> r2.id 
and r1.customerId = r2.customerId 
&& c1.id = r2.customerId
where r2.id is null;

SELECT distinct c1.lastName FROM Customer c1 left join Customer c2 on c1.id = c2.id join receipt r1 on c2.id = r1.customerId
join receipt r2 on r1.purchaseDate = r2.purchaseDate and r1.id <> r2.id and r1.customerId = r2.customerId
where c2.id is null;


SELECT DISTINCT c.lastName 
FROM Receipt r1
JOIN Receipt r2 ON r1.purchaseDate = r2.purchaseDate 
&& r1.id <> r2.id 
&& r1.customerId = r2.customerId
RIGHT JOIN Customer c ON r1.customerId = c.id
WHERE r1.customerId IS NULL
ORDER BY c.lastName;

