-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: bdcarniceria
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `tbdistrito`
--

DROP TABLE IF EXISTS `tbdistrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbdistrito` (
  `idDistrito` int NOT NULL AUTO_INCREMENT,
  `nombreDistrito` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idCanton` int DEFAULT NULL,
  PRIMARY KEY (`idDistrito`),
  KEY `FKcmru33riglx1giuu7m2wo2moq` (`idCanton`),
  CONSTRAINT `FKcmru33riglx1giuu7m2wo2moq` FOREIGN KEY (`idCanton`) REFERENCES `tbcanton` (`idCanton`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdistrito`
--

LOCK TABLES `tbdistrito` WRITE;
/*!40000 ALTER TABLE `tbdistrito` DISABLE KEYS */;
INSERT INTO `tbdistrito` VALUES (1,'Limón',5),(2,'Valle La Estrella',5),(3,'Río Blanco',5),(4,'Matama',5),(5,'Guápiles',1),(6,'Jiménez',1),(7,'La Rita',1),(8,'Roxana',1),(9,'Cariari',1),(10,'Colorado',1),(11,'La Colonia',1),(12,'Siquirres',3),(13,'Pacuarito',3),(14,'Florida',3),(15,'Germania',3),(16,'El Cairo',3),(17,'Alegría',3),(18,'Reventazón',3),(19,'Bratsi',6),(20,'Sixaola',6),(21,'Cahuita',6),(22,'Telire',6),(23,'Matina',4),(24,'Batán',4),(25,'Carrandi',4),(26,'Guácimo',2),(27,'Mercedes',2),(28,'Pocora',2),(29,'Río Jiménez',2),(30,'Duacarí',2),(31,'Carmen',7),(32,'Merced',7),(33,'Hospital',7),(34,'Catedral',7),(35,'San Francisco de Dos Ríos',7),(36,'La Uruca',7),(37,'Mata Redonda',7),(38,'Pavas',7),(39,'Hatillo',7),(40,'San Sebastián',7),(41,'Escazú',8),(42,'San Antonio',8),(43,'San Rafael',8),(44,'Desamparados',9),(45,'San Miguel',9),(46,'San Juan de Dios',9),(47,'San Rafael Arriba',9),(48,'San Antonio',9),(49,'Frailes',9),(50,'Patarrá',9),(51,'San Cristóbal',9),(52,'Rosario',9),(53,'Damas',9),(54,'San Rafael Abajo',9),(55,'Gravilias',9),(56,'Los Guido',9),(57,'Santiago',10),(58,'Mercedes Sur',10),(59,'Barbacoas',10),(60,'Grifo Alto',10),(61,'San Rafael',10),(62,'Candelarita',10),(63,'Desamparaditos',10),(64,'San Antonio',10),(65,'Chires',10),(66,'San Marcos',11),(67,'San Lorenzo',11),(68,'San Carlos',11),(69,'Aserrí',12),(70,'Tarbaca',12),(71,'Vuelta de Jorco',12),(72,'San Gabriel',12),(73,'Legua',12),(74,'Monterrey',12),(75,'Salitrillos',12),(76,'Colón',13),(77,'Guayabo',13),(78,'Tabarcia',13),(79,'Piedras Negras',13),(80,'Picagres',13),(81,'Jaris',13),(82,'Quitirrisí',13),(83,'Guadalupe',14),(84,'San Francisco',14),(85,'Calle Blancos',14),(86,'Mata de Plátano',14),(87,'Ipís',14),(88,'Rancho Redondo',14),(89,'Purral',14),(90,'Santa Ana',15),(91,'Salitral',15),(92,'Pozos',15),(93,'Uruca',15),(94,'Piedades',15),(95,'Brasil',15),(96,'Alajuelita',16),(97,'San Josecito',16),(98,'San Antonio',16),(99,'Concepción',16),(100,'San Felipe',16),(101,'San Isidro',17),(102,'San Rafael',17),(103,'Dulce Nombre de Jesús',17),(104,'Patalillo',17),(105,'Cascajal',17),(106,'San Ignacio',18),(107,'Guaitil',18),(108,'Palmichal',18),(109,'Cangrejal',18),(110,'Sabanillas',18),(111,'San Juan',19),(112,'Cinco Esquinas',19),(113,'Anselmo Llorente',19),(114,'León XIII',19),(115,'Colima',19),(116,'San Vicente',20),(117,'San Jerónimo',20),(118,'La Trinidad',20),(119,'San Pedro',21),(120,'Sabanilla',21),(121,'Mercedes',21),(122,'San Rafael',21),(123,'San Pablo',22),(124,'San Pedro',22),(125,'San Juan de Mata',22),(126,'San Luis',22),(127,'Carara',22),(128,'Santa María',23),(129,'Jardín',23),(130,'Copey',23),(131,'Curridabat',24),(132,'Granadilla',24),(133,'Sánchez',24),(134,'Tirrases',24),(135,'San Isidro de El General',25),(136,'El General',25),(137,'Daniel Flores',25),(138,'Rivas',25),(139,'San Pedro',25),(140,'Platanares',25),(141,'Pejibaye',25),(142,'Cajón',25),(143,'Barú',25),(144,'Río Nuevo',25),(145,'Páramo',25),(146,'La Amistad',25),(147,'San Pablo',26),(148,'San Andrés',26),(149,'Llano Bonito',26),(150,'San Isidro',26),(151,'Santa Cruz',26),(152,'San Antonio',26);
/*!40000 ALTER TABLE `tbdistrito` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-21 18:39:32
