DROP DATABASE IF EXISTS CoursesEC;
CREATE DATABASE CoursesEC;
USE CoursesEC;

CREATE TABLE `Customer` (
  `id` int(11) NOT NULL DEFAULT '0',
  `lastName` varchar(15) DEFAULT NULL,
  `firstName` varchar(15) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `favorites` varchar(255) DEFAULT NULL,
  `lastVisit` date DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Product` (
  `id` varchar(15) NOT NULL DEFAULT '',
  `flavor` varchar(25) DEFAULT NULL,
  `kind` varchar(25) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kind` (`kind`,`flavor`)
);

CREATE TABLE `Receipt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseDate` date DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `Customer` (`id`)
);

CREATE TABLE `LineItem` (
  `receiptId` int(11) NOT NULL DEFAULT '0',
  `lineNum` int(11) NOT NULL DEFAULT '1',
  `productId` varchar(15) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `extPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`receiptId`,`lineNum`),
  KEY `productId` (`productId`),
  CONSTRAINT `lineitem_ibfk_1` FOREIGN KEY (`receiptId`) REFERENCES `Receipt` (`id`),
  CONSTRAINT `lineitem_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`)
);

CREATE TABLE `Sale` (
  `id` int(11) NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `percentOff` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `ProductXSale` (
  `productId` varchar(15) DEFAULT NULL,
  `saleId` int(11) DEFAULT NULL,
  KEY `productId` (`productId`),
  KEY `saleId` (`saleId`),
  CONSTRAINT `productxsale_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`),
  CONSTRAINT `productxsale_ibfk_2` FOREIGN KEY (`saleId`) REFERENCES `Sale` (`id`)
);

CREATE TABLE `Rating` (
  `customerId` int(11) DEFAULT NULL,
  `productId` varchar(15) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `comment` varchar(1024) DEFAULT NULL,
  KEY `customerId` (`customerId`),
  KEY `productId` (`productId`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `Customer` (`id`),
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`)
);

INSERT INTO `Customer` VALUES (1,'LOGAN','JULIET',17,'F','402 PARADISE RD','HARRISBURG','OR','NAPOLEAN, CAKE','2008-12-23'),(2,'ARZT','TERRELL',18,'M','8101 72ND AVE','PHOENIX','AZ','APRICOT, STRAWBERRY, COOKIE','2013-11-02'),(3,'ESPOSITA','TRAVIS',87,'M','1819 MONUMENT WAY','WALNUT CREEK','CA','CHEESE, STRAWBERRY, CAKE','2013-01-13'),(4,'ENGLEY','SIXTA',18,'F','192 LEXINGTON ST','FORT PIERCE','FL','TRUFFLE, ECLAIR','2012-01-13'),(5,'DUNLOW','TRAVIS',13,'M','6500 FILBERT CT','CAMPBELL','OH','CHOCOLATE, BEAR CLAW','2009-02-02'),(6,'SLINGLAND','JOSETTE',14,'F','333 PARK AVE','SANTA ROSA','CA','LEMON, TART','2010-09-20'),(7,'TOUSSAND','SHARRON',77,'F','2581 CRYSTAL LAKE DR','CEDAR CITY','UT','LEMON, TART','2012-07-25'),(8,'ESPOSITA','RUPERT',65,'M','4531 WESTRAY DR','ORANGE','CA','BLACKBERRY, COOKIE','2013-03-08'),(9,'HAFFERKAMP','CUC',46,'F','2832 AMERSON WAY','BEND','OR','VANILLA, BLUEBERRY, CAKE','2013-09-18'),(10,'DUKELOW','CORETTA',78,'F','314 PECAN ST','EUGENE','OR','ALMOND, CROISSANT','2011-05-09'),(11,'STADICK','MIGDALIA',16,'F','24816 20TH AVE','BELLEVUE','WA','CHOCOLATE, CAKE','2011-05-22'),(12,'MCMAHAN','MELLIE',65,'F','90 CREEKSIDE DR','REDMOND','WA','VANILLA, STRAWBERRY TWIST','2012-10-19'),(13,'ARNN','KIP',28,'M','1654 PINE VALLEY DR','HILO','HI','CASINO, DANISH','2013-09-30'),(14,'SOPKO','RAYFORD',64,'M','148 BLACKBURN ST','ROCK SPRINGS','WY','CASINO, OPERA, CROISSANT, TWIST','2012-02-24'),(15,'CALLENDAR','DAVID',67,'M','27 MILDRED RD','STERLING','AK','CHOCOLATE, BERRY, CAKE','2012-03-01'),(16,'CRUZEN','ARIANE',17,'F','700 MIDLAND AVE','FULTON','NY','PECAN, BERRY, DANISH, STRAWBERRY, MERINGUE','2011-01-06'),(17,'MESDAQ','CHARLENE',17,'F','650 SPRUCE ST','FULTON','NY','ALMOND, STRAWBERRY, COOKIE','2013-01-01'),(18,'DOMKOWSKI','ALMETA',15,'F','11 PHILADELPHIA ST','PROVIDENCE','RI','STRAWBERRY, COFFEE, COOKIE','2012-12-31'),(19,'STENZ','NATACHA',34,'F','30 BANK ST','CHICO','CA','BERRY, APPLE, CHOCOLATE, PIE, TART','2013-12-29'),(20,'ZEME','STEPHEN',18,'M','3133 MAPLE CT','WALNUT CREEK','CA','LEMON, PECAN, TART, ECLAIR','2012-03-04'),(21,'CHEAP','JOE',20,'M','123 SKINFLINT DR','FULTON','CA','',NULL);

