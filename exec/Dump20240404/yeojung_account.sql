-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: j10c203.p.ssafy.io    Database: yeojung
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.17-MariaDB-1:10.6.17+maria~ubu2004

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_no` varchar(20) NOT NULL,
  `balance` bigint(20) DEFAULT NULL,
  `bank_code` varchar(255) DEFAULT NULL,
  `is_primary_account` bit(1) DEFAULT b'1',
  `kakao_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_no`),
  KEY `FKdxmlryki8kbjx8lf6wvlgyfl2` (`kakao_id`),
  CONSTRAINT `FKdxmlryki8kbjx8lf6wvlgyfl2` FOREIGN KEY (`kakao_id`) REFERENCES `member` (`kakao_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('0011280060835751',14252200,'001',_binary '\0','3389826401'),('0011536510785719',74453100,'001',_binary '','3414662693'),('001153777825234',68342542,'001',_binary '\0','3388366548'),('0011879770129793',0,'001',_binary '','3394990331'),('0012098491099710',69576762,'001',_binary '\0','3394990331'),('0012879165527892',5000000,'001',_binary '\0','3394990331'),('0012905523126831',0,'001',_binary '\0','3394990331'),('0013226797057050',64583800,'001',_binary '','3411453115'),('0013262556324238',33694500,'001',_binary '\0','3412806386'),('0013330756102526',0,NULL,_binary '',NULL),('001367035538944',1000000,'001',_binary '\0','3412806386'),('001367471366450',5000000,'001',_binary '\0','3412806386'),('0013681914618747',0,NULL,_binary '',NULL),('0013939111471083',31186010,'001',_binary '\0','3388366548'),('0014007938414788',5000000,'001',_binary '\0','3386029769'),('0014108396583753',19998977500,'001',_binary '','3412806386'),('0014110640623874',63130400,'001',_binary '\0','3412806386'),('0014147485618377',70140000,'001',_binary '\0','3389826401'),('0014232958156522',14240800,'001',_binary '\0','3389826401'),('0014429531193700',4443130,'001',_binary '\0','3388366548'),('001454421264568',5000000,'001',_binary '\0','3389826401'),('0014582981966326',0,NULL,_binary '',NULL),('0014633501678708',99995416182,'001',_binary '\0','3388366548'),('0014773820196051',5000000,'001',_binary '\0','3412806386'),('0014809798778077',25474800,'001',_binary '\0','3386029769'),('0014969790145470',13886260,'001',_binary '\0','3388366548'),('0015393093160048',0,'001',_binary '\0','3386029769'),('001541163756335',67918900,'001',_binary '\0','3394990331'),('001544361088848',1016920,'001',_binary '\0','3411453115'),('0015465339310274',38722800,'001',_binary '\0','3394990331'),('0015519456319586',0,NULL,_binary '',NULL),('0015619628753498',86542000,'001',_binary '\0','3386029769'),('0015974296748329',5000000,'001',_binary '\0','3394990331'),('0016005971673393',1931726,'001',_binary '\0','3386029769'),('0016457072710786',67115224,'001',_binary '\0','3386029769'),('0016468284793083',13886260,'001',_binary '\0','3388366548'),('0016749361766241',27748400,'001',_binary '\0','3389826401'),('001697924603612',64252200,'001',_binary '\0','3389826401'),('0016994600384842',90159340,'001',_binary '\0','3388366548'),('001706871648142',25600200,'001',_binary '\0','3386029769'),('0017132665076993',4443130,'001',_binary '','3388366548'),('001758971213706',69254000,'001',_binary '\0','3412806386'),('0018005695023725',0,'001',_binary '','3415903293'),('0018264802913642',2777919,'001',_binary '','3389826401'),('0018699235924566',100000996540,'001',_binary '\0','3388366548'),('0018911092350149',1000000,'001',_binary '','3416479939'),('0019057006876864',4245800,'001',_binary '','3386029769'),('0019185453279509',0,NULL,_binary '',NULL),('0019259108001029',5000000,'001',_binary '\0','3394990331'),('0019364819065423',0,'001',_binary '\0','3394990331'),('0019428568137625',0,'001',_binary '\0','3414662693'),('0019544566796567',999999887666,'001',_binary '\0','3394990331'),('0019832487833337',5000000,'001',_binary '\0','3412806386'),('0019913337777808',0,'001',_binary '\0','3412806386');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-04  9:00:18
