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
-- Table structure for table `tbcomentario`
--

DROP TABLE IF EXISTS `tbcomentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcomentario` (
  `idComentario` int NOT NULL AUTO_INCREMENT,
  `descripcionComentario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaComentario` datetime DEFAULT NULL,
  `idUsuario` int DEFAULT NULL,
  `numCalificacion` int DEFAULT NULL,
  `verificacion` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idComentario`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbcomentario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcomentario`
--

LOCK TABLES `tbcomentario` WRITE;
/*!40000 ALTER TABLE `tbcomentario` DISABLE KEYS */;
INSERT INTO `tbcomentario` VALUES (4,'Descripción actualizada22','2024-10-30 12:35:30',6,5,_binary ''),(5,'Este es un comentario de prueba 2','2024-10-29 22:56:00',6,5,_binary ''),(6,'Este es un comentario de prueba 2','2024-10-29 23:07:15',6,5,_binary ''),(7,'Este es un comentario de prueba 2','2024-10-29 23:09:18',6,5,_binary '\0'),(8,'Este es un comentario de prueba 2','2024-10-29 23:11:39',6,5,_binary ''),(9,'Este es un comentario de prueba 2','2024-10-29 23:18:17',6,5,_binary '\0'),(10,'Este es un comentario de prueba 2','2024-10-29 23:18:29',6,5,_binary '\0'),(11,'Este es un comentario de prueba','2024-10-30 09:21:53',11,5,_binary '\0'),(12,'Este es un comentario de prueba.','2024-10-30 10:30:13',11,5,_binary '\0'),(13,'Este es un comentario de prueba.','2024-10-30 11:25:28',11,5,_binary '\0'),(14,'Este es un comentario de prueba.','2024-10-30 11:28:19',11,5,_binary '\0'),(15,'Este es un comentario de prueba.','2024-10-30 11:28:37',11,5,_binary ''),(16,'Este es un comentario de prueba.','2024-10-30 11:33:31',11,5,_binary '\0'),(17,'Este es un comentario de prueba.','2024-10-30 12:26:34',11,5,_binary '\0'),(19,'dwdw','2024-11-04 21:12:48',11,2,_binary ''),(20,'malo','2024-12-11 21:34:47',11,3,_binary '\0'),(21,'zzzz','2024-12-11 21:41:52',11,1,_binary '\0');
/*!40000 ALTER TABLE `tbcomentario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-21 18:39:31
