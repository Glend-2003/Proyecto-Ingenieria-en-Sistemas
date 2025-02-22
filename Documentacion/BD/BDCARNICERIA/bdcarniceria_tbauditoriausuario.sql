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
-- Table structure for table `tbauditoriausuario`
--

DROP TABLE IF EXISTS `tbauditoriausuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbauditoriausuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `cedulaUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contraseniaUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `correoUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `nombreUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primerApellido` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `segundoApellido` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefonoUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idDireccion` int DEFAULT NULL,
  `idRol` int DEFAULT NULL,
  `estadoUsuario` tinyint DEFAULT NULL,
  `accionUsuario` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaModificacionUsuario` date DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbauditoriausuario`
--

LOCK TABLES `tbauditoriausuario` WRITE;
/*!40000 ALTER TABLE `tbauditoriausuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbauditoriausuario` ENABLE KEYS */;
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