INSERT INTO `Product` VALUES ('20-BC-C-10','Chocolate','Cake',8.95),('20-BC-L-10','Lemon','Cake',8.95),('20-CA-7.5','Casino','Cake',15.95),('24-8x10','Opera','Cake',15.95),('25-STR-9','Strawberry','Cake',11.95),('26-8x10','Truffle','Cake',15.95),('45-CH','Chocolate','Eclair',3.25),('45-CO','Coffee','Eclair',3.50),('45-VA','Vanilla','Eclair',3.25),('46-11','Napoleon','Cake',13.49),('50-ALM','Almond','Croissant',1.45),('50-APP','Apple','Croissant',1.45),('50-APR','Apricot','Croissant',1.45),('50-CH','Chocolate','Croissant',1.75),('50-CHS','Cheese','Croissant',1.75),('51-APP','Apple','Danish',1.15),('51-APR','Apricot','Danish',1.15),('51-ATW','Almond','Twist',1.15),('51-BC','Almond','Bear Claw',1.95),('51-BLU','Blueberry','Danish',1.15),('70-GA','Ganache','Cookie',1.15),('70-GON','Gongolais','Cookie',1.15),('70-LEM','Lemon','Cookie',0.79),('70-M-CH-DZ','Chocolate','Meringue',1.25),('70-M-VA-SM-DZ','Vanilla','Meringue',1.15),('70-MAR','Marzipan','Cookie',1.25),('70-R','Raspberry','Cookie',1.09),('70-TU','Tuile','Cookie',1.25),('70-W','Walnut','Cookie',0.79),('90-ALM-I','Almond','Tart',3.75),('90-APIE-10','Apple','Pie',5.25),('90-APP-11','Apple','Tart',3.25),('90-APR-PF','Apricot','Tart',3.25),('90-BER-11','Berry','Tart',3.25),('90-BLK-PF','Blackberry','Tart',3.25),('90-BLU-11','Blueberry','Tart',3.25),('90-CH-PF','Chocolate','Tart',3.75),('90-CHR-11','Cherry','Tart',3.25),('90-LEM-11','Lemon','Tart',3.25),('90-PEC-11','Pecan','Tart',3.75);

