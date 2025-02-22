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
-- Table structure for table `tbusuario`
--

DROP TABLE IF EXISTS `tbusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbusuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `cedulaUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contraseniaUsuario` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `correoUsuario` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `nombreUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primerApellido` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `segundoApellido` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefonoUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idDireccion` int DEFAULT NULL,
  `idRol` int DEFAULT NULL,
  `estadoUsuario` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `FK2tbdw6lsgbsdrhyex64u5kbij` (`idDireccion`),
  KEY `FK6dgi775fekruot59lqiv650ns` (`idRol`),
  CONSTRAINT `FK2tbdw6lsgbsdrhyex64u5kbij` FOREIGN KEY (`idDireccion`) REFERENCES `tbdireccion` (`idDireccion`),
  CONSTRAINT `FK6dgi775fekruot59lqiv650ns` FOREIGN KEY (`idRol`) REFERENCES `tbrol` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusuario`
--

LOCK TABLES `tbusuario` WRITE;
/*!40000 ALTER TABLE `tbusuario` DISABLE KEYS */;
INSERT INTO `tbusuario` VALUES (6,'703100064','$2a$12$fBMZLlt6aCS9iNemYH7h0e8m/YexlGy.13W2GTCFbnHLLe6fyTqOG','jsandi1299@gmail.com','2004-08-09','Jamel','Sandí','Anderson','88955772',13,3,_binary ''),(11,NULL,'$2a$12$H7xEK8HgTEGRCaE4flNwL.E1VyjkxeENA7DB9bwB85xUn6S4A0w0q','dilan@gmail.com',NULL,'Dilan','Gutiérrez','Hérnanandez',NULL,15,2,_binary ''),(12,'7031000222','$2a$12$woA1cDNHz2UW.Ek3.qyMwuU6qwdzaWkhslWgKGjOjXK5dH8xf.QGy','glend@gmail.com','2004-08-09','Glend','Rojas','Alvarado','88955771',16,2,_binary ''),(14,NULL,'$2a$12$//YmSKyCUaOul9TXIWPZEO9gr5yyzKc00AG8Wmi8IQUqy9dPPaqwK','jsandi12199@gmail.com',NULL,'JamelZito','prueba','Sandi',NULL,18,3,_binary ''),(23,NULL,'$2a$12$ARcwI6LAA/et4dwOF1QC9.ysaT65uDNz8VBdcblaYooyEQpoj/0YG','cucho@gmail.com',NULL,'cucho','Rojas','Alvarado',NULL,27,3,_binary '');
/*!40000 ALTER TABLE `tbusuario` ENABLE KEYS */;
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
