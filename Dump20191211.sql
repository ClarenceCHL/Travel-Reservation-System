-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: database-4-joe.cr5cf4b6w6l2.us-east-2.rds.amazonaws.com    Database: BarBeerDrinkerSample
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraftID` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `airlineID` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`aircraftID`),
  KEY `airlineID` (`airlineID`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `airline` (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `airlineID` varchar(15) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airportID` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bars`
--

DROP TABLE IF EXISTS `bars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bars` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `license` varchar(7) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bars`
--

LOCK TABLES `bars` WRITE;
/*!40000 ALTER TABLE `bars` DISABLE KEYS */;
INSERT INTO `bars` VALUES ('A.P. Stump\'s','MA12347','Boston',NULL,NULL),('Blue Angel','CA45678','San Francisco',NULL,NULL),('Blue Tattoo','CA45678','San Francisco','415-567-1289','1500 Market St.'),('Britannia Arms','MA12346','Boston','345-567-1289',NULL),('Cabana','CA45678','San Francisco',NULL,'1200 California Ave.'),('Caravan','IL12345','Chicago',NULL,NULL),('Club 175','CA45678','San Francisco','415-567-1289',NULL),('Coconut Willie\'s Cocktail Lounge','CA45678','San Francisco','415-567-1289',NULL),('Eulipia','IL12346','Chicago','123-456-7890','1060 West Addison'),('Gecko Grill','IL12348','Chicago',NULL,'1060 West Addison'),('Giza Hookah Lounge','IL12349','Chicago','345-678-9012',NULL),('Hedley Club','NY12345','New York',NULL,'161st St and River Ave'),('Il Fornaio','NY12346','New York',NULL,'161st St and River Ave'),('Seven Bamboo','NY12347','New York',NULL,'161st St and River Ave'),('The B-Hive','MA12348','Boston','345-567-1280',NULL),('The Backbeat','CA45678','San Francisco','415-567-1289',NULL),('The Blank Club','MA12349','Boston','345-567-1281',NULL),('The Shark and Rose','MA12345','Boston',NULL,NULL);
/*!40000 ALTER TABLE `bars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beers`
--

DROP TABLE IF EXISTS `beers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beers` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `manf` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beers`
--

LOCK TABLES `beers` WRITE;
/*!40000 ALTER TABLE `beers` DISABLE KEYS */;
INSERT INTO `beers` VALUES ('Blue Moon','Coors Brewing Company'),('Budweiser','Anheuser-Busch'),('Creamy Dark','Jacob Leinenkugel Brewing Company'),('Extra Gold','Coors Brewing Company'),('Hefeweizen','Jacob Leinenkugel Brewing Company'),('Hefeweizen Doppelbock','Jacob Leinenkugel Brewing Company'),('Heiniken','Heiniken Inernational'),('ICEHOUSE','Plank Road Brewery'),('Killian\'s','Coors Brewing Company'),('Michelob Amber Bock','Anheuser-Busch'),('Michelob Golden Draft','Anheuser-Busch'),('Michelob Golden Draft Light','Anheuser-Busch'),('Michelob ULTRA','Anheuser-Busch'),('Original Premium','Jacob Leinenkugel Brewing Company'),('Original Premium Lager','Jacob Leinenkugel Brewing Company'),('Original Premium Lager Dog','Plank Road Brewery'),('Sauza Diablo','Miller Brewing Company'),('Southpaw Light','Plank Road Brewery'),('Stolichnaya Citrona','Miller Brewing Company'),('Zima','Coors Brewing Company'),('Zima Citrus','Coors Brewing Company');
/*!40000 ALTER TABLE `beers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `days`
--

DROP TABLE IF EXISTS `days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `days` (
  `dayNumber` varchar(1) NOT NULL,
  PRIMARY KEY (`dayNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `days`
--

LOCK TABLES `days` WRITE;
/*!40000 ALTER TABLE `days` DISABLE KEYS */;
/*!40000 ALTER TABLE `days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinkers`
--

DROP TABLE IF EXISTS `drinkers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drinkers` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinkers`
--

LOCK TABLES `drinkers` WRITE;
/*!40000 ALTER TABLE `drinkers` DISABLE KEYS */;
INSERT INTO `drinkers` VALUES ('Bob','San Francisco','415-234-6789',NULL),('Erik','San Francisco','415-234-6789',NULL),('Herb','Boston',NULL,NULL),('Jesse','San Francisco','415-234-6789',NULL),('John','Chicago',NULL,'1060 West Addison'),('Justin','Boston',NULL,NULL),('Mike','Boston',NULL,NULL),('Rebecca','Chicago',NULL,'1060 West Addison'),('Thomas ','New York',NULL,'160 River Ave'),('Tom','Chicago',NULL,'1060 West Addison'),('Vince','New York','234-456-7890','161st St and River Ave');
/*!40000 ALTER TABLE `drinkers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fliesOn`
--

DROP TABLE IF EXISTS `fliesOn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fliesOn` (
  `dayNumber` varchar(1) NOT NULL,
  `airlineID` varchar(15) NOT NULL,
  `flightNumber` varchar(10) NOT NULL,
  PRIMARY KEY (`dayNumber`,`airlineID`,`flightNumber`),
  KEY `airlineID` (`airlineID`,`flightNumber`),
  CONSTRAINT `fliesOn_ibfk_1` FOREIGN KEY (`dayNumber`) REFERENCES `days` (`dayNumber`),
  CONSTRAINT `fliesOn_ibfk_2` FOREIGN KEY (`airlineID`, `flightNumber`) REFERENCES `flights` (`airlineID`, `flightNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fliesOn`
--

LOCK TABLES `fliesOn` WRITE;
/*!40000 ALTER TABLE `fliesOn` DISABLE KEYS */;
/*!40000 ALTER TABLE `fliesOn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `airlineID` varchar(15) NOT NULL,
  `flightNumber` varchar(10) NOT NULL,
  `departAirportID` varchar(50) DEFAULT NULL,
  `destinationAirportID` varchar(50) DEFAULT NULL,
  `aircraftID` varchar(50) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `departTime` time DEFAULT NULL,
  `arriveTime` time DEFAULT NULL,
  `economyFare` decimal(19,4) DEFAULT NULL,
  `businessFare` decimal(19,4) DEFAULT NULL,
  `firstFare` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`airlineID`,`flightNumber`),
  KEY `departAirportID` (`departAirportID`),
  KEY `destinationAirportID` (`destinationAirportID`),
  KEY `aircraftID` (`aircraftID`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `airline` (`airlineID`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`departAirportID`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`destinationAirportID`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`aircraftID`) REFERENCES `aircraft` (`aircraftID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frequents`
--

DROP TABLE IF EXISTS `frequents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frequents` (
  `drinker` varchar(50) NOT NULL DEFAULT '',
  `bar` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`drinker`,`bar`),
  KEY `fk_frequents_bar` (`bar`),
  CONSTRAINT `fk_frequents_bar` FOREIGN KEY (`bar`) REFERENCES `bars` (`name`),
  CONSTRAINT `fk_frequents_drinker` FOREIGN KEY (`drinker`) REFERENCES `drinkers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frequents`
--

LOCK TABLES `frequents` WRITE;
/*!40000 ALTER TABLE `frequents` DISABLE KEYS */;
/*!40000 ALTER TABLE `frequents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `drinker` varchar(50) NOT NULL DEFAULT '',
  `beer` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`drinker`,`beer`),
  KEY `fk_likes_beer` (`beer`),
  CONSTRAINT `fk_likes_beer` FOREIGN KEY (`beer`) REFERENCES `beers` (`name`),
  CONSTRAINT `fk_likes_drinker` FOREIGN KEY (`drinker`) REFERENCES `drinkers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES ('John','Blue Moon'),('Mike','Blue Moon'),('John','Budweiser'),('Mike','Budweiser'),('John','Creamy Dark'),('Mike','Creamy Dark'),('Mike','Hefeweizen'),('John','Killian\'s'),('John','Michelob Golden Draft'),('Mike','Michelob Golden Draft Light'),('John','Original Premium'),('Mike','Original Premium Lager'),('Jesse','Original Premium Lager Dog'),('Mike','Original Premium Lager Dog'),('John','Stolichnaya Citrona');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
  `aircraftID` varchar(50) NOT NULL,
  `seatNumber` varchar(3) NOT NULL,
  `seatClass` varchar(15) DEFAULT NULL,
  `numTotalSeats` varchar(3) DEFAULT NULL,
  `numTotalFirstSeats` varchar(3) DEFAULT NULL,
  `numTotalBusinessSeats` varchar(3) DEFAULT NULL,
  `numTotalEconomySeats` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`aircraftID`,`seatNumber`),
  CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`aircraftID`) REFERENCES `aircraft` (`aircraftID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sells`
--

DROP TABLE IF EXISTS `sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sells` (
  `bar` varchar(50) NOT NULL DEFAULT '',
  `beer` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`bar`,`beer`),
  KEY `fk_sells_beer` (`beer`),
  CONSTRAINT `fk_sells_bar` FOREIGN KEY (`bar`) REFERENCES `bars` (`name`),
  CONSTRAINT `fk_sells_beer` FOREIGN KEY (`beer`) REFERENCES `beers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
INSERT INTO `sells` VALUES ('A.P. Stump\'s','Hefeweizen',6.00),('Blue Angel','Hefeweizen Doppelbock',5.50),('Blue Angel','Original Premium Lager Dog',6.25),('Blue Tattoo','Killian\'s',6.00),('Britannia Arms','Budweiser',6.50),('Cabana','Budweiser',5.00),('Cabana','Heiniken',5.00),('Caravan','Budweiser',5.50),('Caravan','Heiniken',5.50),('Caravan','Original Premium Lager Dog',3.50),('Club 175','Budweiser',4.50),('Coconut Willie\'s Cocktail Lounge','Budweiser',3.25),('Eulipia','Hefeweizen Doppelbock',4.50),('Gecko Grill','Budweiser',3.00),('Giza Hookah Lounge','Stolichnaya Citrona',6.00),('Hedley Club','Hefeweizen',8.00),('Seven Bamboo','Budweiser',2.50),('The B-Hive','Michelob Amber Bock',5.00),('The Backbeat','Killian\'s',3.50),('The Blank Club','Budweiser',5.50),('The Shark and Rose','Budweiser',4.50),('The Shark and Rose','Original Premium Lager Dog',5.50);
/*!40000 ALTER TABLE `sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticketNumber` varchar(10) NOT NULL,
  `roundTrip` varchar(1) DEFAULT NULL,
  `bookingFee` decimal(19,4) DEFAULT NULL,
  `totalFare` decimal(19,4) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ticketNumber`),
  KEY `username` (`username`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `airlineID` varchar(15) NOT NULL,
  `flightNumber` varchar(10) NOT NULL,
  `aircraftID` varchar(50) DEFAULT NULL,
  `ticketNumber` varchar(10) NOT NULL,
  `assignedSeatNumber` varchar(3) DEFAULT NULL,
  `meal` varchar(20) DEFAULT NULL,
  `tripDate` date DEFAULT NULL,
  PRIMARY KEY (`airlineID`,`flightNumber`,`ticketNumber`),
  KEY `ticketNumber` (`ticketNumber`),
  KEY `aircraftID` (`aircraftID`,`assignedSeatNumber`),
  CONSTRAINT `trip_ibfk_1` FOREIGN KEY (`airlineID`, `flightNumber`) REFERENCES `flights` (`airlineID`, `flightNumber`),
  CONSTRAINT `trip_ibfk_2` FOREIGN KEY (`ticketNumber`) REFERENCES `ticket` (`ticketNumber`),
  CONSTRAINT `trip_ibfk_3` FOREIGN KEY (`aircraftID`, `assignedSeatNumber`) REFERENCES `seats` (`aircraftID`, `seatNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `representative` int(11) DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-11 23:36:19