INSERT INTO `Receipt` VALUES (10013,'2007-10-17',15,1.25),(11548,'2007-10-21',13,8.75),(11891,'2007-10-30',7,18.44),(11923,'2007-10-09',15,0.79),(12396,'2007-10-10',10,25.55),(12698,'2007-10-23',19,18.19),(12800,'2007-10-22',11,23.74),(13355,'2007-10-19',7,30.23),(13496,'2007-10-30',11,7.14),(15286,'2007-10-11',6,5.95),(15584,'2007-10-13',3,0.79),(15904,'2007-10-06',13,3.75),(16034,'2007-10-10',4,47.27),(16532,'2007-10-21',4,19.90),(17488,'2007-10-20',6,1.45),(17685,'2007-10-02',12,12.80),(17729,'2007-10-16',16,25.55),(17947,'2007-10-27',7,1.45),(18129,'2007-10-28',15,1.25),(18567,'2007-10-13',7,4.04),(18951,'2007-10-14',20,1.15),(19002,'2007-10-19',6,27.90),(19258,'2007-10-25',5,3.25),(20127,'2007-10-07',15,4.50),(20411,'2007-10-08',7,6.50),(20913,'2007-10-07',8,5.29),(21040,'2007-10-03',6,13.79),(21162,'2007-10-04',8,7.75),(21545,'2007-10-22',12,12.35),(21622,'2007-10-10',7,3.50),(23034,'2007-10-15',17,4.50),(24200,'2007-10-16',9,1.75),(24829,'2007-10-07',15,15.95),(25121,'2007-10-20',18,8.25),(25906,'2007-10-29',15,11.95),(26148,'2007-10-19',20,21.60),(26198,'2007-10-12',11,13.79),(26240,'2007-10-07',16,15.95),(26741,'2007-10-24',7,2.60),(27192,'2007-10-28',9,5.59),(27741,'2007-10-25',8,8.45),(28117,'2007-10-09',5,17.15),(29226,'2007-10-26',14,13.19),(29908,'2007-10-14',13,21.25),(31233,'2007-10-20',13,6.30),(31874,'2007-10-13',2,5.75),(32565,'2007-10-24',14,6.15),(32701,'2007-10-19',16,20.65),(33060,'2007-10-29',20,20.24),(33456,'2007-10-05',16,16.74),(34378,'2007-10-23',6,6.50),(34579,'2007-10-08',7,34.30),(34910,'2007-10-07',20,22.80),(35011,'2007-10-10',20,1.75),(35073,'2007-10-23',5,4.40),(35904,'2007-10-21',10,16.74),(36343,'2007-10-31',19,6.50),(36423,'2007-10-24',16,3.25),(37063,'2007-10-22',14,5.29),(37540,'2007-10-03',20,4.65),(37586,'2007-10-03',8,1.25),(37636,'2007-10-20',1,22.95),(38157,'2007-10-23',16,8.54),(38849,'2007-10-25',1,20.49),(39109,'2007-10-02',16,8.50),(39217,'2007-10-19',20,11.40),(39575,'2007-10-20',20,1.25),(39605,'2007-10-12',12,3.25),(39685,'2007-10-28',1,11.20),(39829,'2007-10-31',3,8.95),(40305,'2007-10-25',8,17.10),(41028,'2007-10-06',17,3.25),(41064,'2007-10-25',16,5.49),(41963,'2007-10-29',8,5.20),(42162,'2007-10-16',7,1.15),(42166,'2007-10-14',8,1.15),(42833,'2007-10-22',3,5.99),(43103,'2007-10-07',4,1.25),(43752,'2007-10-05',5,3.25),(44330,'2007-10-20',18,4.34),(44590,'2007-10-12',1,29.45),(44798,'2007-10-04',16,27.45),(45062,'2007-10-23',1,17.70),(45873,'2007-10-05',13,1.15),(45976,'2007-10-03',10,17.90),(46014,'2007-10-16',15,14.65),(46248,'2007-10-12',11,1.25),(46598,'2007-10-03',14,2.97),(46674,'2007-10-29',15,1.95),(46876,'2007-10-06',13,2.40),(47353,'2007-10-12',6,13.00),(48332,'2007-10-15',20,2.24),(48647,'2007-10-09',3,10.45),(48981,'2007-10-24',20,5.00),(49845,'2007-10-31',20,9.54),(49854,'2007-10-12',2,6.50),(49977,'2007-10-18',3,31.65),(50512,'2007-10-27',8,3.25),(50660,'2007-10-18',9,6.50),(51991,'2007-10-17',14,28.20),(52013,'2007-10-05',13,9.24),(52369,'2007-10-15',5,4.50),(52761,'2007-10-27',8,28.45),(53240,'2007-10-03',14,13.10),(53376,'2007-10-30',8,26.39),(53922,'2007-10-13',2,24.74),(54935,'2007-10-16',14,4.34),(55494,'2007-10-20',15,6.50),(55690,'2007-10-15',19,5.65),(55944,'2007-10-16',19,23.13),(56365,'2007-10-14',12,1.45),(56724,'2007-10-09',13,1.15),(57784,'2007-10-15',7,3.75),(58770,'2007-10-22',18,34.44),(59716,'2007-10-30',2,12.40),(59774,'2007-10-02',16,6.05),(60240,'2007-10-17',17,4.70),(60270,'2007-10-31',11,12.20),(60469,'2007-10-20',4,1.15),(61008,'2007-10-09',14,19.20),(61378,'2007-10-08',11,4.40),(61797,'2007-10-30',8,10.55),(61948,'2007-10-04',5,21.60),(62707,'2007-10-07',8,16.54),(63998,'2007-10-13',20,1.15),(64301,'2007-10-12',14,5.19),(64451,'2007-10-10',11,24.40),(64477,'2007-10-16',6,25.35),(64553,'2007-10-08',17,9.24),(64574,'2007-10-02',6,3.19),(64861,'2007-10-15',10,14.94),(65091,'2007-10-09',17,1.15),(65165,'2007-10-04',4,24.29),(66227,'2007-10-10',1,13.00),(66704,'2007-10-29',14,5.19),(67314,'2007-10-23',6,20.90),(67946,'2007-10-18',7,13.50),(68199,'2007-10-04',9,17.10),(68753,'2007-10-11',5,18.47),(68890,'2007-10-27',7,1.45),(70162,'2007-10-09',19,17.44),(70655,'2007-10-06',2,24.45),(70723,'2007-10-28',20,3.50),(70796,'2007-10-31',12,18.95),(72207,'2007-10-15',1,17.20),(72949,'2007-10-02',6,7.13),(73437,'2007-10-01',6,1.25),(73438,'2007-10-18',10,4.70),(73716,'2007-10-29',18,10.04),(74741,'2007-10-12',20,5.65),(74952,'2007-10-16',5,9.75),(75468,'2007-10-21',10,5.75),(75526,'2007-10-22',18,3.25),(76663,'2007-10-04',10,15.20),(76667,'2007-10-14',15,4.40),(76951,'2007-10-27',14,1.15),(77032,'2007-10-28',14,17.94),(77406,'2007-10-09',13,23.25),(78179,'2007-10-24',14,10.74),(78187,'2007-10-17',14,2.30),(79287,'2007-10-30',8,14.65),(79296,'2007-10-03',19,14.65),(81368,'2007-10-17',19,5.50),(81517,'2007-10-10',1,2.40),(82056,'2007-10-07',18,11.75),(82795,'2007-10-08',15,3.25),(83085,'2007-10-12',7,48.25),(83437,'2007-10-15',8,4.40),(84258,'2007-10-22',2,3.10),(84665,'2007-10-10',6,3.25),(85492,'2007-10-20',12,17.70),(85858,'2007-10-31',1,18.25),(85881,'2007-10-13',1,3.25),(86085,'2007-10-16',1,7.30),(86162,'2007-10-10',16,7.05),(86678,'2007-10-24',3,4.40),(86861,'2007-10-26',9,13.00),(87454,'2007-10-21',6,6.70),(88626,'2007-10-25',17,3.25),(89182,'2007-10-29',5,7.79),(89588,'2007-10-09',7,3.25),(89638,'2007-10-07',4,7.70),(89937,'2007-10-20',7,7.44),(91192,'2007-10-10',5,3.75),(91937,'2007-10-21',12,3.10),(92252,'2007-10-25',7,7.85),(94371,'2007-10-22',8,1.15),(95514,'2007-10-09',10,19.14),(95962,'2007-10-26',8,11.50),(96258,'2007-10-12',8,23.24),(96402,'2007-10-04',6,20.65),(96430,'2007-10-04',18,3.75),(96531,'2007-10-12',8,20.30),(96619,'2007-10-07',18,3.25),(96761,'2007-10-14',20,20.24),(97097,'2007-10-23',9,1.25),(98806,'2007-10-15',17,23.80),(99002,'2007-10-13',20,5.00),(99058,'2007-10-03',14,12.65),(99994,'2007-10-21',6,33.40);

INSERT INTO `LineItem` VALUES (10013,1,'70-M-CH-DZ',1,1.25),(11548,1,'45-CO',1,3.50),(11548,2,'90-APIE-10',1,5.25),(11891,1,'45-CO',1,3.50),(11891,2,'50-APR',1,1.45),(11891,3,'46-11',1,13.49),(11923,1,'70-LEM',1,0.79),(12396,1,'90-BER-11',1,3.25),(12396,2,'70-M-VA-SM-DZ',1,1.15),(12396,3,'51-BC',1,1.95),(12396,4,'90-APR-PF',1,3.25),(12396,5,'20-CA-7.5',1,15.95),(12698,1,'51-APP',1,1.15),(12698,2,'70-R',1,1.09),(12698,3,'26-8x10',1,15.95),(12800,1,'70-LEM',1,0.79),(12800,2,'20-CA-7.5',1,15.95),(12800,3,'90-ALM-I',1,3.75),(12800,4,'90-APR-PF',1,3.25),(13355,1,'24-8x10',1,15.95),(13355,2,'70-LEM',1,0.79),(13355,3,'46-11',1,13.49),(13496,1,'70-W',1,0.79),(13496,2,'90-ALM-I',1,3.75),(13496,3,'51-ATW',1,1.15),(13496,4,'50-APP',1,1.45),(15286,1,'70-MAR',1,1.25),(15286,2,'50-APP',1,1.45),(15286,3,'90-APR-PF',1,3.25),(15584,1,'70-LEM',1,0.79),(15904,1,'90-CH-PF',1,3.75),(16034,1,'46-11',2,26.98),(16034,2,'26-8x10',1,15.95),(16034,3,'45-CH',1,3.25),(16034,4,'70-R',1,1.09),(16532,1,'50-APP',1,1.45),(16532,2,'70-MAR',1,1.25),(16532,3,'70-TU',1,1.25),(16532,4,'24-8x10',1,15.95),(17488,1,'50-APP',1,1.45),(17685,1,'20-BC-L-10',1,8.95),(17685,2,'50-APP',1,1.45),(17685,3,'51-ATW',1,1.15),(17685,4,'70-MAR',1,1.25),(17729,1,'51-ATW',1,1.15),(17729,2,'50-APP',1,1.45),(17729,3,'90-BLU-11',1,3.25),(17729,4,'90-CH-PF',1,3.75),(17729,5,'20-CA-7.5',1,15.95),(17947,1,'50-APP',1,1.45),(18129,1,'70-TU',1,1.25),(18567,1,'70-LEM',1,0.79),(18567,2,'90-APR-PF',1,3.25),(18951,1,'51-APR',1,1.15),(19002,1,'26-8x10',1,15.95),(19002,2,'25-STR-9',1,11.95),(19258,1,'90-CHR-11',1,3.25),(20127,1,'90-BER-11',1,3.25),(20127,2,'70-M-CH-DZ',1,1.25),(20411,1,'90-APP-11',1,3.25),(20411,2,'90-APR-PF',1,3.25),(20913,1,'90-LEM-11',1,3.25),(20913,2,'70-M-CH-DZ',1,1.25),(20913,3,'70-LEM',1,0.79),(21040,1,'70-R',1,1.09),(21040,2,'20-BC-L-10',1,8.95),(21040,3,'90-CH-PF',1,3.75),(21162,1,'90-APP-11',1,3.25),(21162,2,'70-TU',1,1.25),(21162,3,'90-APR-PF',1,3.25),(21545,1,'90-BER-11',2,6.50),(21545,2,'70-GA',1,1.15),(21545,3,'50-ALM',1,1.45),(21545,5,'45-VA',1,3.25),(21622,1,'45-CO',1,3.50),(23034,1,'70-M-CH-DZ',1,1.25),(23034,2,'90-APR-PF',1,3.25),(24200,1,'50-CHS',1,1.75),(24829,1,'20-CA-7.5',1,15.95),(25121,1,'50-CHS',1,1.75),(25121,2,'90-BER-11',1,3.25),(25121,3,'45-CH',1,3.25),(25906,1,'25-STR-9',1,11.95),(26148,1,'20-CA-7.5',1,15.95),(26148,2,'90-BLU-11',1,3.25),(26148,3,'51-BLU',1,1.15),(26148,4,'70-M-CH-DZ',1,1.25),(26198,1,'70-GA',1,1.15),(26198,2,'70-GON',1,1.15),(26198,3,'50-APP',1,1.45),(26198,4,'20-BC-L-10',1,8.95),(26198,5,'70-R',1,1.09),(26240,1,'20-CA-7.5',1,15.95),(26741,1,'70-GA',1,1.15),(26741,2,'50-APP',1,1.45),(27192,1,'70-R',1,1.09),(27192,2,'90-BLU-11',1,3.25),(27192,3,'70-TU',1,1.25),(27741,1,'90-BLK-PF',1,3.25),(27741,2,'51-BC',1,1.95),(27741,3,'90-APR-PF',1,3.25),(28117,1,'90-CH-PF',1,3.75),(28117,2,'50-APP',1,1.45),(28117,3,'25-STR-9',1,11.95),(29226,1,'90-PEC-11',1,3.75),(29226,2,'90-APIE-10',1,5.25),(29226,3,'51-BC',1,1.95),(29226,4,'70-W',1,0.79),(29226,5,'50-ALM',1,1.45),(29908,1,'45-VA',1,3.25),(29908,2,'51-ATW',1,1.15),(29908,3,'25-STR-9',1,11.95),(29908,4,'70-GA',1,1.15),(29908,5,'90-CH-PF',1,3.75),(31233,1,'70-M-VA-SM-DZ',1,1.15),(31233,2,'50-APR',1,1.45),(31233,3,'50-CHS',1,1.75),(31233,4,'51-BC',1,1.95),(31874,1,'70-MAR',2,2.50),(31874,3,'90-LEM-11',1,3.25),(32565,1,'50-APP',2,2.90),(32565,3,'45-VA',1,3.25),(32701,1,'90-BLK-PF',1,3.25),(32701,2,'50-APR',1,1.45),(32701,3,'20-CA-7.5',1,15.95),(33060,1,'45-CO',1,3.50),(33060,2,'46-11',1,13.49),(33060,3,'90-BLK-PF',1,3.25),(33456,1,'46-11',1,13.49),(33456,2,'90-BLK-PF',1,3.25),(34378,1,'90-CHR-11',1,3.25),(34378,2,'45-VA',1,3.25),(34579,1,'24-8x10',1,15.95),(34579,2,'70-GA',1,1.15),(34579,3,'70-TU',1,1.25),(34579,4,'26-8x10',1,15.95),(34910,1,'51-APP',1,1.15),(34910,2,'24-8x10',1,15.95),(34910,3,'90-PEC-11',1,3.75),(34910,4,'51-BC',1,1.95),(35011,1,'50-CHS',1,1.75),(35073,1,'90-CHR-11',1,3.25),(35073,2,'70-GON',1,1.15),(35904,1,'46-11',1,13.49),(35904,2,'90-APR-PF',1,3.25),(36343,1,'51-BC',2,3.90),(36343,3,'70-M-VA-SM-DZ',1,1.15),(36343,4,'50-ALM',1,1.45),(36423,1,'45-VA',1,3.25),(37063,1,'70-TU',1,1.25),(37063,2,'90-APP-11',1,3.25),(37063,3,'70-W',1,0.79),(37540,1,'45-CO',1,3.50),(37540,2,'51-APR',1,1.15),(37586,1,'70-TU',1,1.25),(37636,1,'90-APR-PF',1,3.25),(37636,2,'90-CH-PF',1,3.75),(37636,3,'24-8x10',1,15.95),(38157,1,'70-MAR',1,1.25),(38157,2,'90-CHR-11',2,6.50),(38157,3,'70-LEM',1,0.79),(38849,1,'45-VA',1,3.25),(38849,2,'70-M-VA-SM-DZ',1,1.15),(38849,3,'46-11',1,13.49),(38849,4,'51-ATW',1,1.15),(38849,5,'50-APR',1,1.45),(39109,1,'90-APIE-10',1,5.25),(39109,2,'90-APP-11',1,3.25),(39217,1,'90-ALM-I',1,3.75),(39217,2,'51-ATW',1,1.15),(39217,3,'45-CH',1,3.25),(39217,4,'90-BLK-PF',1,3.25),(39575,1,'70-M-CH-DZ',1,1.25),(39605,1,'90-BER-11',1,3.25),(39685,1,'50-APP',1,1.45),(39685,2,'70-M-CH-DZ',1,1.25),(39685,3,'90-APR-PF',1,3.25),(39685,4,'90-APIE-10',1,5.25),(39829,1,'20-BC-L-10',1,8.95),(40305,1,'20-CA-7.5',1,15.95),(40305,2,'70-GA',1,1.15),(41028,1,'90-BER-11',1,3.25),(41064,1,'70-R',1,1.09),(41064,2,'90-APR-PF',1,3.25),(41064,3,'51-APP',1,1.15),(41963,1,'50-ALM',1,1.45),(41963,2,'90-CH-PF',1,3.75),(42162,1,'70-M-VA-SM-DZ',1,1.15),(42166,1,'70-M-VA-SM-DZ',1,1.15),(42833,1,'90-CHR-11',1,3.25),(42833,2,'70-W',1,0.79),(42833,3,'51-BC',1,1.95),(43103,1,'70-M-CH-DZ',1,1.25),(43752,1,'90-BLU-11',1,3.25),(44330,1,'70-R',1,1.09),(44330,2,'90-BLU-11',1,3.25),(44590,1,'90-BLU-11',2,6.50),(44590,2,'24-8x10',1,15.95),(44590,4,'45-CH',1,3.25),(44590,5,'90-PEC-11',1,3.75),(44798,1,'90-APR-PF',1,3.25),(44798,2,'90-CH-PF',1,3.75),(44798,3,'90-APIE-10',1,5.25),(44798,4,'90-APP-11',1,3.25),(44798,5,'25-STR-9',1,11.95),(45062,1,'50-CHS',1,1.75),(45062,2,'20-CA-7.5',1,15.95),(45873,1,'70-M-VA-SM-DZ',1,1.15),(45976,1,'24-8x10',1,15.95),(45976,2,'51-BC',1,1.95),(46014,1,'51-ATW',1,1.15),(46014,2,'90-APR-PF',1,3.25),(46014,3,'45-VA',1,3.25),(46014,4,'90-CH-PF',1,3.75),(46014,5,'90-BLK-PF',1,3.25),(46248,1,'70-M-CH-DZ',1,1.25),(46598,1,'70-R',2,2.18),(46598,2,'70-W',1,0.79),(46674,1,'51-BC',1,1.95),(46876,1,'70-TU',1,1.25),(46876,2,'51-APP',1,1.15),(47353,1,'90-APR-PF',1,3.25),(47353,2,'90-APIE-10',1,5.25),(47353,3,'70-TU',1,1.25),(47353,4,'90-BLK-PF',1,3.25),(48332,1,'70-GA',1,1.15),(48332,2,'70-R',1,1.09),(48647,1,'51-BC',1,1.95),(48647,2,'90-APIE-10',1,5.25),(48647,3,'90-CHR-11',1,3.25),(48981,1,'90-CHR-11',1,3.25),(48981,2,'50-CHS',1,1.75),(49845,1,'90-BLK-PF',1,3.25),(49845,2,'70-LEM',1,0.79),(49845,3,'50-CH',1,1.75),(49845,4,'90-PEC-11',1,3.75),(49854,1,'90-BER-11',1,3.25),(49854,2,'90-APP-11',1,3.25),(49977,1,'26-8x10',1,15.95),(49977,2,'45-CO',1,3.50),(49977,3,'45-CH',1,3.25),(49977,4,'20-BC-L-10',1,8.95),(50512,1,'90-APP-11',1,3.25),(50660,1,'70-TU',1,1.25),(50660,2,'90-APIE-10',1,5.25),(51991,1,'90-APIE-10',1,5.25),(51991,2,'90-CH-PF',1,3.75),(51991,3,'90-APP-11',1,3.25),(51991,4,'26-8x10',1,15.95),(52013,1,'70-W',1,0.79),(52013,2,'50-ALM',1,1.45),(52013,3,'90-ALM-I',1,3.75),(52013,4,'90-APP-11',1,3.25),(52369,1,'90-CHR-11',1,3.25),(52369,2,'70-TU',1,1.25),(52761,1,'90-ALM-I',2,7.50),(52761,2,'26-8x10',1,15.95),(52761,3,'50-CHS',1,1.75),(52761,4,'90-BLK-PF',1,3.25),(53240,1,'25-STR-9',1,11.95),(53240,2,'51-ATW',1,1.15),(53376,1,'51-APR',1,1.15),(53376,2,'90-CHR-11',1,3.25),(53376,3,'90-APIE-10',1,5.25),(53376,4,'46-11',1,13.49),(53376,5,'90-BLU-11',1,3.25),(53922,1,'70-M-VA-SM-DZ',1,1.15),(53922,2,'46-11',1,13.49),(53922,3,'20-BC-L-10',1,8.95),(53922,4,'70-GON',1,1.15),(54935,1,'70-R',1,1.09),(54935,2,'45-CH',1,3.25),(55494,1,'90-APP-11',1,3.25),(55494,2,'45-VA',1,3.25),(55690,1,'70-M-CH-DZ',1,1.25),(55690,2,'51-BLU',1,1.15),(55690,3,'90-APP-11',1,3.25),(55944,1,'20-CA-7.5',1,15.95),(55944,2,'90-LEM-11',1,3.25),(55944,3,'70-R',2,2.18),(55944,5,'50-CHS',1,1.75),(56365,1,'50-APR',1,1.45),(56724,1,'70-M-VA-SM-DZ',1,1.15),(57784,1,'90-CH-PF',1,3.75),(58770,1,'50-CHS',1,1.75),(58770,2,'46-11',1,13.49),(58770,3,'45-CH',1,3.25),(58770,4,'20-CA-7.5',1,15.95),(59716,1,'51-APR',1,1.15),(59716,2,'70-MAR',1,1.25),(59716,3,'90-BLU-11',1,3.25),(59716,4,'45-CO',1,3.50),(59716,5,'90-APP-11',1,3.25),(59774,1,'51-BLU',1,1.15),(59774,2,'70-GA',1,1.15),(59774,3,'90-ALM-I',1,3.75),(60240,1,'90-APP-11',1,3.25),(60240,2,'50-ALM',1,1.45),(60270,1,'20-BC-L-10',1,8.95),(60270,2,'90-BLU-11',1,3.25),(60469,1,'51-APR',1,1.15),(61008,1,'20-CA-7.5',1,15.95),(61008,2,'90-APP-11',1,3.25),(61378,1,'51-APR',1,1.15),(61378,2,'90-BLK-PF',1,3.25),(61797,1,'70-GON',1,1.15),(61797,2,'90-CH-PF',1,3.75),(61797,3,'70-M-VA-SM-DZ',1,1.15),(61797,4,'70-M-CH-DZ',1,1.25),(61797,5,'90-BER-11',1,3.25),(61948,1,'70-MAR',1,1.25),(61948,2,'70-GON',1,1.15),(61948,3,'45-CH',1,3.25),(61948,4,'24-8x10',1,15.95),(62707,1,'70-R',1,1.09),(62707,2,'90-CHR-11',1,3.25),(62707,3,'20-BC-L-10',1,8.95),(62707,4,'90-APR-PF',1,3.25),(63998,1,'70-M-VA-SM-DZ',1,1.15),(64301,1,'70-W',1,0.79),(64301,2,'51-APR',1,1.15),(64301,3,'90-BER-11',1,3.25),(64451,1,'90-BER-11',1,3.25),(64451,2,'51-BC',1,1.95),(64451,3,'24-8x10',1,15.95),(64451,4,'90-BLK-PF',1,3.25),(64477,1,'70-TU',1,1.25),(64477,2,'90-PEC-11',1,3.75),(64477,3,'90-BLK-PF',1,3.25),(64477,4,'51-ATW',1,1.15),(64477,5,'20-CA-7.5',1,15.95),(64553,1,'51-BC',1,1.95),(64553,2,'90-APP-11',2,6.50),(64553,3,'70-LEM',1,0.79),(64574,1,'51-ATW',1,1.15),(64574,2,'70-TU',1,1.25),(64574,3,'70-W',1,0.79),(64861,1,'50-ALM',1,1.45),(64861,2,'46-11',1,13.49),(65091,1,'51-APR',1,1.15),(65165,1,'24-8x10',1,15.95),(65165,2,'90-ALM-I',1,3.75),(65165,3,'70-R',1,1.09),(65165,4,'45-CO',1,3.50),(66227,1,'90-APP-11',1,3.25),(66227,2,'90-APIE-10',1,5.25),(66227,3,'70-MAR',1,1.25),(66227,4,'90-BLK-PF',1,3.25),(66704,1,'90-BER-11',1,3.25),(66704,2,'51-APR',1,1.15),(66704,3,'70-LEM',1,0.79),(67314,1,'51-BC',1,1.95),(67314,2,'50-CHS',1,1.75),(67314,3,'70-TU',1,1.25),(67314,4,'20-CA-7.5',1,15.95),(67946,1,'90-PEC-11',1,3.75),(67946,2,'90-APR-PF',2,6.50),(67946,4,'90-LEM-11',1,3.25),(68199,1,'51-APR',1,1.15),(68199,2,'24-8x10',1,15.95),(68753,1,'70-R',1,1.09),(68753,2,'46-11',1,13.49),(68753,3,'51-BLU',1,1.15),(68753,4,'70-W',1,0.79),(68753,5,'51-BC',1,1.95),(68890,1,'50-ALM',1,1.45),(70162,1,'46-11',1,13.49),(70162,2,'70-M-CH-DZ',1,1.25),(70162,3,'50-APR',1,1.45),(70162,4,'70-MAR',1,1.25),(70655,1,'26-8x10',1,15.95),(70655,2,'70-TU',1,1.25),(70655,3,'90-ALM-I',1,3.75),(70655,4,'45-CO',1,3.50),(70723,1,'45-CO',1,3.50),(70796,1,'45-CO',1,3.50),(70796,2,'20-BC-L-10',1,8.95),(70796,3,'45-CH',1,3.25),(70796,4,'90-BLU-11',1,3.25),(72207,1,'70-MAR',1,1.25),(72207,2,'20-CA-7.5',1,15.95),(72949,1,'51-APR',1,1.15),(72949,2,'70-LEM',1,0.79),(72949,3,'90-BLK-PF',1,3.25),(72949,4,'51-BLU',1,1.15),(72949,5,'70-W',1,0.79),(73437,1,'70-M-CH-DZ',1,1.25),(73438,1,'90-CHR-11',1,3.25),(73438,2,'50-APR',1,1.45),(73716,1,'90-PEC-11',1,3.75),(73716,2,'90-ALM-I',1,3.75),(73716,3,'70-LEM',1,0.79),(73716,4,'50-CH',1,1.75),(74741,1,'90-APP-11',1,3.25),(74741,2,'51-APP',1,1.15),(74741,3,'70-MAR',1,1.25),(74952,1,'45-VA',1,3.25),(74952,2,'90-APP-11',1,3.25),(74952,3,'90-BER-11',1,3.25),(75468,1,'70-M-CH-DZ',2,2.50),(75468,3,'90-CHR-11',1,3.25),(75526,1,'90-LEM-11',1,3.25),(76663,1,'25-STR-9',1,11.95),(76663,2,'90-APP-11',1,3.25),(76667,1,'70-GON',1,1.15),(76667,2,'90-LEM-11',1,3.25),(76951,1,'51-BLU',1,1.15),(77032,1,'50-CH',1,1.75),(77032,2,'46-11',1,13.49),(77032,3,'50-ALM',1,1.45),(77032,4,'70-MAR',1,1.25),(77406,1,'51-ATW',1,1.15),(77406,2,'90-BLK-PF',1,3.25),(77406,3,'50-APR',2,2.90),(77406,5,'24-8x10',1,15.95),(78179,1,'51-BLU',1,1.15),(78179,2,'50-CHS',1,1.75),(78179,3,'90-BLK-PF',1,3.25),(78179,4,'45-CO',1,3.50),(78179,5,'70-R',1,1.09),(78187,1,'51-ATW',2,2.30),(79287,1,'90-PEC-11',1,3.75),(79287,2,'45-VA',1,3.25),(79287,3,'90-LEM-11',1,3.25),(79287,4,'90-APP-11',1,3.25),(79287,5,'51-BLU',1,1.15),(79296,1,'90-PEC-11',2,7.50),(79296,2,'50-APR',1,1.45),(79296,3,'90-ALM-I',1,3.75),(79296,4,'51-BC',1,1.95),(81368,1,'50-CHS',1,1.75),(81368,2,'90-CH-PF',1,3.75),(81517,1,'70-M-CH-DZ',1,1.25),(81517,2,'51-ATW',1,1.15),(82056,1,'90-APP-11',1,3.25),(82056,2,'50-CH',1,1.75),(82056,3,'90-BLK-PF',1,3.25),(82056,4,'45-CO',1,3.50),(82795,1,'90-APR-PF',1,3.25),(83085,1,'25-STR-9',1,11.95),(83085,2,'24-8x10',1,15.95),(83085,3,'90-APR-PF',1,3.25),(83085,4,'51-ATW',1,1.15),(83085,5,'26-8x10',1,15.95),(83437,1,'90-LEM-11',1,3.25),(83437,2,'51-APR',1,1.15),(84258,1,'51-APP',1,1.15),(84258,2,'51-BC',1,1.95),(84665,1,'90-BER-11',1,3.25),(85492,1,'70-M-CH-DZ',2,2.50),(85492,2,'25-STR-9',1,11.95),(85492,3,'90-BLU-11',1,3.25),(85858,1,'20-CA-7.5',1,15.95),(85858,2,'70-M-VA-SM-DZ',1,1.15),(85858,3,'51-BLU',1,1.15),(85881,1,'90-APP-11',1,3.25),(86085,1,'50-APR',1,1.45),(86085,2,'50-APP',1,1.45),(86085,3,'90-APR-PF',1,3.25),(86085,4,'51-ATW',1,1.15),(86162,1,'51-BLU',1,1.15),(86162,2,'50-ALM',2,2.90),(86162,3,'50-CHS',1,1.75),(86162,4,'70-TU',1,1.25),(86678,1,'70-M-VA-SM-DZ',1,1.15),(86678,2,'90-LEM-11',1,3.25),(86861,1,'20-BC-L-10',1,8.95),(86861,2,'50-CHS',1,1.75),(86861,3,'70-GON',1,1.15),(86861,4,'51-BLU',1,1.15),(87454,1,'90-APIE-10',1,5.25),(87454,2,'50-APP',1,1.45),(88626,1,'90-APP-11',1,3.25),(89182,1,'51-APR',1,1.15),(89182,2,'51-APP',1,1.15),(89182,3,'70-LEM',1,0.79),(89182,4,'50-ALM',1,1.45),(89182,5,'45-CH',1,3.25),(89588,1,'90-BLK-PF',1,3.25),(89638,1,'70-M-CH-DZ',2,2.50),(89638,3,'50-ALM',1,1.45),(89638,4,'90-CH-PF',1,3.75),(89937,1,'51-BLU',1,1.15),(89937,2,'51-BC',1,1.95),(89937,3,'90-BER-11',1,3.25),(89937,4,'70-R',1,1.09),(91192,1,'51-APP',1,1.15),(91192,2,'51-ATW',1,1.15),(91192,3,'50-APP',1,1.45),(91937,1,'51-BC',1,1.95),(91937,2,'51-APR',1,1.15),(92252,1,'70-GON',1,1.15),(92252,2,'51-ATW',1,1.15),(92252,3,'51-BLU',1,1.15),(92252,4,'45-VA',1,3.25),(92252,5,'70-M-VA-SM-DZ',1,1.15),(94371,1,'51-BLU',1,1.15),(95514,1,'45-CH',1,3.25),(95514,2,'46-11',1,13.49),(95514,3,'70-MAR',1,1.25),(95514,4,'51-APP',1,1.15),(95962,1,'90-APR-PF',1,3.25),(95962,2,'90-CHR-11',1,3.25),(95962,3,'50-CH',1,1.75),(95962,4,'45-VA',1,3.25),(96258,1,'90-CHR-11',1,3.25),(96258,2,'90-BLK-PF',1,3.25),(96258,3,'24-8x10',1,15.95),(96258,4,'70-LEM',1,0.79),(96402,1,'50-ALM',1,1.45),(96402,2,'20-CA-7.5',1,15.95),(96402,3,'90-APP-11',1,3.25),(96430,1,'90-PEC-11',1,3.75),(96531,1,'24-8x10',1,15.95),(96531,2,'50-APP',1,1.45),(96531,3,'70-GA',1,1.15),(96531,4,'50-CHS',1,1.75),(96619,1,'90-BLK-PF',1,3.25),(96761,1,'26-8x10',1,15.95),(96761,2,'70-LEM',1,0.79),(96761,3,'50-CHS',2,3.50),(97097,1,'70-MAR',1,1.25),(98806,1,'26-8x10',1,15.95),(98806,2,'50-APR',1,1.45),(98806,3,'90-APIE-10',1,5.25),(98806,4,'51-APP',1,1.15),(99002,1,'50-CHS',1,1.75),(99002,2,'45-VA',1,3.25),(99058,1,'50-CHS',1,1.75),(99058,2,'90-BLU-11',1,3.25),(99058,3,'51-BLU',1,1.15),(99058,4,'45-CH',1,3.25),(99058,5,'90-CHR-11',1,3.25),(99994,1,'25-STR-9',1,11.95),(99994,2,'26-8x10',1,15.95),(99994,3,'90-PEC-11',1,3.75),(99994,4,'50-CH',1,1.75);

INSERT INTO `Sale` VALUES (1,'2007-10-07','2007-10-09',30),(4,'2007-10-15','2007-10-28',25),(5,'2007-10-25','2007-10-27',5),(6,'2007-10-25','2007-10-30',90);

INSERT INTO `ProductXSale` VALUES ('20-BC-C-10',1),('46-11',1),('20-BC-L-10',1),('90-APIE-10',1),('90-APIE-10',4),('46-11',4),('46-11',5),('90-ALM-I',5),('45-CH',6),('45-CO',6),('90-ALM-I',6);

INSERT INTO `Rating` VALUES (1,'20-BC-C-10',5,'Mediocre cake.'),(2,'20-BC-L-10',8,'Mediocre, yet lemony, cake.'),(2,'70-R',9,'Can\'t go wrong!'),(2,'20-CA-7.5',1,'I don\'t even know what casino cake is.'),(8,'90-APIE-10',9,'Yea, this is OK.'),(3,'90-APIE-10',9,'Not bad'),(3,'24-8x10',5,'Or opera cake either.'),(4,'46-11',3,'Cake was not empirically good.'),(4,'90-ALM-I',2,'Almond is not meant to be tart.'),(5,'90-APIE-10',10,'Classic!'),(6,'90-APIE-10',10,'Superb!'),(7,'90-ALM-I',10,'Amazing!');

SELECT productId 'ID', sum(qty) 'Purchases'
FROM LineItem
GROUP BY ID
HAVING Purchases > 1
ORDER BY ID;

select p1.id ID
from Product p1 left join Product p2
      on p2.price < p1.price
where p2.price is null;