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
-- Table structure for table `tbauditoriapedido`
--

DROP TABLE IF EXISTS `tbauditoriapedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbauditoriapedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `montoTotalPedido` decimal(10,2) DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `estadoPedido` tinyint DEFAULT NULL,
  `idCarrito` int DEFAULT NULL,
  `idTipoPago` int DEFAULT NULL,
  `accionPedido` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaModificacionPedido` date DEFAULT NULL,
  PRIMARY KEY (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbauditoriapedido`
--

LOCK TABLES `tbauditoriapedido` WRITE;
/*!40000 ALTER TABLE `tbauditoriapedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbauditoriapedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbauditoriaproducto`
--

DROP TABLE IF EXISTS `tbauditoriaproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbauditoriaproducto` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombreProducto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imgProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `montoPrecioProducto` decimal(10,2) DEFAULT NULL,
  `descripcionProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoProducto` tinyint DEFAULT NULL,
  `accionProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaModificacionProducto` date DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbauditoriaproducto`
--

LOCK TABLES `tbauditoriaproducto` WRITE;
/*!40000 ALTER TABLE `tbauditoriaproducto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbauditoriaproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbauditoriapromocion`
--

DROP TABLE IF EXISTS `tbauditoriapromocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbauditoriapromocion` (
  `idPromocion` int NOT NULL AUTO_INCREMENT,
  `descripcionProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `montoPromocion` decimal(10,2) DEFAULT NULL,
  `estadoPromocion` tinyint DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `accionPromocion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaModificacionPromocion` date DEFAULT NULL,
  PRIMARY KEY (`idPromocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbauditoriapromocion`
--

LOCK TABLES `tbauditoriapromocion` WRITE;
/*!40000 ALTER TABLE `tbauditoriapromocion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbauditoriapromocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbauditoriausuario`
--

DROP TABLE IF EXISTS `tbauditoriausuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbauditoriausuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `cedulaUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contraseniaUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `correoUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `nombreUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primerApellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `segundoApellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefonoUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idDireccion` int DEFAULT NULL,
  `idRol` int DEFAULT NULL,
  `estadoUsuario` tinyint DEFAULT NULL,
  `accionUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
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

--
-- Table structure for table `tbcanton`
--

DROP TABLE IF EXISTS `tbcanton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcanton` (
  `idCanton` int NOT NULL AUTO_INCREMENT,
  `nombreCanton` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idProvincia` int DEFAULT NULL,
  PRIMARY KEY (`idCanton`),
  KEY `FK7k27spfr0xmfgd7t6f9yw0chf` (`idProvincia`),
  CONSTRAINT `FK7k27spfr0xmfgd7t6f9yw0chf` FOREIGN KEY (`idProvincia`) REFERENCES `tbprovincia` (`idProvincia`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcanton`
--

LOCK TABLES `tbcanton` WRITE;
/*!40000 ALTER TABLE `tbcanton` DISABLE KEYS */;
INSERT INTO `tbcanton` VALUES (1,'Pococí',7),(2,'Guácimo',7),(3,'Siquirres',7),(4,'Matina',7),(5,'Limón',7),(6,'Talamanca',7),(7,'San José',1),(8,'Escazú',1),(9,'Desamparados',1),(10,'Puriscal',1),(11,'Tarrazú',1),(12,'Aserrí',1),(13,'Mora',1),(14,'Goicoechea',1),(15,'Santa Ana',1),(16,'Alajuelita',1),(17,'Vázquez de Coronado',1),(18,'Acosta',1),(19,'Tibás',1),(20,'Moravia',1),(21,'Montes de Oca',1),(22,'Turrubares',1),(23,'Dota',1),(24,'Curridabat',1),(25,'Pérez Zeledón',1),(26,'León Cortés Castro',1),(27,'San Ramón',2),(28,'Grecia',2),(29,'San Mateo',2),(30,'Atenas',2),(31,'Naranjo',2),(32,'Palmares',2),(33,'Poás',2),(34,'Orotina',2),(35,'San Carlos',2),(36,'Zarcero',2),(37,'Valverde Vega',2),(38,'Upala',2),(39,'Los Chiles',2),(40,'Guatuso',2),(41,'Río Cuarto',2),(42,'Paraíso',3),(43,'La Unión',3),(44,'Jiménez',3),(45,'Turrialba',3),(46,'Alvarado',3),(47,'Oreamuno',3),(48,'El Guarco',3),(49,'Barva',4),(50,'Santo Domingo',4),(51,'Santa Bárbara',4),(52,'San Rafael',4),(53,'San Isidro',4),(54,'Belén',4),(55,'Flores',4),(56,'San Pablo',4),(57,'Sarapiquí',4),(58,'Liberia',5),(59,'Nicoya',5),(60,'Santa Cruz',5),(61,'Bagaces',5),(62,'Carrillo',5),(63,'Cañas',5),(64,'Abangares',5),(65,'Tilarán',5),(66,'Nandayure',5),(67,'La Cruz',5),(68,'Hojancha',5),(69,'Esparza',6),(70,'Buenos Aires',6),(71,'Montes de Oro',6),(72,'Osa',6),(73,'Quepos',6),(74,'Golfito',6),(75,'Coto Brus',6),(76,'Parrita',6),(77,'Corredores',6),(78,'Garabito',6),(79,'Monteverde',6),(80,'Puerto Jiménez',6),(81,'Alajuela',2),(82,'Cartago',3),(83,'Heredia',4),(84,'Puntarenas',6);
/*!40000 ALTER TABLE `tbcanton` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcarrito`
--

DROP TABLE IF EXISTS `tbcarrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcarrito` (
  `idCarrito` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `montoTotalCarrito` decimal(38,2) DEFAULT NULL,
  `estadoCarrito` tinyint(1) DEFAULT NULL,
  `cantidadCarrito` int DEFAULT NULL,
  PRIMARY KEY (`idCarrito`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbcarrito_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcarrito`
--

LOCK TABLES `tbcarrito` WRITE;
/*!40000 ALTER TABLE `tbcarrito` DISABLE KEYS */;
INSERT INTO `tbcarrito` VALUES (37,59,5000.00,0,1),(45,59,2500.00,0,1),(49,56,11500.00,0,2),(62,56,2222.00,0,1),(63,56,2500.00,0,1),(64,56,1500.00,0,1),(65,60,5000.00,0,1),(66,58,14000.00,0,3),(67,56,4444.00,1,1);
/*!40000 ALTER TABLE `tbcarrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcarritoproducto`
--

DROP TABLE IF EXISTS `tbcarritoproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcarritoproducto` (
  `idCarritoProducto` int NOT NULL AUTO_INCREMENT,
  `idCarrito` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `cantidadProducto` int DEFAULT NULL,
  PRIMARY KEY (`idCarritoProducto`),
  KEY `idCarrito` (`idCarrito`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `tbcarritoproducto_ibfk_1` FOREIGN KEY (`idCarrito`) REFERENCES `tbcarrito` (`idCarrito`) ON DELETE CASCADE,
  CONSTRAINT `tbcarritoproducto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcarritoproducto`
--

LOCK TABLES `tbcarritoproducto` WRITE;
/*!40000 ALTER TABLE `tbcarritoproducto` DISABLE KEYS */;
INSERT INTO `tbcarritoproducto` VALUES (72,37,13,1),(80,45,12,1),(87,49,11,1),(88,49,13,2),(104,62,8,1),(105,63,12,1),(106,64,11,1),(107,65,13,1),(108,66,11,1),(109,66,12,1),(110,66,13,2),(111,67,8,2);
/*!40000 ALTER TABLE `tbcarritoproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcategoria`
--

DROP TABLE IF EXISTS `tbcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcategoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `descripcionCategoria` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombreCategoria` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoCategoria` tinyint(1) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcategoria`
--

LOCK TABLES `tbcategoria` WRITE;
/*!40000 ALTER TABLE `tbcategoria` DISABLE KEYS */;
INSERT INTO `tbcategoria` VALUES (1,'Descripción actualizadasss','Nombre actualizado',1),(2,'Todas las partes de la res','Res',1),(3,'Todas las partes de la cerdo','Cerdo',1),(4,'Todas los tipos de mariscos','Marisco',1),(5,'Todos los tipos de embutidos','Embutidos',1),(6,'Todos los tipos de productos lácteoss','Lácteos',1),(7,'La mayoría de productos varios','Productos varios',1),(20,'descripcionnnnnnnnnn','prueba',0),(23,'afawfwadawdawd','awdad',1),(24,'Todo tipos de productos relacionados con el pollo','Pollo',0);
/*!40000 ALTER TABLE `tbcategoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcodigoverificacion`
--

DROP TABLE IF EXISTS `tbcodigoverificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcodigoverificacion` (
  `idCodigo` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `numCodigo` varchar(255) DEFAULT NULL,
  `fechaExpiracion` date DEFAULT NULL,
  PRIMARY KEY (`idCodigo`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbcodigoverificacion_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcodigoverificacion`
--

LOCK TABLES `tbcodigoverificacion` WRITE;
/*!40000 ALTER TABLE `tbcodigoverificacion` DISABLE KEYS */;
INSERT INTO `tbcodigoverificacion` VALUES (1,29,'319480',NULL),(2,30,'123432',NULL),(3,31,'441004',NULL),(4,32,'356493',NULL),(5,33,'292243',NULL),(6,34,'947661',NULL),(7,35,'947216',NULL),(24,52,'393498',NULL),(25,53,'098247',NULL),(26,54,'418492',NULL),(27,55,'271699',NULL),(28,56,'601504',NULL),(29,57,'515845',NULL),(30,58,'864579',NULL),(31,59,'241545',NULL),(32,60,'226381',NULL),(33,61,'513373',NULL),(34,62,'066376',NULL);
/*!40000 ALTER TABLE `tbcodigoverificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcomentario`
--

DROP TABLE IF EXISTS `tbcomentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcomentario` (
  `idComentario` int NOT NULL AUTO_INCREMENT,
  `descripcionComentario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaComentario` datetime DEFAULT NULL,
  `idUsuario` int DEFAULT NULL,
  `numCalificacion` int DEFAULT NULL,
  `verificacion` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idComentario`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbcomentario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcomentario`
--

LOCK TABLES `tbcomentario` WRITE;
/*!40000 ALTER TABLE `tbcomentario` DISABLE KEYS */;
INSERT INTO `tbcomentario` VALUES (4,'Descripción actualizada22','2024-10-30 12:35:30',6,5,_binary '\0'),(5,'Este es un comentario de prueba 2','2024-10-29 22:56:00',6,5,_binary ''),(6,'Este es un comentario de prueba 2','2024-10-29 23:07:15',6,5,_binary ''),(7,'Este es un comentario de prueba 2','2024-10-29 23:09:18',6,5,_binary '\0'),(8,'Este es un comentario de prueba 2','2024-10-29 23:11:39',6,5,_binary ''),(9,'Este es un comentario de prueba 2','2024-10-29 23:18:17',6,5,_binary '\0'),(10,'Este es un comentario de prueba 2','2024-10-29 23:18:29',6,5,_binary '\0'),(11,'Este es un comentario de prueba','2024-10-30 09:21:53',11,5,_binary '\0'),(12,'Este es un comentario de prueba.','2024-10-30 10:30:13',11,5,_binary '\0'),(13,'Este es un comentario de prueba.','2024-10-30 11:25:28',11,5,_binary '\0'),(14,'Este es un comentario de prueba.','2024-10-30 11:28:19',11,5,_binary '\0'),(15,'Este es un comentario de prueba.','2024-10-30 11:28:37',11,5,_binary '\0'),(16,'Este es un comentario de prueba.','2024-10-30 11:33:31',11,5,_binary '\0'),(17,'Este es un comentario de prueba.','2024-10-30 12:26:34',11,5,_binary '\0'),(19,'dwdw','2024-11-04 21:12:48',11,2,_binary ''),(20,'malo','2024-12-11 21:34:47',11,3,_binary '\0'),(21,'zzzz','2024-12-11 21:41:52',11,1,_binary '\0'),(22,'prueba 3','2025-02-26 15:57:08',11,2,_binary '\0'),(23,'Buenardooooooooooooo','2025-04-30 17:33:38',56,3,_binary ''),(24,'zzzz','2025-04-30 17:40:48',56,5,_binary '\0'),(25,'aaaa','2025-04-30 17:47:48',56,5,_binary '\0'),(26,'dwdwd','2025-04-30 17:49:03',56,5,_binary '\0'),(27,'Prueba\n','2025-04-30 17:49:34',56,5,_binary '\0'),(28,'Malardooooooooooo','2025-05-01 18:57:30',56,1,_binary ''),(29,'Comentario prueba con el profe','2025-05-05 19:06:08',56,5,_binary '');
/*!40000 ALTER TABLE `tbcomentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbdireccion`
--

DROP TABLE IF EXISTS `tbdireccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbdireccion` (
  `idDireccion` int NOT NULL AUTO_INCREMENT,
  `codigoPostalDireccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcionDireccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idDistrito` int DEFAULT NULL,
  PRIMARY KEY (`idDireccion`),
  KEY `FKp8gg1h5t049ujh0lbtip4y2ld` (`idDistrito`),
  CONSTRAINT `FKp8gg1h5t049ujh0lbtip4y2ld` FOREIGN KEY (`idDistrito`) REFERENCES `tbdistrito` (`idDistrito`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdireccion`
--

LOCK TABLES `tbdireccion` WRITE;
/*!40000 ALTER TABLE `tbdireccion` DISABLE KEYS */;
INSERT INTO `tbdireccion` VALUES (13,'1234','Urbanización el Tejar',26),(15,NULL,NULL,NULL),(16,'12345654654','Guacimoooo',3),(18,NULL,NULL,NULL),(20,NULL,NULL,NULL),(21,NULL,NULL,NULL),(22,NULL,NULL,NULL),(23,NULL,NULL,NULL),(24,NULL,NULL,NULL),(27,NULL,NULL,NULL),(32,NULL,NULL,NULL),(33,NULL,NULL,NULL),(34,NULL,NULL,NULL),(35,NULL,NULL,NULL),(36,NULL,NULL,NULL),(37,NULL,NULL,NULL),(38,NULL,NULL,NULL),(39,NULL,NULL,NULL),(40,NULL,NULL,NULL),(41,NULL,NULL,NULL),(42,NULL,NULL,NULL),(43,NULL,NULL,NULL),(44,NULL,NULL,NULL),(45,NULL,NULL,NULL),(46,NULL,NULL,NULL),(47,NULL,NULL,NULL),(48,NULL,NULL,NULL),(49,NULL,NULL,NULL),(50,NULL,NULL,NULL),(51,NULL,NULL,NULL),(52,NULL,NULL,NULL),(53,NULL,NULL,NULL),(54,NULL,NULL,NULL),(55,NULL,NULL,NULL),(56,NULL,NULL,NULL),(57,NULL,NULL,NULL),(58,NULL,NULL,NULL),(59,NULL,NULL,NULL),(60,'70201','San Luis de jimenez',6),(61,NULL,NULL,NULL),(62,NULL,NULL,NULL),(63,NULL,NULL,NULL),(64,NULL,NULL,NULL),(65,NULL,NULL,NULL),(66,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tbdireccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbdistrito`
--

DROP TABLE IF EXISTS `tbdistrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbdistrito` (
  `idDistrito` int NOT NULL AUTO_INCREMENT,
  `nombreDistrito` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idCanton` int DEFAULT NULL,
  PRIMARY KEY (`idDistrito`),
  KEY `FKcmru33riglx1giuu7m2wo2moq` (`idCanton`),
  CONSTRAINT `FKcmru33riglx1giuu7m2wo2moq` FOREIGN KEY (`idCanton`) REFERENCES `tbcanton` (`idCanton`)
) ENGINE=InnoDB AUTO_INCREMENT=493 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdistrito`
--

LOCK TABLES `tbdistrito` WRITE;
/*!40000 ALTER TABLE `tbdistrito` DISABLE KEYS */;
INSERT INTO `tbdistrito` VALUES (1,'Limón',5),(2,'Valle La Estrella',5),(3,'Río Blanco',5),(4,'Matama',5),(5,'Guápiles',1),(6,'Jiménez',1),(7,'La Rita',1),(8,'Roxana',1),(9,'Cariari',1),(10,'Colorado',1),(11,'La Colonia',1),(12,'Siquirres',3),(13,'Pacuarito',3),(14,'Florida',3),(15,'Germania',3),(16,'El Cairo',3),(17,'Alegría',3),(18,'Reventazón',3),(19,'Bratsi',6),(20,'Sixaola',6),(21,'Cahuita',6),(22,'Telire',6),(23,'Matina',4),(24,'Batán',4),(25,'Carrandi',4),(26,'Guácimo',2),(27,'Mercedes',2),(28,'Pocora',2),(29,'Río Jiménez',2),(30,'Duacarí',2),(31,'Carmen',7),(32,'Merced',7),(33,'Hospital',7),(34,'Catedral',7),(35,'San Francisco de Dos Ríos',7),(36,'La Uruca',7),(37,'Mata Redonda',7),(38,'Pavas',7),(39,'Hatillo',7),(40,'San Sebastián',7),(41,'Escazú',8),(42,'San Antonio',8),(43,'San Rafael',8),(44,'Desamparados',9),(45,'San Miguel',9),(46,'San Juan de Dios',9),(47,'San Rafael Arriba',9),(48,'San Antonio',9),(49,'Frailes',9),(50,'Patarrá',9),(51,'San Cristóbal',9),(52,'Rosario',9),(53,'Damas',9),(54,'San Rafael Abajo',9),(55,'Gravilias',9),(56,'Los Guido',9),(57,'Santiago',10),(58,'Mercedes Sur',10),(59,'Barbacoas',10),(60,'Grifo Alto',10),(61,'San Rafael',10),(62,'Candelarita',10),(63,'Desamparaditos',10),(64,'San Antonio',10),(65,'Chires',10),(66,'San Marcos',11),(67,'San Lorenzo',11),(68,'San Carlos',11),(69,'Aserrí',12),(70,'Tarbaca',12),(71,'Vuelta de Jorco',12),(72,'San Gabriel',12),(73,'Legua',12),(74,'Monterrey',12),(75,'Salitrillos',12),(76,'Colón',13),(77,'Guayabo',13),(78,'Tabarcia',13),(79,'Piedras Negras',13),(80,'Picagres',13),(81,'Jaris',13),(82,'Quitirrisí',13),(83,'Guadalupe',14),(84,'San Francisco',14),(85,'Calle Blancos',14),(86,'Mata de Plátano',14),(87,'Ipís',14),(88,'Rancho Redondo',14),(89,'Purral',14),(90,'Santa Ana',15),(91,'Salitral',15),(92,'Pozos',15),(93,'Uruca',15),(94,'Piedades',15),(95,'Brasil',15),(96,'Alajuelita',16),(97,'San Josecito',16),(98,'San Antonio',16),(99,'Concepción',16),(100,'San Felipe',16),(101,'San Isidro',17),(102,'San Rafael',17),(103,'Dulce Nombre de Jesús',17),(104,'Patalillo',17),(105,'Cascajal',17),(106,'San Ignacio',18),(107,'Guaitil',18),(108,'Palmichal',18),(109,'Cangrejal',18),(110,'Sabanillas',18),(111,'San Juan',19),(112,'Cinco Esquinas',19),(113,'Anselmo Llorente',19),(114,'León XIII',19),(115,'Colima',19),(116,'San Vicente',20),(117,'San Jerónimo',20),(118,'La Trinidad',20),(119,'San Pedro',21),(120,'Sabanilla',21),(121,'Mercedes',21),(122,'San Rafael',21),(123,'San Pablo',22),(124,'San Pedro',22),(125,'San Juan de Mata',22),(126,'San Luis',22),(127,'Carara',22),(128,'Santa María',23),(129,'Jardín',23),(130,'Copey',23),(131,'Curridabat',24),(132,'Granadilla',24),(133,'Sánchez',24),(134,'Tirrases',24),(135,'San Isidro de El General',25),(136,'El General',25),(137,'Daniel Flores',25),(138,'Rivas',25),(139,'San Pedro',25),(140,'Platanares',25),(141,'Pejibaye',25),(142,'Cajón',25),(143,'Barú',25),(144,'Río Nuevo',25),(145,'Páramo',25),(146,'La Amistad',25),(147,'San Pablo',26),(148,'San Andrés',26),(149,'Llano Bonito',26),(150,'San Isidro',26),(151,'Santa Cruz',26),(152,'San Antonio',26),(153,'Zapote',7),(154,'Alajuela',81),(155,'San José',81),(156,'Carrizal',81),(157,'San Antonio',81),(158,'Guácima',81),(159,'San Isidro',81),(160,'Sabanilla',81),(161,'San Rafael',81),(162,'Río Segundo',81),(163,'Desamparados',81),(164,'Turrúcares',81),(165,'Tambor',81),(166,'Garita',81),(167,'Sarapiquí',81),(168,'Oriental',82),(169,'Occidental',82),(170,'Carmen',82),(171,'San Nicolás',82),(172,'Agua Caliente',82),(173,'Guadalupe',82),(174,'Corralillo',82),(175,'Tierra Blanca',82),(176,'Dulce Nombre',82),(177,'Llano Grande',82),(178,'Quebradilla',82),(179,'Heredia',83),(180,'Mercedes',83),(181,'San Francisco',83),(182,'Ulloa',83),(183,'Varablanca',83),(184,'Puntarenas',84),(185,'Pitahaya',84),(186,'Chomes',84),(187,'Lepanto',84),(188,'Paquera',84),(189,'Manzanillo',84),(190,'Guacimal',84),(191,'Barranca',84),(192,'Monte Verde',84),(193,'Isla del Coco',84),(194,'Cóbano',84),(195,'Chacarita',84),(196,'Chira',84),(197,'Acapulco',84),(198,'El Roble',84),(199,'Arancibia',84),(200,'San Ramón',27),(201,'Santiago',27),(202,'San Juan',27),(203,'Piedades Norte',27),(204,'Piedades Sur',27),(205,'San Rafael',27),(206,'San Isidro',27),(207,'Ángeles',27),(208,'Alfaro',27),(209,'Volio',27),(210,'Concepción',27),(211,'Zapotal',27),(212,'Peñas Blancas',27),(213,'San Lorenzo',27),(214,'Grecia',28),(215,'San Isidro',28),(216,'San José',28),(217,'San Roque',28),(218,'Tacares',28),(219,'Puente de Piedra',28),(220,'Bolívar',28),(221,'San Mateo',29),(222,'Desmonte',29),(223,'Jesús María',29),(224,'Atenas',30),(225,'Jesús',30),(226,'Mercedes',30),(227,'San Isidro',30),(228,'Concepción',30),(229,'San José',30),(230,'Santa Eulalia',30),(231,'Escobal',30),(232,'Naranjo',31),(233,'San Miguel',31),(234,'San José',31),(235,'Cirrí Sur',31),(236,'San Jerónimo',31),(237,'San Juan',31),(238,'El Rosario',31),(239,'Palmitos',31),(240,'Palmares',32),(241,'Zaragoza',32),(242,'Buenos Aires',32),(243,'Santiago',32),(244,'Candelaria',32),(245,'Esquipulas',32),(246,'La Granja',32),(247,'San Pedro',33),(248,'San Juan',33),(249,'San Rafael',33),(250,'Carrillos',33),(251,'Sabana Redonda',33),(252,'Orotina',34),(253,'El Mastate',34),(254,'Hacienda Vieja',34),(255,'Coyolar',34),(256,'La Ceiba',34),(257,'Quesada',35),(258,'Florencia',35),(259,'Buenavista',35),(260,'Aguas Zarcas',35),(261,'Venecia',35),(262,'Pital',35),(263,'La Fortuna',35),(264,'La Tigra',35),(265,'La Palmera',35),(266,'Venado',35),(267,'Cutris',35),(268,'Monterrey',35),(269,'Pocosol',35),(270,'Zarcero',36),(271,'Laguna',36),(272,'Tapesco',36),(273,'Guadalupe',36),(274,'Palmira',36),(275,'Zapote',36),(276,'Brisas',36),(277,'Sarchí Norte',37),(278,'Sarchí Sur',37),(279,'Toro Amarillo',37),(280,'San Pedro',37),(281,'Rodríguez',37),(282,'Upala',38),(283,'Aguas Claras',38),(284,'San José',38),(285,'Bijagua',38),(286,'Delicias',38),(287,'Dos Ríos',38),(288,'Yolillal',38),(289,'Canalete',38),(290,'Los Chiles',39),(291,'Caño Negro',39),(292,'El Amparo',39),(293,'San Jorge',39),(294,'San Rafael',40),(295,'Buenavista',40),(296,'Cote',40),(297,'Katira',40),(298,'Río Cuarto',41),(299,'Santa Rita',41),(300,'Santa Isabel',41),(301,'Paraíso',42),(302,'Santiago',42),(303,'Orosi',42),(304,'Cachí',42),(305,'Llanos de Santa Lucía',42),(306,'Tres Ríos',43),(307,'San Diego',43),(308,'San Juan',43),(309,'San Rafael',43),(310,'Concepción',43),(311,'Dulce Nombre',43),(312,'San Ramón',43),(313,'Río Azul',43),(314,'Juan Viñas',44),(315,'Tucurrique',44),(316,'Pejibaye',44),(317,'Turrialba',45),(318,'La Suiza',45),(319,'Peralta',45),(320,'Santa Cruz',45),(321,'Santa Teresita',45),(322,'Pavones',45),(323,'Tuis',45),(324,'Tayutic',45),(325,'Santa Rosa',45),(326,'Tres Equis',45),(327,'La Isabel',45),(328,'Chirripó',45),(329,'Pacayas',46),(330,'Cervantes',46),(331,'Capellades',46),(332,'San Rafael',47),(333,'Cot',47),(334,'Potrero Cerrado',47),(335,'Cipreses',47),(336,'Santa Rosa',47),(337,'El Tejar',48),(338,'San Isidro',48),(339,'Tobosi',48),(340,'Patio de Agua',48),(341,'Barva',49),(342,'San Pedro',49),(343,'San Pablo',49),(344,'San Roque',49),(345,'Santa Lucía',49),(346,'San José de la Montaña',49),(347,'Santo Domingo',50),(348,'San Vicente',50),(349,'San Miguel',50),(350,'Paracito',50),(351,'Santo Tomás',50),(352,'Santa Rosa',50),(353,'Tures',50),(354,'Pará',50),(355,'Santa Bárbara',51),(356,'San Pedro',51),(357,'San Juan',51),(358,'Jesús',51),(359,'Santo Domingo',51),(360,'Purabá',51),(361,'San Rafael',52),(362,'San Josecito',52),(363,'Santiago',52),(364,'Los Ángeles',52),(365,'Concepción',52),(366,'San Isidro',53),(367,'San José',53),(368,'Concepción',53),(369,'San Francisco',53),(370,'San Antonio',54),(371,'La Ribera',54),(372,'La Asunción',54),(373,'San Joaquín',55),(374,'Barrantes',55),(375,'Llorente',55),(376,'San Pablo',56),(377,'Rincón de Sabanilla',56),(378,'Puerto Viejo',57),(379,'La Virgen',57),(380,'Las Horquetas',57),(381,'Llanuras del Gaspar',57),(382,'Cureña',57),(383,'Liberia',58),(384,'Cañas Dulces',58),(385,'Mayorga',58),(386,'Nacascolo',58),(387,'Curubandé',58),(388,'Nicoya',59),(389,'Mansión',59),(390,'San Antonio',59),(391,'Quebrada Honda',59),(392,'Sámara',59),(393,'Nosara',59),(394,'Belén de Nosarita',59),(395,'Santa Cruz',60),(396,'Bolsón',60),(397,'Veintisiete de Abril',60),(398,'Tempate',60),(399,'Cartagena',60),(400,'Cuajiniquil',60),(401,'Diriá',60),(402,'Cabo Velas',60),(403,'Tamarindo',60),(404,'Bagaces',61),(405,'La Fortuna',61),(406,'Mogote',61),(407,'Río Naranjo',61),(408,'Filadelfia',62),(409,'Palmira',62),(410,'Sardinal',62),(411,'Belén',62),(412,'Cañas',63),(413,'Palmira',63),(414,'San Miguel',63),(415,'Bebedero',63),(416,'Porozal',63),(417,'Las Juntas',64),(418,'Sierra',64),(419,'San Juan',64),(420,'Colorado',64),(421,'Tilarán',65),(422,'Quebrada Grande',65),(423,'Tronadora',65),(424,'Santa Rosa',65),(425,'Líbano',65),(426,'Tierras Morenas',65),(427,'Arenal',65),(428,'Cabeceras',65),(429,'Carmona',66),(430,'Santa Rita',66),(431,'Zapotal',66),(432,'San Pablo',66),(433,'Porvenir',66),(434,'Bejuco',66),(435,'La Cruz',67),(436,'Santa Cecilia',67),(437,'La Garita',67),(438,'Santa Elena',67),(439,'Hojancha',68),(440,'Monte Romo',68),(441,'Puerto Carrillo',68),(442,'Huacas',68),(443,'Matambú',68),(444,'Espíritu Santo',69),(445,'San Juan Grande',69),(446,'Macacona',69),(447,'San Rafael',69),(448,'San Jerónimo',69),(449,'Caldera',69),(450,'Buenos Aires',70),(451,'Volcán',70),(452,'Potrero Grande',70),(453,'Boruca',70),(454,'Pilas',70),(455,'Colinas',70),(456,'Chánguena',70),(457,'Biolley',70),(458,'Brunka',70),(459,'Miramar',71),(460,'La Unión',71),(461,'San Isidro',71),(462,'Puerto Cortés',72),(463,'Palmar',72),(464,'Sierpe',72),(465,'Bahía Ballena',72),(466,'Piedras Blancas',72),(467,'Bahía Drake',72),(468,'Quepos',73),(469,'Savegre',73),(470,'Naranjito',73),(471,'Golfito',74),(472,'Guaycará',74),(473,'Pavón',74),(474,'San Vito',75),(475,'Sabalito',75),(476,'Aguabuena',75),(477,'Limoncito',75),(478,'Pittier',75),(479,'Gutiérrez Braun',75),(480,'Parrita',76),(481,'Corredor',77),(482,'La Cuesta',77),(483,'Canoas',77),(484,'Laurel',77),(485,'Jacó',78),(486,'Tárcoles',78),(487,'Monteverde',79),(488,'Puerto Jiménez',80),(489,'Limón',5),(490,'San Antonio',45),(491,'El Cairo',52),(492,'Chacarita',84);
/*!40000 ALTER TABLE `tbdistrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbfactura`
--

DROP TABLE IF EXISTS `tbfactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbfactura` (
  `idFactura` int NOT NULL AUTO_INCREMENT,
  `fechaFactura` date DEFAULT NULL,
  `idPedido` int DEFAULT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `idPedido` (`idPedido`),
  CONSTRAINT `tbfactura_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tbpedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbfactura`
--

LOCK TABLES `tbfactura` WRITE;
/*!40000 ALTER TABLE `tbfactura` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbfactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbmensaje`
--

DROP TABLE IF EXISTS `tbmensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbmensaje` (
  `idMensaje` int NOT NULL AUTO_INCREMENT,
  `descripcionMensaje` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaEnvioMensaje` date DEFAULT NULL,
  `idUsuario` int DEFAULT NULL,
  `idPromocion` int DEFAULT NULL,
  PRIMARY KEY (`idMensaje`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idPromocion` (`idPromocion`),
  CONSTRAINT `tbmensaje_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`),
  CONSTRAINT `tbmensaje_ibfk_2` FOREIGN KEY (`idPromocion`) REFERENCES `tbpromocion` (`idPromocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbmensaje`
--

LOCK TABLES `tbmensaje` WRITE;
/*!40000 ALTER TABLE `tbmensaje` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbmensaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbnotificacion`
--

DROP TABLE IF EXISTS `tbnotificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbnotificacion` (
  `idNotificacion` int NOT NULL AUTO_INCREMENT,
  `descripcionNotificacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idUsuario` int NOT NULL,
  `leidos` tinyint(1) DEFAULT NULL,
  `fechaNotificacion` date DEFAULT NULL,
  PRIMARY KEY (`idNotificacion`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbnotificacion_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbnotificacion`
--

LOCK TABLES `tbnotificacion` WRITE;
/*!40000 ALTER TABLE `tbnotificacion` DISABLE KEYS */;
INSERT INTO `tbnotificacion` VALUES (22,'El cliente ha cancelado su pedido por medio de la aplicación.',60,1,'2025-05-13');
/*!40000 ALTER TABLE `tbnotificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpedido`
--

DROP TABLE IF EXISTS `tbpedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbpedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `montoTotalPedido` decimal(38,2) DEFAULT NULL,
  `fechaPedido` datetime(6) DEFAULT NULL,
  `estadoPedido` bit(1) DEFAULT NULL,
  `estadoEntregaPedido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idCarrito` int DEFAULT NULL,
  `idTipoPago` int DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idCarrito` (`idCarrito`),
  KEY `idTipoPago` (`idTipoPago`),
  CONSTRAINT `tbpedido_ibfk_1` FOREIGN KEY (`idCarrito`) REFERENCES `tbcarrito` (`idCarrito`) ON DELETE CASCADE,
  CONSTRAINT `tbpedido_ibfk_2` FOREIGN KEY (`idTipoPago`) REFERENCES `tbtipopago` (`idTipoPago`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedido`
--

LOCK TABLES `tbpedido` WRITE;
/*!40000 ALTER TABLE `tbpedido` DISABLE KEYS */;
INSERT INTO `tbpedido` VALUES (30,2825.00,'2025-04-21 18:22:00.000000',_binary '','Entregado',45,1),(48,2510.86,'2025-05-08 14:08:00.000000',_binary '','En Proceso',62,2),(49,2825.00,'2025-04-30 14:14:00.000000',_binary '','Cancelado',63,1),(50,1695.00,'2025-04-30 14:09:00.000000',_binary '','Pendiente',64,2),(51,5650.00,'2025-05-01 09:20:00.000000',_binary '','Pendiente',65,2),(52,15820.00,'2025-06-01 11:11:00.000000',_binary '','Listo',66,1);
/*!40000 ALTER TABLE `tbpedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpedidoproducto`
--

DROP TABLE IF EXISTS `tbpedidoproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbpedidoproducto` (
  `idPedidoProducto` int NOT NULL AUTO_INCREMENT,
  `idPedido` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  PRIMARY KEY (`idPedidoProducto`),
  KEY `idPedido` (`idPedido`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `tbpedidoproducto_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tbpedido` (`idPedido`) ON DELETE CASCADE,
  CONSTRAINT `tbpedidoproducto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedidoproducto`
--

LOCK TABLES `tbpedidoproducto` WRITE;
/*!40000 ALTER TABLE `tbpedidoproducto` DISABLE KEYS */;
INSERT INTO `tbpedidoproducto` VALUES (27,30,12),(56,48,8),(57,49,12),(58,50,11),(59,51,13),(60,52,11),(61,52,12),(62,52,13);
/*!40000 ALTER TABLE `tbpedidoproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbproducto`
--

DROP TABLE IF EXISTS `tbproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbproducto` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombreProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imgProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `montoPrecioProducto` decimal(38,2) DEFAULT NULL,
  `descripcionProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cantidadProducto` double DEFAULT NULL,
  `tipoPesoProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codigoProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stockProducto` int DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  `estadoProducto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `tbproducto_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `tbcategoria` (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbproducto`
--

LOCK TABLES `tbproducto` WRITE;
/*!40000 ALTER TABLE `tbproducto` DISABLE KEYS */;
INSERT INTO `tbproducto` VALUES (6,'Producto1','911fe0f1-9987-4506-8a1a-7393ac03f08d.jpg',2300.00,'Descripcion de prueba',100,'Gr','skd002',10,5,0),(7,'PruebaCambios','d8d76da7-8f90-4c6c-95a0-5dba9e97e89e.jpg',9000.00,'Ayer la probe',1,'Ud','sgy882',7,7,1),(8,'Holaa','d0991041-874a-4171-a5c9-9b7f0db2bb4a.png',2222.00,'Depende',2,'Kg','bnw225',0,4,1),(9,'PruebaFinal','8bdd33a9-ca23-4b99-a197-ca570489ce98.jpg',3020.00,'ayer bla bla bla',1,'Ud','fkl490',20,3,0),(10,'Papas','59138d57-d0f8-4fc2-a562-5ca486d44a2a.jpg',1200.00,'ad',1,'ud','12414',11,1,0),(11,'Alitas de pollo','4722713c-8c42-4997-81b9-c92cf44e16ca.png',1500.00,'Alitas de pollo de engorde',1,'Kg','ALA01',100,24,0),(12,'Chuletas','a1da1bbe-d118-42b2-bb00-da3a5519cb3d.png',2500.00,'Chuletas de cerdo de la mas alta calidad',1,'Kg','Ch01',50,3,1),(13,'Punta de solomo','11dbb17d-a326-40fc-a367-09b55926d71f.png',5000.00,'Punta de solomo de Angus',1,'Kg','Pt01',25,2,1);
/*!40000 ALTER TABLE `tbproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpromocion`
--

DROP TABLE IF EXISTS `tbpromocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbpromocion` (
  `idPromocion` int NOT NULL AUTO_INCREMENT,
  `descripcionPromocion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaInicioPromocion` date DEFAULT NULL,
  `fechaFinPromocion` date DEFAULT NULL,
  `montoPromocion` decimal(38,2) DEFAULT NULL,
  `estadoPromocion` tinyint(1) DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  PRIMARY KEY (`idPromocion`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `tbpromocion_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpromocion`
--

LOCK TABLES `tbpromocion` WRITE;
/*!40000 ALTER TABLE `tbpromocion` DISABLE KEYS */;
INSERT INTO `tbpromocion` VALUES (1,'PAPAS','2025-05-16','2025-05-17',8923.00,1,11),(2,'RUTRT','2025-02-22','2025-02-28',1.00,0,9),(3,'sh','2025-02-22','2025-02-26',1.00,0,6),(4,'sdfg','2025-02-22','2025-02-25',1.00,0,6),(5,'PromocionNueva','2025-06-02','2025-06-03',1500.00,1,13),(6,'PromocionNueva2','2025-05-15','2025-05-16',6677.00,1,12),(7,'awdawd','2025-05-22','2025-05-23',23423.00,1,8),(8,'Prueba 3','2025-05-31','2025-06-01',222.00,1,11);
/*!40000 ALTER TABLE `tbpromocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbprovincia`
--

DROP TABLE IF EXISTS `tbprovincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbprovincia` (
  `idProvincia` int NOT NULL AUTO_INCREMENT,
  `nombreProvincia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idProvincia`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbprovincia`
--

LOCK TABLES `tbprovincia` WRITE;
/*!40000 ALTER TABLE `tbprovincia` DISABLE KEYS */;
INSERT INTO `tbprovincia` VALUES (1,'San José'),(2,'Alajuela'),(3,'Cartago'),(4,'Heredia'),(5,'Guanacaste'),(6,'Puntarenas'),(7,'Limón');
/*!40000 ALTER TABLE `tbprovincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbrol`
--

DROP TABLE IF EXISTS `tbrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbrol` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombreRol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcionRol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoRol` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbrol`
--

LOCK TABLES `tbrol` WRITE;
/*!40000 ALTER TABLE `tbrol` DISABLE KEYS */;
INSERT INTO `tbrol` VALUES (1,'Administrador','El que se encarga de realizar lo más importante',_binary ''),(2,'Gerente','El que se encarga de algunas cosas',_binary ''),(3,'Usuario','El que se encarga de ver productos y realizar pedidos',_binary '');
/*!40000 ALTER TABLE `tbrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbtipopago`
--

DROP TABLE IF EXISTS `tbtipopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbtipopago` (
  `idTipoPago` int NOT NULL AUTO_INCREMENT,
  `descripcioTipoPago` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoTipoPago` tinyint(1) DEFAULT NULL,
  `descripcionTipoPago` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idTipoPago`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbtipopago`
--

LOCK TABLES `tbtipopago` WRITE;
/*!40000 ALTER TABLE `tbtipopago` DISABLE KEYS */;
INSERT INTO `tbtipopago` VALUES (1,NULL,0,'SINPE'),(2,NULL,1,'CREDITO'),(3,NULL,1,'EFECTIVO');
/*!40000 ALTER TABLE `tbtipopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbusuario`
--

DROP TABLE IF EXISTS `tbusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbusuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `cedulaUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contraseniaUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `correoUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `nombreUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `primerApellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `segundoApellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefonoUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idDireccion` int DEFAULT NULL,
  `idRol` int DEFAULT NULL,
  `estadoUsuario` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `FK2tbdw6lsgbsdrhyex64u5kbij` (`idDireccion`),
  KEY `FK6dgi775fekruot59lqiv650ns` (`idRol`),
  CONSTRAINT `FK2tbdw6lsgbsdrhyex64u5kbij` FOREIGN KEY (`idDireccion`) REFERENCES `tbdireccion` (`idDireccion`),
  CONSTRAINT `FK6dgi775fekruot59lqiv650ns` FOREIGN KEY (`idRol`) REFERENCES `tbrol` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusuario`
--

LOCK TABLES `tbusuario` WRITE;
/*!40000 ALTER TABLE `tbusuario` DISABLE KEYS */;
INSERT INTO `tbusuario` VALUES (6,'703100064','$2a$12$fBMZLlt6aCS9iNemYH7h0e8m/YexlGy.13W2GTCFbnHLLe6fyTqOG','jsandi1299@gmail.com','2004-08-09','Jamel','Sandí','Andersons','88955772',13,1,_binary ''),(11,NULL,'$2a$12$H7xEK8HgTEGRCaE4flNwL.E1VyjkxeENA7DB9bwB85xUn6S4A0w0q','dilan@gmail.com',NULL,'Dilan','Gutiérrez','Hérnanandez',NULL,15,2,_binary ''),(14,NULL,'$2a$12$//YmSKyCUaOul9TXIWPZEO9gr5yyzKc00AG8Wmi8IQUqy9dPPaqwK','jsandi12199@gmail.com',NULL,'JamelZito','prueba','Sandi',NULL,18,3,_binary ''),(23,NULL,'$2a$12$ARcwI6LAA/et4dwOF1QC9.ysaT65uDNz8VBdcblaYooyEQpoj/0YG','cucho@gmail.com',NULL,'cucho','Rojas','Alvarado',NULL,27,3,_binary '\0'),(28,NULL,'contrasenia123','correo@gmail.com',NULL,'Juan','Pérez','Gómez',NULL,32,3,_binary ''),(29,NULL,'$2a$12$cM0U3Bmt9FlpyK0M1cU0SO.9KHOvJRNTB4mQKyv3B6z3lKWhqR2x.','primero@gmail.com',NULL,'Esteban','Primero','Segundo',NULL,33,3,_binary ''),(30,NULL,'12345678','pruebas3214@gmail.com',NULL,'prueba','dos','els',NULL,34,3,_binary ''),(31,NULL,'$2a$12$XAXieNUh4uq0p63tgYas0.cFjDylO//cePrqyb4RPtjKmTaYEUbDi','degutierrezh02@gmail.com',NULL,'fgj','fdjs','sdfj',NULL,35,3,_binary ''),(32,NULL,'$2a$12$j0hHtFKV8VYgUDkReYsPm.7aXC2c8D3zdQV5VuKQgK.b8XOgvk3oa','pppp@gmail.com',NULL,'dsh','sdh','sdh',NULL,36,3,_binary ''),(33,NULL,'$2a$12$jXCxxUDeduNw1K8YydDPBugqO4QQh2iqG8zIECXaIdvl.dzdRZ3ci','dilan.gutierrez.hernandez@est.una.ac.cr',NULL,'zdg','dsg','sdg',NULL,37,3,_binary ''),(34,NULL,'$2a$12$pSGMTA/MuXz9gih591ukJOz.24/3D1IzCGFzH4JpMHRJg6Aq1aEBi','dilan.gutierrez@est.una.ac.cr',NULL,'adsf','adf','adgf',NULL,38,3,_binary ''),(35,NULL,'$2a$12$Z0ZBDIWcgO8qETX6PJorlek2Y9V/gJFwXthpFsp4Ax0QUcuKCZddi','dilan.gutierrez.hernandez2@est.una.ac.cr',NULL,'dssa','dga','ga',NULL,39,3,_binary ''),(52,NULL,'$2a$12$RAhTkU5PcJsq5ZhCmAZzguoPjmlD99XJ3l15BRCSoKZBHEURRYBqC','sdg@gmail.com',NULL,'Dilasfa','sdg','asdg',NULL,56,3,_binary ''),(53,NULL,'$2a$12$wxpinMmDpXb81OSNb8ixYe41ZjL4k8g3KFkR87Za0EFsY7aLOXspW','asfafs@gmailcom',NULL,'saf','asf','asf',NULL,57,3,_binary ''),(54,NULL,'$2a$12$LQFT7OJUAofpgE6ftgZsg.oof8rRo/oGuu6OB8E1Lok8.nkrPdvye','asf@gmail.com',NULL,'sfa','asf','asfa',NULL,58,1,_binary ''),(55,NULL,'$2a$12$KGDvJ718zuuszp3Rdow8/OjBosJDciixCcoNIBKJ2nwrY3Ztv6E9K','dilan.gutierrez.hernandesssz@est.una.ac.cr',NULL,'dgss','dgs','sdgs',NULL,59,3,_binary ''),(56,'703040371','$2a$12$1Lty/kvWrEDYeIzyPuA1RuqaafGE0kH2quMVwJ7yP6xx7inoQbdDq','glendrojas1040@gmail.com','2003-11-20','Glend','Rojas','Alvarado','8623-7034',60,3,_binary ''),(57,NULL,'$2a$12$Iu37sYbB1/FNUDvQsHW0mO8Odu4lOVvTdll4A1X7OkpIZWt9dcjUy','d.cedeno2004@gmail.com',NULL,'Daisy','Cedeño','Sanabria',NULL,61,3,_binary ''),(58,NULL,'$2a$12$kDrOgYYYI.1/CUaUDRiyiODfE1ppJBNKkyOZJ3DMZ0zKo61eW5EYi','deboflor80@gmail.com',NULL,'Debora','Mendez ','Castillo',NULL,62,3,_binary ''),(59,NULL,'$2a$12$cuiOj0AQ40AegBlp/KEja.DzNbma0KUQ4AFRaNWVt6ZGlxjH7abzy','dilangh020711@gmail.com',NULL,'dlk','gutierrez','XZv',NULL,63,3,_binary ''),(60,NULL,'$2a$12$KF8Ik6Ej8K3e8B7MEz7wyOvtfzBtSa8bw59MUb6assv0.9FBuziQK','jamelsandi6@gmail.com',NULL,'Glend','Rojas','Alvarado',NULL,64,3,_binary ''),(61,NULL,'$2a$12$jxF2Fbluffzi.BCxhfECQOD6VKDmiFBfJzO2S8vZNnl8Vc9MPDzO.','glendrojas1041@gmail.com',NULL,'Glend','Rojas','Alvarado',NULL,65,1,_binary ''),(62,NULL,'$2a$12$jok2hU62T6obqZ0bdU/17.bgQr.cJiCbYZKFkrMqApXqYnKLhVCR2','prueba@gmail.com',NULL,'Pedro','Rojas','Alvarado',NULL,66,2,_binary '');
/*!40000 ALTER TABLE `tbusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bdcarniceria'
--
/*!50003 DROP PROCEDURE IF EXISTS `spActivarCategoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActivarCategoria`(IN `p_idCategoria` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE estadoActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al activar la categoria' AS mensaje;
    END;

    -- Verificar si la categoria existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SET done = 1;
        SELECT 'Categoraía no encontrado' AS mensaje;
    END IF;

    -- Cambiar el estado de la categoria si existe
    IF done = 0 THEN
        -- Obtener el estado actual de la categoria
        SELECT estadoCategoria INTO estadoActual FROM tbcategoria WHERE idCategoria = p_idCategoria;

        -- Cambiar el valor de estado a 1 si es 0, o a 0 si es 1
        UPDATE tbcategoria
        SET estadoCategoria = CASE WHEN estadoActual = 1 THEN 0 ELSE 1 END
        WHERE idCategoria = p_idCategoria;  -- Aquí corregido: usar idProducto en lugar de p_idProducto

        SELECT 'Categoria activada con éxito' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActivarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActivarProducto`(IN `p_idProducto` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE estadoActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al activar el producto' AS mensaje;
    END;

    -- Verificar si el producto existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbproducto WHERE idProducto = p_idProducto) THEN
        SET done = 1;
        SELECT 'Producto no encontrado' AS mensaje;
    END IF;

    -- Cambiar el estado del producto si existe
    IF done = 0 THEN
        -- Obtener el estado actual del producto
        SELECT estadoProducto INTO estadoActual FROM tbproducto WHERE idProducto = p_idProducto;

        -- Cambiar el valor de estado a 1 si es 0, o a 0 si es 1
        UPDATE tbproducto
        SET estadoProducto = CASE WHEN estadoActual = 1 THEN 0 ELSE 1 END
        WHERE idProducto = p_idProducto;  -- Aquí corregido: usar idProducto en lugar de p_idProducto

        SELECT 'Producto activado con éxito' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActivarPromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActivarPromocion`(IN `p_idPromocion` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE estadoActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al cambiar el estado de la promoción' AS mensaje;
    END;

    -- Verificar si la promocion existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbpromocion WHERE idPromocion = p_idPromocion) THEN
        SET done = 1;
        SELECT 'promocion no encontrada' AS mensaje;
    END IF;

    -- Cambiar el estado de la promocion si existe
    IF done = 0 THEN
        -- Obtener el estado actual de la promocion
        SELECT estadoPromocion INTO estadoActual FROM tbpromocion WHERE idPromocion = p_idPromocion;

        -- Cambiar el valor de estado a 1 si es 0, o a 0 si es 1
        UPDATE tbpromocion
        SET estadoPromocion = CASE WHEN estadoActual = 1 THEN 0 ELSE 1 END
        WHERE idPromocion = p_idPromocion;  

        SELECT 'Estado de la promocion cambiada con éxito' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActivarTipoPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActivarTipoPago`(IN `p_idTipoPago` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE estadoActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al cambiar el estado del tipo de pago' AS mensaje;
    END;

    -- Verificar si el tipo de pago existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbtipopago WHERE idTipoPago = p_idTipoPago) THEN
        SET done = 1;
        SELECT 'Tipo pago no encontrada' AS mensaje;
    END IF;

    -- Cambiar el estado del tipo pago si existe
    IF done = 0 THEN
        -- Obtener el estado actual del tipo pago
        SELECT estadoTipoPago INTO estadoActual FROM tbtipopago WHERE idTipoPago = p_idTipoPago;

        -- Cambiar el valor de estado a 1 si es 0, o a 0 si es 1
        UPDATE tbtipopago
        SET estadoTipoPago = CASE WHEN estadoActual = 1 THEN 0 ELSE 1 END
        WHERE idTipoPago = p_idTipoPago;  

        SELECT 'Estado del tipo pago cambiado con éxito' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActivarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActivarUsuario`(IN `p_idUsuario` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE estadoActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al activar el usuario' AS mensaje;
    END;

    -- Verificar si el usuario existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbusuario WHERE idUsuario = p_idUsuario) THEN
        SET done = 1;
        SELECT 'Usuario no encontrado' AS mensaje;
    END IF;

    -- Cambiar el estado del usuario si existe
    IF done = 0 THEN
        -- Obtener el estado actual del usuario
        SELECT estadoUsuario INTO estadoActual FROM tbusuario WHERE idUsuario = p_idUsuario;

        -- Cambiar el valor de estado a 1 si es 0, o a 0 si es 1
        UPDATE tbusuario
        SET estadoUsuario = CASE WHEN estadoActual = 1 THEN 0 ELSE 1 END
        WHERE idUsuario = p_idUsuario;  -- Aquí corregido: usar idProducto en lugar de p_idProducto

        SELECT 'usaurio activado con éxito' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarCarrito`(
    IN `p_idCarrito` INT,
    IN `p_idUsuario` INT, 
    IN `p_montoTotalCarrito` DECIMAL(38,2), 
    IN `p_estadoCarrito` TINYINT(1),
    IN `p_cantidadCarrito` INT
)
BEGIN
    -- Manejador de errores mejorado
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar el carrito';
    END;

    -- Iniciar transacción
    START TRANSACTION;

    -- Validar existencia del carrito
    IF NOT EXISTS (SELECT 1 FROM tbcarrito WHERE idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Carrito no encontrado';
    END IF;

    -- Validar usuario si se proporciona
    IF p_idUsuario IS NOT NULL AND NOT EXISTS (SELECT 1 FROM tbusuario WHERE idUsuario = p_idUsuario) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no existe';
    END IF;

    -- Validar monto total
    IF p_montoTotalCarrito IS NOT NULL AND p_montoTotalCarrito <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto total debe ser mayor a cero';
    END IF;

    -- Validar cantidad
    IF p_cantidadCarrito IS NOT NULL AND p_cantidadCarrito < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad no puede ser negativa';
    END IF;

    -- Actualización condicional con IFNULL
    UPDATE tbcarrito
    SET 
        idUsuario = IFNULL(p_idUsuario, idUsuario),
        montoTotalCarrito = IFNULL(p_montoTotalCarrito, montoTotalCarrito),
        cantidadCarrito = IFNULL(p_cantidadCarrito, cantidadCarrito),
        estadoCarrito = IFNULL(p_estadoCarrito, estadoCarrito)
    WHERE idCarrito = p_idCarrito;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarCategoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarCategoria`(IN `p_idCategoria` INT, IN `p_nombre` VARCHAR(255), IN `p_descripcion` VARCHAR(255), IN `p_estado` INT)
BEGIN
    
    UPDATE tbcategoria
    SET nombreCategoria = p_nombre,
        descripcionCategoria = p_descripcion,
        estadoCategoria = p_estado 
    WHERE idCategoria = p_idCategoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarComentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarComentario`(IN `p_idComentario` INT, IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `P_idUsuario` INT, IN `p_numCalificacion` INT)
BEGIN
    
    UPDATE tbcomentario
    SET descripcionComentario = p_descripcionComentario,
        fechaComentario = p_fechaComentario,
        idUsuario = P_idUsuario,
        numCalificacion = p_numCalificacion
    WHERE idComentario = p_idComentario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarContrasena` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarContrasena`(IN `p_idUsuario` INT, IN `p_nuevaContraseniaUsuario` VARCHAR(255))
BEGIN

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        -- Mensaje de alerta si el idUsuario no existe
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ID de usuario no existe';
        ROLLBACK;
    END;

    -- Verificar si el usuario existe
    IF (SELECT COUNT(*) FROM tbusuario WHERE idUsuario = p_idUsuario) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ID de usuario no existe';
        ROLLBACK;
    END IF;

    -- Inicio de la transacción
    START TRANSACTION;

    -- Actualización de la contraseña del usuario
    UPDATE tbusuario
    SET 
        contraseniaUsuario = IF(p_nuevaContraseniaUsuario IS NOT NULL, p_nuevaContraseniaUsuario, contraseniaUsuario)
    WHERE idUsuario = p_idUsuario;

    -- Confirmación de la transacción
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarCredenciales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarCredenciales`(IN `p_idUsuario` INT,
 IN `p_cedulaUsuario` VARCHAR(255),
 IN `p_nombreUsuario` VARCHAR(255),
 IN `p_primerApellido` VARCHAR(255),
 IN `p_segundoApellido` VARCHAR(255), 
 IN `p_telefonoUsuario` VARCHAR(255),
 IN `p_fechaNacimiento` DATE
 )
BEGIN
DECLARE existingCount INT;

SELECT COUNT(*) INTO existingCount FROM tbusuario WHERE idUsuario = p_idUsuario;

    IF existingCount = 0 THEN
     ROLLBACK;
        SELECT 'El ID del usuario no existe.' AS mensaje;
    
    END IF;

    -- Verificar si la cédula ya existe en otro registro
    IF p_cedulaUsuario IS NOT NULL THEN
        SELECT COUNT(*) INTO existingCount
        FROM tbusuario
        WHERE cedulaUsuario = p_cedulaUsuario AND idUsuario != p_idUsuario;
        
        IF existingCount > 0 THEN
            ROLLBACK; 
            SELECT 'La cédula ya está registrada en otro usuario.' AS mensaje;
            
        END IF;
    END IF;

    -- Verificar si el teléfono ya existe en otro registro
    IF p_telefonoUsuario IS NOT NULL THEN
        SELECT COUNT(*) INTO existingCount
        FROM tbusuario
        WHERE telefonoUsuario = p_telefonoUsuario AND idUsuario != p_idUsuario;
        
        IF existingCount > 0 THEN
             ROLLBACK; 
            SELECT 'El teléfono ya está registrado en otro usuario.' AS mensaje;
        END IF;
    END IF;

    -- Actualizar la información del usuario
    UPDATE tbusuario
    SET cedulaUsuario = IF(p_cedulaUsuario IS NOT NULL, p_cedulaUsuario, cedulaUsuario),
        nombreUsuario = IF(p_nombreUsuario IS NOT NULL, p_nombreUsuario, nombreUsuario),
        primerApellido = IF(p_primerApellido IS NOT NULL, p_primerApellido, primerApellido),
        segundoApellido = IF(p_segundoApellido IS NOT NULL, p_segundoApellido, segundoApellido),
        telefonoUsuario = IF(p_telefonoUsuario IS NOT NULL, p_telefonoUsuario, telefonoUsuario),
          fechaNacimiento = IF(p_fechaNacimiento IS NOT NULL, p_fechaNacimiento, fechaNacimiento)
        WHERE idUsuario = p_idUsuario;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarEstadoEntregaPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarEstadoEntregaPedido`(
    IN p_idPedido INT,
    IN p_nuevoEstado VARCHAR(50)
)
BEGIN
    IF p_nuevoEstado IN ('Pendiente', 'En proceso', 'Cancelado', 'Entregado','Listo') THEN
        UPDATE tbpedido 
        SET estadoEntregaPedido = p_nuevoEstado
        WHERE idPedido = p_idPedido;

        IF ROW_COUNT() > 0 THEN
            SELECT CONCAT('Estado actualizado a "', p_nuevoEstado, '" para pedido ', p_idPedido) AS Resultado;
        ELSE
            SELECT CONCAT('No existe pedido con ID: ', p_idPedido) AS Error;
        END IF;
    ELSE
        SELECT 'Error: Valores permitidos: Pendiente, En proceso, Cancelado, Entregado y Listo' AS Error;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarPedido`(
    IN p_idPedido INT,
    IN p_montoTotalPedido DECIMAL(38,2),
    IN p_fechaPedido DATETIME,
    IN p_estadoPedido INT,
    IN p_estadoEntregaPedido VARCHAR(255),
    IN p_idCarrito INT,
    IN p_idTipoPago INT
)
BEGIN
    DECLARE custom_exception CONDITION FOR SQLSTATE '45000';
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        
        ROLLBACK;
        SET @error_msg = CONCAT('Error al actualizar el pedido: ', @sqlstate, ' - ', @errno, ' - ', @text);
        SELECT @error_msg AS Mensaje;
    END;
    
    START TRANSACTION;
    
    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM bdcarniceria.tbpedido WHERE idPedido = p_idPedido) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El pedido especificado no existe';
    END IF;
    
    -- Validar relaciones
    IF NOT EXISTS (SELECT 1 FROM bdcarniceria.tbcarrito WHERE idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carrito especificado no existe';
    END IF;
    
    -- Validar que el tipo de pago exista (si tienes esta tabla)
    IF p_idTipoPago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM bdcarniceria.tbtipopago WHERE idTipoPago = p_idTipoPago) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de pago especificado no existe';
    END IF;
    
    -- Para depuración, imprimir los valores antes de actualizar
    SELECT 
        CONCAT('Valores a actualizar: idPedido=', p_idPedido, 
               ', monto=', p_montoTotalPedido, 
               ', fecha=', p_fechaPedido, 
               ', estado=', p_estadoPedido, 
               ', entrega=', p_estadoEntregaPedido, 
               ', idCarrito=', p_idCarrito, 
               ', idTipoPago=', p_idTipoPago) AS DebugInfo;
    
    -- Actualizar el pedido
    UPDATE bdcarniceria.tbpedido
    SET 
        montoTotalPedido = p_montoTotalPedido,
        fechaPedido = p_fechaPedido,
        estadoPedido = IF(p_estadoPedido = 1, b'1', b'0'),
        estadoEntregaPedido = p_estadoEntregaPedido,
        idCarrito = p_idCarrito,
        idTipoPago = p_idTipoPago
    WHERE 
        idPedido = p_idPedido;
    
    -- Verificar si se actualizó alguna fila
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se actualizó ningún registro, posible error en los datos';
    END IF;
    
    SELECT ROW_COUNT() AS filasAfectadas, 'Pedido actualizado exitosamente' AS Mensaje;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarProducto`(IN `p_idProducto` INT, 
 IN `p_nombreProducto` VARCHAR(255),
 IN `p_imgProducto` VARCHAR(255), 
 IN `p_montoPrecioProducto` DECIMAL(10,3), 
 IN `p_descripcionProducto` VARCHAR(500), 
 IN `p_cantidadProducto` DECIMAL(10,2), 
 IN `p_tipoPesoProducto` VARCHAR(50), 
 IN `p_codigoProducto` VARCHAR(50), 
 IN `p_stockProducto` INT, 
 IN `p_idCategoria` INT,
 IN `p_estadoProducto` BOOLEAN)
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Validar existencia del producto
    IF NOT EXISTS (SELECT 1 FROM tbproducto WHERE idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe';
    END IF;

    -- Validar campos obligatorios y sus longitudes
    IF p_nombreProducto IS NOT NULL AND CHAR_LENGTH(p_nombreProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de producto demasiado largo';
    END IF;

    IF p_montoPrecioProducto IS NOT NULL AND p_montoPrecioProducto <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio debe ser mayor a cero';
    END IF;

    IF p_descripcionProducto IS NOT NULL AND CHAR_LENGTH(p_descripcionProducto) > 500 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Descripción demasiado larga';
    END IF;

    IF p_imgProducto IS NOT NULL AND CHAR_LENGTH(p_imgProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de imagen demasiado largo';
    END IF;

    -- Validar existencia de categoría
    IF p_idCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen si se proporciona
    IF p_imgProducto IS NOT NULL AND (p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Actualizar el producto si todas las validaciones son exitosas
    UPDATE tbproducto
    SET 
        nombreProducto = IFNULL(p_nombreProducto, nombreProducto),
        imgProducto = IFNULL(p_imgProducto, imgProducto),
        montoPrecioProducto = IFNULL(p_montoPrecioProducto, montoPrecioProducto),
        descripcionProducto = IFNULL(p_descripcionProducto, descripcionProducto),
        cantidadProducto = ifnull(p_cantidadProducto, cantidadProducto),
        tipoPesoProducto = IFNULL(p_tipoPesoProducto, tipoPesoProducto),
        codigoProducto = IFNULL(p_codigoProducto, codigoProducto),
        stockProducto = IFNULL(p_stockProducto, stockProducto),
        idCategoria = IFNULL(p_idCategoria, idCategoria),
        estadoProducto = IFNULL(p_estadoProducto, estadoProducto)
    WHERE idProducto = p_idProducto;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarPromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarPromocion`(IN `p_idPromocion` INT,  
	IN `p_descripcionPromocion` VARCHAR(1000), 
    IN `p_fechaInicioPromocion` DATE, 
    IN `p_fechaFinPromocion` DATE, 
    IN `p_montoPromocion` DECIMAL(10,3),  
    IN `p_idProducto` INT)
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    

    -- Actualizar el producto si todas las validaciones son exitosas
    UPDATE tbpromocion
    SET 
         descripcionPromocion= IFNULL(p_descripcionPromocion, descripcionPromocion),
        fechaInicioPromocion = IFNULL(p_fechaInicioPromocion, fechaInicioPromocion),
        fechaFinPromocion = IFNULL(p_fechaFinPromocion, fechaFinPromocion),
        montoPromocion = IFNULL(p_montoPromocion, montoPromocion),
        idProducto = IFNULL(p_idProducto, idProducto)
    WHERE idPromocion = p_idPromocion;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarRol`(IN `p_idRol` INT(10), IN `p_nombre` VARCHAR(255), IN `p_descripcion` VARCHAR(255), IN `p_estado` TINYINT)
BEGIN
    -- Actualiza los campos del rol, incluyendo el estado
    UPDATE tbRol
    SET nombreRol = p_nombre,
        descripcionRol = p_descripcion,
        estadoRol = p_estado -- Actualizar el estado
    WHERE idRol = p_idRol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarStock`(IN `p_idProducto` INT,
 IN `p_cantidadProducto` INT)
BEGIN
    DECLARE restarStock INT;
    
    SELECT stockProducto INTO restarStock
    FROM tbproducto
    WHERE idProducto = p_idProducto;
    
    IF restarStock < p_cantidadProducto THEN
    ROLLBACK;
        SELECT 'No hay suficientes productos en stock.' AS mensaje;
    END IF;
    
    SET restarStock = restarStock - p_cantidadProducto;
    
    UPDATE tbproducto
    SET stockProducto = restarStock
    WHERE idProducto = p_idProducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarTipoPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarTipoPago`(IN `p_idTipoPago` INT, IN `p_descripcionTipoPago` VARCHAR(255), IN `p_estado` INT)
BEGIN
    
    UPDATE tbtipopago
    SET descripcionTipoPago = p_descripcionTipoPago,
        estadoTipoPago = p_estado 
    WHERE idTipoPago = p_idTipoPago;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarUsuario`(IN `p_idUsuario` INT,
 IN `p_cedulaUsuario` VARCHAR(255),
 IN `p_nombreUsuario` VARCHAR(255),
 IN `p_primerApellido` VARCHAR(255),
 IN `p_segundoApellido` VARCHAR(255), 
 IN `p_telefonoUsuario` VARCHAR(255),
 IN `p_correoUsuario` VARCHAR(255), 
 IN `p_contraseniaUsuario` VARCHAR(255), 
 IN `p_fechaNacimiento` DATE, 
 IN `p_descripcionDireccion` VARCHAR(255), 
 IN `p_codigoPostalDireccion` VARCHAR(255), 
 IN `p_idDistrito` INT, 
 IN `p_idRol` INT, 
 IN `p_estadoUsuario` TINYINT)
BEGIN
    DECLARE existingCount INT;

    -- Verificar si la cédula ya existe en otro registro
    IF p_cedulaUsuario IS NOT NULL THEN
        SELECT COUNT(*) INTO existingCount
        FROM tbusuario
        WHERE cedulaUsuario = p_cedulaUsuario AND idUsuario != p_idUsuario;
        
        IF existingCount > 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'La cédula ya está registrada en otro usuario.';
        END IF;
    END IF;

    -- Verificar si el correo ya existe en otro registro
    IF p_correoUsuario IS NOT NULL THEN
        SELECT COUNT(*) INTO existingCount
        FROM tbusuario
        WHERE correoUsuario = p_correoUsuario AND idUsuario != p_idUsuario;
        
        IF existingCount > 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El correo ya está registrado en otro usuario.';
        END IF;
    END IF;

    -- Verificar si el teléfono ya existe en otro registro
    IF p_telefonoUsuario IS NOT NULL THEN
        SELECT COUNT(*) INTO existingCount
        FROM tbusuario
        WHERE telefonoUsuario = p_telefonoUsuario AND idUsuario != p_idUsuario;
        
        IF existingCount > 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El teléfono ya está registrado en otro usuario.';
        END IF;
    END IF;

    -- Actualizar la información del usuario, incluyendo el estado
    UPDATE tbusuario
    SET cedulaUsuario = IF(p_cedulaUsuario IS NOT NULL, p_cedulaUsuario, cedulaUsuario),
        nombreUsuario = IF(p_nombreUsuario IS NOT NULL, p_nombreUsuario, nombreUsuario),
        primerApellido = IF(p_primerApellido IS NOT NULL, p_primerApellido, primerApellido),
        segundoApellido = IF(p_segundoApellido IS NOT NULL, p_segundoApellido, segundoApellido),
        telefonoUsuario = IF(p_telefonoUsuario IS NOT NULL, p_telefonoUsuario, telefonoUsuario),
        correoUsuario = IF(p_correoUsuario IS NOT NULL, p_correoUsuario, correoUsuario),
        contraseniaUsuario = IF(p_contraseniaUsuario IS NOT NULL, p_contraseniaUsuario, contraseniaUsuario),
        fechaNacimiento = IF(p_fechaNacimiento IS NOT NULL, p_fechaNacimiento, fechaNacimiento),
        idRol = IF(p_idRol IS NOT NULL, p_idRol, idRol),
        estadoUsuario = IF(p_estadoUsuario IS NOT NULL, p_estadoUsuario, estadoUsuario) -- Actualiza el estado
    WHERE idUsuario = p_idUsuario;

    -- Obtener el idDireccion del usuario
    SELECT idDireccion INTO @idDireccion FROM tbusuario WHERE idUsuario = p_idUsuario;

    -- Actualizar la información de la dirección relacionada
    UPDATE tbdireccion
    SET descripcionDireccion = COALESCE(p_descripcionDireccion, descripcionDireccion),
        codigoPostalDireccion = COALESCE(p_codigoPostalDireccion, codigoPostalDireccion),
        idDistrito = COALESCE(p_idDistrito, idDistrito)
    WHERE idDireccion = @idDireccion;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarCarrito`(
    IN `p_idUsuario` INT, 
    IN `p_montoTotalCarrito` DECIMAL(38,2), 
    IN `p_estadoCarrito` TINYINT(1),
    IN `p_cantidadCarrito` INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción del carrito';
    END;

    START TRANSACTION;

    -- Validaciones mejoradas
    IF p_idUsuario IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID de usuario es requerido';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM tbusuario WHERE idUsuario = p_idUsuario) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no existe';
    END IF;

    IF p_montoTotalCarrito IS NULL OR p_montoTotalCarrito <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Monto total debe ser mayor a cero';
    END IF;

    IF p_cantidadCarrito IS NULL OR p_cantidadCarrito <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad debe ser positiva';
    END IF;

    -- INSERT corregido (eliminé p_montoPrecioProducto que no es parámetro)
    INSERT INTO tbcarrito (
        idUsuario, 
        montoTotalCarrito, 
        cantidadCarrito, 
        estadoCarrito
    )
    VALUES (
        p_idUsuario, 
        p_montoTotalCarrito, 
        p_cantidadCarrito, 
        p_estadoCarrito
    );

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarCarritoProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarCarritoProducto`(
    IN p_idCarrito INT,
    IN p_idProducto INT,
    IN p_cantidadProducto INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al agregar producto al carrito';
    END;
    
    START TRANSACTION;
    
    -- Validaciones
    IF NOT EXISTS (SELECT 1 FROM tbcarrito WHERE idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Carrito no existe';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM tbproducto WHERE idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe';
    END IF;
    
    IF p_cantidadProducto <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad debe ser mayor a cero';
    END IF;
    
    -- Inserción
    INSERT INTO tbcarritoproducto (idCarrito, idProducto, cantidadProducto)
    VALUES (p_idCarrito, p_idProducto, p_cantidadProducto);
    
    COMMIT;
    
    -- Retornar el ID del nuevo registro
    SELECT LAST_INSERT_ID() AS idCarritoProducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarCategoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarCategoria`(IN `nombreCategoria` VARCHAR(255), IN `descripcionCategoria` VARCHAR(255), IN `estadoCategoria` INT)
BEGIN
    
    INSERT INTO tbcategoria (nombreCategoria, descripcionCategoria, estadoCategoria)
    VALUES (nombreCategoria, descripcionCategoria, estadoCategoria);

    
    SELECT LAST_INSERT_ID() AS idCategoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarComentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarComentario`(IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `p_idUsuario` INT, IN `p_numCalificacionComentario` INT)
BEGIN
    -- Manejador de errores para capturar excepciones SQL gen ricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al agregar el comentario';
    END;

    -- Iniciar la transacci n
    START TRANSACTION;

    
        -- Insertar en la tabla comentario sin incluir el campo autoincremental idComentario
        INSERT INTO tbcomentario (descripcionComentario, fechaComentario, idUsuario, numCalificacion, verificacion)
        VALUES (p_descripcionComentario, p_fechaComentario, p_idUsuario, p_numCalificacionComentario,0);

        -- Hacer commit si todo est  bien
        COMMIT;
   

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarDireccionUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarDireccionUsuario`(
    IN p_idUsuario INT,
    IN p_descripcion VARCHAR(255),
    IN p_codigoPostal VARCHAR(255),
    IN p_idDistrito INT,
    OUT p_resultado INT
)
BEGIN
    DECLARE v_idDireccionExistente INT DEFAULT NULL;
    
    -- Obtener dirección actual del usuario (si existe)
    SELECT idDireccion INTO v_idDireccionExistente 
    FROM tbusuario 
    WHERE idUsuario = p_idUsuario;
    
    -- Validar que el distrito exista
    IF NOT EXISTS (SELECT 1 FROM tbdistrito WHERE idDistrito = p_idDistrito) THEN
        SET p_resultado = 0; -- Código de error: distrito no válido
    ELSE
        -- Si ya tiene dirección asignada, actualizarla
        IF v_idDireccionExistente IS NOT NULL THEN
            UPDATE tbdireccion 
            SET 
                descripcionDireccion = p_descripcion,
                codigoPostalDireccion = p_codigoPostal,
                idDistrito = p_idDistrito
            WHERE idDireccion = v_idDireccionExistente;
            
            SET p_resultado = 1; -- Actualización exitosa
        ELSE
            -- Crear nueva dirección
            INSERT INTO tbdireccion (
                descripcionDireccion, 
                codigoPostalDireccion, 
                idDistrito
            ) VALUES (
                p_descripcion, 
                p_codigoPostal, 
                p_idDistrito
            );
            
            -- Asignar la nueva dirección al usuario
            UPDATE tbusuario 
            SET idDireccion = LAST_INSERT_ID() 
            WHERE idUsuario = p_idUsuario;
            
            SET p_resultado = 2; -- Creación exitosa
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarNotificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarNotificacion`(
IN `p_descripcionNotificacion` VARCHAR(255), 
IN `p_idUsuario` INT,
IN `p_fechaNotificacion` DATE)
BEGIN
    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al agregar el comentario';
    END;
    -- Iniciar la transacción
    START TRANSACTION;
    INSERT INTO tbnotificacion (descripcionNotificacion, idUsuario, leidos, fechaNotificacion)
    VALUES (p_descripcionNotificacion, p_idUsuario, 1, p_fechaNotificacion);
    
    SELECT LAST_INSERT_ID() AS idNotificacion;
    -- Hacer commit si todo está bien
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarPedido`(
    IN p_montoTotalPedido DECIMAL(38,2),
    IN p_fechaPedido DATETIME(6),
    IN p_estadoPedido BIT(1),
    IN p_estadoEntregaPedido VARCHAR(255),
    IN p_idCarrito INT,
    IN p_idTipoPago INT,
    IN p_productos JSON -- Nuevo parámetro para recibir los productos
)
BEGIN
    DECLARE v_idPedido INT;
    DECLARE v_idProducto INT;
    DECLARE v_cantidad INT;
    DECLARE v_precioUnitario DECIMAL(38,2);
    DECLARE i INT DEFAULT 0;
    DECLARE v_count INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al agregar el pedido' AS Mensaje;
    END;
    
    START TRANSACTION;
    
    -- Validaciones básicas
    IF p_montoTotalPedido IS NULL OR p_fechaPedido IS NULL OR 
       p_idCarrito IS NULL OR p_idTipoPago IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Parámetros obligatorios no pueden ser nulos';
    END IF;
    
    -- Validar relaciones
    IF NOT EXISTS (SELECT 1 FROM tbcarrito WHERE idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carrito especificado no existe';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM tbtipopago WHERE idTipoPago = p_idTipoPago) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de pago especificado no existe';
    END IF;
    
    -- Insertar el pedido
    INSERT INTO tbpedido (
        montoTotalPedido,
        fechaPedido,
        estadoPedido,
        estadoEntregaPedido,
        idCarrito,
        idTipoPago
    ) VALUES (
        p_montoTotalPedido,
        p_fechaPedido,
        p_estadoPedido,
        p_estadoEntregaPedido,
        p_idCarrito,
        p_idTipoPago
    );
    
    -- Obtener el ID del pedido recién insertado
    SET v_idPedido = LAST_INSERT_ID();
    
    -- Procesar los productos si se proporcionaron
    IF p_productos IS NOT NULL THEN
        -- Obtener la cantidad de productos
        SET v_count = JSON_LENGTH(p_productos);
        
        -- Recorrer cada producto y agregarlo a tbpedidoproducto
        WHILE i < v_count DO
            SET v_idProducto = JSON_EXTRACT(p_productos, CONCAT('$[', i, '].idProducto'));
            SET v_cantidad = JSON_EXTRACT(p_productos, CONCAT('$[', i, '].cantidad'));
            SET v_precioUnitario = JSON_EXTRACT(p_productos, CONCAT('$[', i, '].precioUnitario'));
            
            -- Insertar en la tabla relacional
            INSERT INTO tbpedidoproducto (idPedido, idProducto, cantidad, precioUnitario)
            VALUES (v_idPedido, v_idProducto, v_cantidad, v_precioUnitario);
            
            SET i = i + 1;
        END WHILE;
    END IF;
    
    -- Retornar el ID del pedido creado
    SELECT v_idPedido AS idPedido, 'Pedido agregado exitosamente' AS Mensaje;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarProducto`(
    IN `p_nombreProducto` VARCHAR(255), 
    IN `p_imgProducto` VARCHAR(255), 
    IN `p_montoPrecioProducto` DECIMAL(12,2), 
    IN `p_descripcionProducto` VARCHAR(255), 
    IN `p_cantidadProducto` DECIMAL(10,2), 
    IN `p_tipoPesoProducto` VARCHAR(50), 
    IN `p_codigoProducto` VARCHAR(50), 
    IN `p_stockProducto` INT, 
    IN `p_idCategoria` INT, 
    IN `p_estadoProducto` TINYINT(1)
)
BEGIN
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción del producto';
    END;

    -- Iniciar transacción
    START TRANSACTION;

    -- Validar campos obligatorios y sus longitudes
    IF p_nombreProducto IS NULL OR CHAR_LENGTH(p_nombreProducto) = 0 OR CHAR_LENGTH(p_nombreProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de producto inválido';
    END IF;

    IF p_montoPrecioProducto IS NULL OR p_montoPrecioProducto <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio debe ser mayor a cero';
    END IF;

    IF p_descripcionProducto IS NOT NULL AND CHAR_LENGTH(p_descripcionProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Descripción demasiado larga';
    END IF;

    IF p_imgProducto IS NOT NULL AND CHAR_LENGTH(p_imgProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de imagen demasiado largo';
    END IF;

    IF p_codigoProducto IS NOT NULL AND CHAR_LENGTH(p_codigoProducto) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código de producto demasiado largo';
    END IF;

    IF p_tipoPesoProducto IS NOT NULL AND CHAR_LENGTH(p_tipoPesoProducto) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de peso demasiado largo';
    END IF;

    -- Validar existencia de categoría
    IF NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen (extensiones permitidas: .jpg, .png, .jpeg)
    IF p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg" THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Validar cantidad y stock
    IF p_cantidadProducto IS NOT NULL AND p_cantidadProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad de producto no puede ser negativa';
    END IF;

    IF p_stockProducto IS NOT NULL AND p_stockProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock de producto no puede ser negativo';
    END IF;

    -- Validación de unicidad del nombre dentro de la categoría
    IF EXISTS (SELECT 1 FROM tbproducto WHERE nombreProducto = p_nombreProducto AND idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto ya existe en esta categoría';
    END IF;

    -- Insertar el producto si todas las validaciones son exitosas
    INSERT INTO tbproducto (
        nombreProducto, imgProducto, montoPrecioProducto, descripcionProducto, 
        cantidadProducto, tipoPesoProducto, codigoProducto, stockProducto, 
        idCategoria, estadoProducto
    )
    VALUES (
        p_nombreProducto, p_imgProducto, p_montoPrecioProducto, p_descripcionProducto, 
        p_cantidadProducto, p_tipoPesoProducto, p_codigoProducto, p_stockProducto, 
        p_idCategoria, p_estadoProducto
    );

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarPromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarPromocion`(
    IN `p_descripcionPromocion` VARCHAR(1000), 
    IN `p_fechaInicioPromocion` DATE, 
    IN `p_fechaFinPromocion` DATE, 
    IN `p_montoPromocion` DECIMAL(10,3),  
    IN `p_idProducto` INT
)
BEGIN
    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Rollback en caso de error y lanzar mensaje de error
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error al procesar la transacción en el procedimiento almacenado';
    END;

    -- Iniciar la transacción
    START TRANSACTION;


    -- Insertar en la tabla promoción
    INSERT INTO tbpromocion (
        descripcionPromocion, 
        fechaInicioPromocion, 
        fechaFinPromocion, 
        montoPromocion, 
        estadoPromocion, 
        idProducto
    )
    VALUES (
        p_descripcionPromocion, 
        p_fechaInicioPromocion, 
        p_fechaFinPromocion, 
        p_montoPromocion, 
        1, 
        p_idProducto
    );

    -- Confirmar la transacción si todo está bien
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarRol`(IN `nombreRol` VARCHAR(255), IN `descripcionRol` VARCHAR(255), IN `estadoRol` TINYINT)
BEGIN
    -- Inserta el nuevo rol en la tabla incluyendo el estado
    INSERT INTO tbrol (nombreRol, descripcionRol, estadoRol)
    VALUES (nombreRol, descripcionRol, estadoRol);

    SELECT * FROM tbrol WHERE idRol = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarTipoPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarTipoPago`(
    IN `p_descripcionTipoPago` VARCHAR(255), 
    IN `p_estadoTipoPago` INT
)
BEGIN
    -- Insertar un nuevo tipo de pago en la tabla
    INSERT INTO tbtipopago (descripcionTipoPago, estadoTipoPago)
    VALUES (p_descripcionTipoPago, p_estadoTipoPago);

    -- Retornar el ID generado
    SELECT LAST_INSERT_ID() AS idTipoPago;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarUsuario`(IN `p_cedulaUsuario` VARCHAR(255), IN `p_nombreUsuario` VARCHAR(255), IN `p_primerApellido` VARCHAR(255), IN `p_segundoApellido` VARCHAR(255), IN `p_telefonoUsuario` VARCHAR(255), IN `p_correoUsuario` VARCHAR(255), IN `p_contraseniaUsuario` VARCHAR(255), IN `p_fechaNacimiento` DATE, IN `p_descripcionDireccion` VARCHAR(255), IN `p_codigoPostalDireccion` VARCHAR(255), IN `p_idDistrito` INT, IN `p_idRol` INT, IN `p_estadoUsuario` TINYINT)
BEGIN
    -- Variable de control
    DECLARE done INT DEFAULT 0;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Validar si algún campo obligatorio es nulo o vacío
    IF p_cedulaUsuario IS NULL OR p_cedulaUsuario = '' THEN
        SET done = 1;
    END IF;

    IF done = 0 AND (p_nombreUsuario IS NULL OR p_nombreUsuario = '') THEN
        SET done = 1;
    END IF;

    IF done = 0 AND (p_primerApellido IS NULL OR p_primerApellido = '') THEN
        SET done = 1;
    END IF;

    IF done = 0 AND (p_segundoApellido IS NULL OR p_segundoApellido = '') THEN
        SET done = 1;
    END IF;

    IF done = 0 AND (p_contraseniaUsuario IS NULL OR p_contraseniaUsuario = '') THEN
        SET done = 1;
    END IF;

    IF done = 0 AND (p_telefonoUsuario IS NULL OR p_telefonoUsuario = '') THEN
        SET done = 1;
    END IF;

    IF done = 0 AND (p_correoUsuario IS NULL OR p_correoUsuario = '') THEN
        SET done = 1;
    END IF;

    -- Validar que el correo no esté registrado
    IF done = 0 AND EXISTS (SELECT 1 FROM tbusuario WHERE correoUsuario = p_correoUsuario) THEN
        SET done = 1;
    END IF;

    -- Validar que la cédula no esté registrada
    IF done = 0 AND EXISTS (SELECT 1 FROM tbusuario WHERE cedulaUsuario = p_cedulaUsuario) THEN
        SET done = 1;
    END IF;

    -- Validar que el teléfono no esté registrado
    IF done = 0 AND EXISTS (SELECT 1 FROM tbusuario WHERE telefonoUsuario = p_telefonoUsuario) THEN
        SET done = 1;
    END IF;

    -- Solo proceder si no hubo errores
    IF done = 0 THEN
        -- Insertar en la tabla de direcciones
        INSERT INTO tbdireccion (codigoPostalDireccion, descripcionDireccion, idDistrito)
        VALUES (IFNULL(p_codigoPostalDireccion, NULL), p_descripcionDireccion, p_idDistrito);

        -- Obtener el ID de la dirección insertada
        SET @idDireccion = LAST_INSERT_ID();

        -- Insertar en la tabla de usuarios, incluyendo el estado
        INSERT INTO tbusuario (cedulaUsuario, nombreUsuario, primerApellido, segundoApellido, telefonoUsuario, correoUsuario, contraseniaUsuario, fechaNacimiento, idDireccion, idRol, estadoUsuario)
        VALUES (p_cedulaUsuario, p_nombreUsuario, p_primerApellido, p_segundoApellido, p_telefonoUsuario, p_correoUsuario, p_contraseniaUsuario, IFNULL(p_fechaNacimiento, NULL), @idDireccion, p_idRol, p_estadoUsuario);

        -- Confirmar la transacción
        COMMIT;
    ELSE
        -- Si hubo errores, deshacer la transacción
        ROLLBACK;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spBuscarProductoPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarProductoPorId`(IN p_idProducto INT)
BEGIN
    -- Selecciona todos los campos del usuario basándose en el correo proporcionado
    SELECT 
        p.idProducto, 
        p.nombreProducto, 
        p.imgProducto, 
        p.montoPrecioProducto, 
        p.descripcionProducto,
        p.cantidadProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria, 
        p.estadoProducto
       
    FROM 
        tbproducto p

        WHERE p.idProducto = p_idProducto;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spBuscarUsuarioPorCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarUsuarioPorCorreo`(IN `correoInput` VARCHAR(255))
BEGIN
    -- Selecciona todos los campos del usuario basándose en el correo proporcionado
    SELECT 
        u.idUsuario, 
        u.nombreUsuario, 
        u.primerApellido, 
        u.segundoApellido, 
        u.fechaNacimiento, 
        u.cedulaUsuario, 
        u.correoUsuario, 
        u.telefonoUsuario, 
        u.contraseniaUsuario,  -- Contraseña encriptada
        u.idRol,  -- ID del Rol del Usuario
        r.nombreRol,  -- Nombre del Rol
        r.descripcionRol, -- Descripción del Rol
        u.idDireccion,  -- ID de la dirección
        u.estadoUsuario  -- Incluir el estado del usuario
    FROM 
        tbusuario u
    LEFT JOIN 
        tbrol r ON u.idRol = r.idRol
    WHERE 
        u.correoUsuario = correoInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCambiarContrasenaConCodigo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCambiarContrasenaConCodigo`(
    IN p_numCodigo VARCHAR(6),
    IN p_nuevaContrasenia VARCHAR(255),
    IN p_nuevoCodigo VARCHAR(6))
BEGIN
    DECLARE v_idUsuario INT;

    -- Obtener el ID del usuario asociado al código de verificación
    SELECT idUsuario INTO v_idUsuario
    FROM tbcodigoverificacion
    WHERE numCodigo = p_numCodigo;

    IF v_idUsuario IS NULL THEN
        -- Si no se encuentra el usuario, devolver 0 (error)
        SELECT 0 AS resultado;
    ELSE
        -- Actualizar la contraseña del usuario
        UPDATE tbusuario
        SET contraseniaUsuario = p_nuevaContrasenia
        WHERE idUsuario = v_idUsuario;

        -- Actualizar el código de verificación en tbcodigoverificacion
        UPDATE tbcodigoverificacion
        SET numCodigo = p_nuevoCodigo
        WHERE idUsuario = v_idUsuario;

        -- Devolver 1 (éxito)
        SELECT 1 AS resultado;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarCategoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarCategoria`(IN `p_idCategoria` INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      
        ROLLBACK;
        SELECT 'Error al intentar eliminar la categoría' AS mensaje;
    END;

    START TRANSACTION;

   
    IF EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
     
        UPDATE tbcategoria
        SET estadoCategoria = 0
        WHERE idCategoria = p_idCategoria;

        COMMIT;
        SELECT 'Categoría desactivada con éxito' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Categoría no encontrada' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarComentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarComentario`(IN `p_idComentario` INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al intentar actualizar la verificación del comentario' AS mensaje;
    END;

    START TRANSACTION;

    IF EXISTS (SELECT 1 FROM tbcomentario WHERE idComentario = p_idComentario) THEN
        -- Actualizar la verificación a 0 en lugar de eliminar el comentario
        UPDATE tbcomentario
        SET verificacion = 0
        WHERE idComentario = p_idComentario;

        COMMIT;
        SELECT 'Comentario marcado como no verificado con éxito' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Error: comentario no encontrado' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarNotificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarNotificacion`(
IN `p_idNotificacion` INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar la notificación';
    END;
    -- Iniciar transacción
    START TRANSACTION;
    -- Verificar si la notificación existe antes de eliminar
    IF NOT EXISTS (SELECT 1 FROM tbnotificacion WHERE idNotificacion = p_idNotificacion) THEN
        SELECT 'La notificación no existe' AS mensaje;
    ELSE
        -- Eliminar la notificación
        DELETE FROM tbnotificacion WHERE idNotificacion = p_idNotificacion;
        SELECT CONCAT('Notificación con ID ', p_idNotificacion, ' eliminada correctamente.') AS Mensaje;
    END IF;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarPedido`(
    IN p_idPedido INT
)
BEGIN
    DECLARE v_idCarrito INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al eliminar el pedido' AS Mensaje;
    END;

    START TRANSACTION;

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM tbpedido WHERE idPedido = p_idPedido) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El pedido especificado no existe';
    END IF;

    -- Obtener el idCarrito asociado al pedido
    SELECT idCarrito INTO v_idCarrito
    FROM tbpedido
    WHERE idPedido = p_idPedido;

    -- Eliminar productos del carrito (dependen del carrito)
    DELETE FROM tbcarritoproducto WHERE idCarrito = v_idCarrito;

    -- Eliminar el carrito
    DELETE FROM tbcarrito WHERE idCarrito = v_idCarrito;

    -- Eliminar el pedido (esto también borra tbpedidoproducto por ON DELETE CASCADE)
    DELETE FROM tbpedido WHERE idPedido = p_idPedido;

    COMMIT;

    SELECT 'Pedido, carrito y productos relacionados eliminados correctamente' AS Mensaje;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarProducto`(IN `p_idProducto` INT)
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Error al desactivar el producto' AS mensaje;
    END;

    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbproducto WHERE idProducto = p_idProducto) THEN
        SET done = 1;
        SELECT 'Producto no encontrado' AS mensaje;
    END IF;

    IF done = 0 THEN
        UPDATE tbproducto
        SET estadoProducto = 0
        WHERE idProducto = p_idProducto;

        SELECT 'Producto desactivado con éxito' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarPromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarPromocion`(IN `p_idPromocion` INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      
        ROLLBACK;
        SELECT 'Error al intentar eliminar la promocion' AS mensaje;
    END;

    START TRANSACTION;

   
    IF EXISTS (SELECT 1 FROM tbpromocion WHERE idPromocion = p_idPromocion) THEN
     
        UPDATE tbpromocion
        SET estadoPromocion = 0
        WHERE idPromocion = p_idPromocion;

        COMMIT;
        SELECT 'Promocion desactivada con éxito' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Promocion no encontrada' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarRol`(IN `p_idRol` INT)
BEGIN
    -- Verificar si el rol existe antes de intentar desactivarlo
    IF EXISTS (SELECT 1 FROM tbrol WHERE idRol = p_idRol) THEN
        -- En lugar de eliminar, actualizar el estado a 0
        UPDATE tbrol
        SET estadoRol = 0
        WHERE idRol = p_idRol;

        -- Confirmar la actualización
        SELECT 'Rol desactivado con éxito' AS mensaje;
    ELSE
        -- Mensaje si el rol no se encuentra
        SELECT 'Rol no encontrado' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarTipoPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarTipoPago`(IN `p_idTipoPago` INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al intentar eliminar el tipo de pago' AS mensaje;
    END;

    START TRANSACTION;

    -- Verificar si el tipo de pago existe
    IF EXISTS (SELECT 1 FROM tbtipopago WHERE idTipoPago = p_idTipoPago) THEN
     
        -- Desactivar el tipo de pago en lugar de eliminarlo físicamente
        UPDATE tbtipopago
        SET estadoTipoPago = 0
        WHERE idTipoPago = p_idTipoPago;

        COMMIT;
        SELECT 'Tipo de pago desactivado con éxito' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Tipo de pago no encontrado' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario`(IN `p_idUsuario` INT)
BEGIN
    
    DECLARE done INT DEFAULT 0;

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      
        ROLLBACK;
     
        SELECT 'Error al desactivar el usuario' AS mensaje;
    END;

    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbusuario WHERE idUsuario = p_idUsuario) THEN
     
        SET done = 1;
       
        SELECT 'Usuario no encontrado' AS mensaje;
    END IF;

    IF done = 0 THEN
        
        UPDATE tbusuario
        SET estadoUsuario = 0
        WHERE idUsuario = p_idUsuario;

    
        SELECT 'Usuario desactivado con éxito' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spFiltrarPedidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spFiltrarPedidos`(
    IN p_idUsuario INT,
    IN p_estadoEntregaPedido VARCHAR(50),  -- Cambiado de INT a VARCHAR(50)
    IN p_fechaInicio DATETIME,
    IN p_fechaFin DATETIME,
    IN p_estadoPedido INT
)
BEGIN
    -- Variables para construir la consulta dinámica
    DECLARE whereClause VARCHAR(1000);
    
    -- Construir la cláusula WHERE base
    SET whereClause = ' WHERE c.idUsuario = p_idUsuario';
    
    -- Agregar condición de filtro por estadoEntregaPedido si se proporciona (ahora como string)
    IF p_estadoEntregaPedido IS NOT NULL AND p_estadoEntregaPedido != '' THEN
    SET whereClause = CONCAT(whereClause, ' AND p.estadoEntregaPedido = "', p_estadoEntregaPedido, '"');
	END IF;
    
    -- Agregar condición de filtro por fechas si se proporcionan (usando DATETIME)
    IF p_fechaInicio IS NOT NULL AND p_fechaFin IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.fechaPedido BETWEEN "', p_fechaInicio, '" AND "', p_fechaFin, '"');
    ELSEIF p_fechaInicio IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.fechaPedido >= "', p_fechaInicio, '"');
    ELSEIF p_fechaFin IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.fechaPedido <= "', p_fechaFin, '"');
    END IF;
    
    -- Agregar condición de filtro por estadoPedido si se proporciona
    IF p_estadoPedido IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.estadoPedido = ', p_estadoPedido);
    END IF;
    
    -- Reemplazar el parámetro en la cláusula WHERE
    SET @sql = REPLACE(whereClause, 'p_idUsuario', p_idUsuario);
    
    -- Construir la consulta completa
    SET @fullQuery = CONCAT('
        SELECT 
            p.idPedido,
            p.montoTotalPedido,
            p.fechaPedido,
            p.estadoPedido,
            CASE 
                WHEN p.estadoPedido = 1 THEN "Activo"
                ELSE "Inactivo"
            END AS estadoPedidoTexto,
            p.estadoEntregaPedido,
            p.idCarrito,
            p.idTipoPago,
            
            -- Información del Tipo de Pago
            tp.descripcionTipoPago,
            tp.estadoTipoPago,
            
            -- Información del Carrito
            c.idUsuario,
            c.montoTotalCarrito,
            c.estadoCarrito,
            c.cantidadCarrito,
            
            -- Información del Usuario
            u.nombreUsuario,
            u.primerApellido,
            u.segundoApellido,
            CONCAT(u.nombreUsuario, " ", u.primerApellido, " ", u.segundoApellido) AS nombreCompletoUsuario,
            u.cedulaUsuario,
            u.correoUsuario,
            u.telefonoUsuario,
            u.fechaNacimiento,
            
            -- Conteo de productos en el carrito
            (
                SELECT COUNT(*) 
                FROM tbcarritoproducto 
                WHERE idCarrito = p.idCarrito
            ) AS cantidadProductosDistintos,
            
            -- Total de items (sumando cantidades)
            (
                SELECT SUM(cantidadProducto) 
                FROM tbcarritoproducto 
                WHERE idCarrito = p.idCarrito
            ) AS cantidadTotalItems,
            
            -- Información del carrito-producto
            cp.idCarritoProducto,
            cp.cantidadProducto,
            
            -- Información del producto
            pr.idProducto,
            pr.nombreProducto,
            pr.imgProducto,
            pr.montoPrecioProducto,
            pr.descripcionProducto,
            pr.cantidadProducto AS stockProducto,
            pr.tipoPesoProducto,
            pr.codigoProducto,
            pr.idCategoria,
            pr.estadoProducto
            
        FROM tbpedido p
        INNER JOIN tbtipopago tp ON p.idTipoPago = tp.idTipoPago
        INNER JOIN tbcarrito c ON p.idCarrito = c.idCarrito
        INNER JOIN tbusuario u ON c.idUsuario = u.idUsuario
        LEFT JOIN tbcarritoproducto cp ON c.idCarrito = cp.idCarrito
        LEFT JOIN tbproducto pr ON cp.idProducto = pr.idProducto', 
        @sql,
        ' ORDER BY p.fechaPedido DESC, pr.nombreProducto ASC');
    
    -- Preparar y ejecutar la consulta
    PREPARE stmt FROM @fullQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerCategoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoria`(IN `p_filtrarInactivos` BOOLEAN)
BEGIN
    IF p_filtrarInactivos THEN
    SELECT * FROM tbcategoria
    WHERE estadoCategoria = 1;
    ELSE
      SELECT * FROM tbcategoria
    ORDER BY estadoCategoria DESC;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerCategoriaPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoriaPorId`(IN `p_idCategoria` INT)
BEGIN
    SELECT 
        idCategoria,
        descripcionCategoria,
        nombreCategoria,
        estadoCategoria
    FROM 
        tbcategoria
    WHERE 
        idCategoria = p_idCategoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerComentarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentarios`()
BEGIN
    SELECT
        c.idComentario,
        c.descripcionComentario,
        c.fechaComentario,
        u.correoUsuario,
        c.numCalificacion,
        c.verificacion
    FROM tbcomentario c 
    INNER JOIN tbusuario u ON c.idUsuario = u.idUsuario
    ORDER BY verificacion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerComentariosAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosAdmin`()
BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerComentariosUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosUsuario`()
BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerDistrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerDistrito`()
BEGIN
    SELECT d.idDistrito, d.nombreDistrito, c.idCanton
    FROM tbdistrito d
    JOIN tbcanton c ON d.idCanton = c.idCanton;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerNotificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerNotificacion`(
IN `p_filtrarLeidos` BOOLEAN)
BEGIN
    IF p_filtrarLeidos THEN
        SELECT * FROM tbnotificacion
        WHERE leidos = 1;
    ELSE
        SELECT * FROM tbnotificacion
        WHERE leidos = 0
        ORDER BY idNotificacion DESC;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerPedido`()
BEGIN
    SELECT 
        idPedido,
        montoTotalPedido,
        fechaPedido,
        estadoPedido,
        estadoEntregaPedido,
        idCarrito,
        idTipoPago
    FROM bdcarniceria.tbpedido
    ORDER BY fechaPedido DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerPedidoDetallado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerPedidoDetallado`()
BEGIN
    -- Listar todos los pedidos con su información relacionada
    SELECT 
        p.idPedido,
        p.montoTotalPedido,
        p.fechaPedido,
        p.estadoPedido,
        CASE 
            WHEN p.estadoPedido = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS estadoPedidoTexto,
        p.estadoEntregaPedido,
        p.idCarrito,
        p.idTipoPago,
        
        -- Información del Tipo de Pago
        tp.descripcionTipoPago,
        tp.estadoTipoPago,
        
        -- Información del Carrito
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito,
        
        -- Información del Usuario
        u.nombreUsuario,
        u.primerApellido,
        u.segundoApellido,
        CONCAT(u.nombreUsuario, ' ', u.primerApellido, ' ', u.segundoApellido) AS nombreCompletoUsuario,
        u.cedulaUsuario,
        u.correoUsuario,
        u.telefonoUsuario,
        u.fechaNacimiento,
        
        -- Conteo de productos en el carrito
        (
            SELECT COUNT(*) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadProductosDistintos,
        
        -- Total de items (sumando cantidades)
        (
            SELECT SUM(cantidadProducto) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadTotalItems,
        
        -- Información del carrito-producto
        cp.idCarritoProducto,
        cp.cantidadProducto,
        
        -- Información del producto
        pr.idProducto,
        pr.nombreProducto,
        pr.imgProducto,
        pr.montoPrecioProducto,
        pr.descripcionProducto,
        pr.cantidadProducto AS stockProducto,
        pr.tipoPesoProducto,
        pr.codigoProducto,
        pr.idCategoria,
        pr.estadoProducto
        
    FROM tbpedido p
    INNER JOIN tbtipopago tp ON p.idTipoPago = tp.idTipoPago
    INNER JOIN tbcarrito c ON p.idCarrito = c.idCarrito
    INNER JOIN tbusuario u ON c.idUsuario = u.idUsuario
    LEFT JOIN tbcarritoproducto cp ON c.idCarrito = cp.idCarrito
    LEFT JOIN tbproducto pr ON cp.idProducto = pr.idProducto
    ORDER BY p.fechaPedido DESC, pr.nombreProducto ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerPedidoDetalladoEntregado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerPedidoDetalladoEntregado`()
BEGIN
    -- Listar todos los pedidos cancelados con su información relacionada
    SELECT 
        p.idPedido,
        p.montoTotalPedido,
        p.fechaPedido,
        p.estadoPedido,
        CASE 
            WHEN p.estadoPedido = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS estadoPedidoTexto,
        p.estadoEntregaPedido,
        p.idCarrito,
        p.idTipoPago,
        
        -- Información del Tipo de Pago
        tp.descripcionTipoPago,
        tp.estadoTipoPago,
        
        -- Información del Carrito
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito,
        
        -- Información del Usuario
        u.nombreUsuario,
        u.primerApellido,
        u.segundoApellido,
        CONCAT(u.nombreUsuario, ' ', u.primerApellido, ' ', u.segundoApellido) AS nombreCompletoUsuario,
        u.cedulaUsuario,
        u.correoUsuario,
        u.telefonoUsuario,
        u.fechaNacimiento,
        
        -- Conteo de productos en el carrito
        (
            SELECT COUNT(*) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadProductosDistintos,
        
        -- Total de items (sumando cantidades)
        (
            SELECT SUM(cantidadProducto) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadTotalItems,
        
        -- Información del carrito-producto
        cp.idCarritoProducto,
        cp.cantidadProducto,
        
        -- Información del producto
        pr.idProducto,
        pr.nombreProducto,
        pr.imgProducto,
        pr.montoPrecioProducto,
        pr.descripcionProducto,
        pr.cantidadProducto AS stockProducto,
        pr.tipoPesoProducto,
        pr.codigoProducto,
        pr.idCategoria,
        pr.estadoProducto
        
    FROM tbpedido p
    INNER JOIN tbtipopago tp ON p.idTipoPago = tp.idTipoPago
    INNER JOIN tbcarrito c ON p.idCarrito = c.idCarrito
    INNER JOIN tbusuario u ON c.idUsuario = u.idUsuario
    LEFT JOIN tbcarritoproducto cp ON c.idCarrito = cp.idCarrito
    LEFT JOIN tbproducto pr ON cp.idProducto = pr.idProducto
    WHERE p.estadoEntregaPedido = 'Entregado'  -- Filtro para solo pedidos cancelados
    ORDER BY p.fechaPedido DESC, pr.nombreProducto ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerPedidosPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerPedidosPorId`(IN p_idUsuario INT)
BEGIN
    -- Listar todos los pedidos con su información relacionada filtrados por idUsuario
    SELECT 
        p.idPedido,
        p.montoTotalPedido,
        p.fechaPedido,
        p.estadoPedido,
        CASE 
            WHEN p.estadoPedido = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS estadoPedidoTexto,
        p.estadoEntregaPedido,
        p.idCarrito,
        p.idTipoPago,
        
        -- Información del Tipo de Pago
        tp.descripcionTipoPago,
        tp.estadoTipoPago,
        
        -- Información del Carrito
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito,
        
        -- Información del Usuario
        u.nombreUsuario,
        u.primerApellido,
        u.segundoApellido,
        CONCAT(u.nombreUsuario, ' ', u.primerApellido, ' ', u.segundoApellido) AS nombreCompletoUsuario,
        u.cedulaUsuario,
        u.correoUsuario,
        u.telefonoUsuario,
        u.fechaNacimiento,
        
        -- Conteo de productos en el carrito
        (
            SELECT COUNT(*) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadProductosDistintos,
        
        -- Total de items (sumando cantidades)
        (
            SELECT SUM(cantidadProducto) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadTotalItems,
        
        -- Información del carrito-producto
        cp.idCarritoProducto,
        cp.cantidadProducto,
        
        -- Información del producto
        pr.idProducto,
        pr.nombreProducto,
        pr.imgProducto,
        pr.montoPrecioProducto,
        pr.descripcionProducto,
        pr.cantidadProducto AS stockProducto,
        pr.tipoPesoProducto,
        pr.codigoProducto,
        pr.idCategoria,
        pr.estadoProducto
        
    FROM tbpedido p
    INNER JOIN tbtipopago tp ON p.idTipoPago = tp.idTipoPago
    INNER JOIN tbcarrito c ON p.idCarrito = c.idCarrito
    INNER JOIN tbusuario u ON c.idUsuario = u.idUsuario
    LEFT JOIN tbcarritoproducto cp ON c.idCarrito = cp.idCarrito
    LEFT JOIN tbproducto pr ON cp.idProducto = pr.idProducto
    WHERE c.idUsuario = p_idUsuario  -- Filtro por idUsuario
    ORDER BY p.fechaPedido DESC, pr.nombreProducto ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerProducto`(IN p_filtrarInactivos BOOLEAN)
BEGIN
   IF p_filtrarInactivos THEN
    SELECT 
        p.idProducto,
        p.nombreProducto,
        p.imgProducto,  -- Ruta relativa de la imagen
        p.montoPrecioProducto,
        p.descripcionProducto,
        p.cantidadProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria,
        c.nombreCategoria,  -- Nombre de la categoría
        p.estadoProducto
    FROM 
        tbproducto p
    JOIN 
        tbcategoria c ON p.idCategoria = c.idCategoria  -- Unión con la tabla de categorías
    WHERE p.estadoProducto = 1;
    ELSE
    SELECT 	
       p.idProducto,
        p.nombreProducto,
        p.imgProducto,  -- Ruta relativa de la imagen
        p.montoPrecioProducto,
        p.descripcionProducto,
        p.cantidadProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria,
        c.nombreCategoria,  -- Nombre de la categoría
        p.estadoProducto
    FROM 
        tbproducto p
    JOIN 
        tbcategoria c ON p.idCategoria = c.idCategoria  -- Unión con la tabla de categorías
    ORDER BY p.estadoProducto DESC;
 
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerPromociones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerPromociones`()
BEGIN
 SELECT 
        p.idPromocion,
        p.descripcionPromocion,
        p.fechaInicioPromocion,
        p.fechaFinPromocion,
        p.montoPromocion,
        p.estadoPromocion,
        c.nombreProducto
    FROM 
        tbpromocion p
    JOIN 
        tbproducto c ON p.idProducto = c.idProducto
    ORDER BY
        p.estadoPromocion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerRol`()
BEGIN
    -- Leer solo los roles donde el estado sea 1 (activo)
    SELECT * FROM tbrol
    WHERE estadoRol = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerTipoPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerTipoPago`()
BEGIN
    -- Leer solo los tipos de pago donde el estado sea 1 (activo)
    SELECT * FROM tbtipopago
    ORDER BY estadoTipoPago DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerTipoPagoPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerTipoPagoPorId`(IN `p_idTipoPago` INT)
BEGIN
    SELECT 
        idTipoPago,
        descripcionTipoPago,
        estadoTipoPago
    FROM 
        tbtipopago
    WHERE 
        idTipoPago = p_idTipoPago;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLeerUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerUsuario`()
BEGIN
  SELECT 
        u.idUsuario, 
        u.cedulaUsuario, 
        u.nombreUsuario, 
        u.primerApellido, 
        u.segundoApellido, 
        u.telefonoUsuario, 
        u.correoUsuario, 
        u.contraseniaUsuario, 
        u.fechaNacimiento,
        u.idDireccion,
        u.idRol, 
        u.estadoUsuario, -- Incluir el estado en la consulta
        d.idDistrito 
    FROM 
        tbusuario u
    LEFT JOIN tbdireccion d ON u.idDireccion = d.idDireccion
    ORDER BY estadoUsuario DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spMarcarNotificacionLeida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMarcarNotificacionLeida`(
    IN `p_idNotificacion` INT  
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al marcar la notificación como leída' AS mensaje;
    END;
    START TRANSACTION;
    -- Verifica si la notificación existe
    IF NOT EXISTS (SELECT 1 FROM tbnotificacion WHERE idNotificacion = p_idNotificacion) THEN
       SELECT 'La notificación no existe' AS mensaje;
    ELSE
        -- Marca como leída
        UPDATE tbnotificacion 
        SET leidos = 0 
        WHERE idNotificacion = p_idNotificacion;
        
        SELECT 'Notificación marcada como leída correctamente.' AS Mensaje;
    END IF;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spMostrarComentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarComentario`(IN `p_idComentario` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE verificacionActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al mostrar el comentario' AS mensaje;
    END;

    -- Verificar si el comentario existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbcomentario WHERE idComentario = p_idComentario) THEN
        SET done = 1;
        SELECT 'Comentario no encontrado' AS mensaje;
    END IF;

    -- Cambiar el estado de verificación si el comentario existe
    IF done = 0 THEN
        -- Obtener el valor actual de verificación
        SELECT verificacion INTO verificacionActual FROM tbcomentario WHERE idComentario = p_idComentario;

        -- Cambiar el valor de verificación a 1 si es 0, o a 0 si es 1
        UPDATE tbcomentario
        SET verificacion = CASE WHEN verificacionActual = 1 THEN 0 ELSE 1 END
        WHERE idComentario = p_idComentario;

        SELECT 'Comentario verificado con éxito' AS mensaje;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerCantonesPorProvincia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerCantonesPorProvincia`(
    IN p_idProvincia INT
)
BEGIN
    SELECT 
        c.idCanton, 
        c.nombreCanton,
        c.idProvincia  -- Añade esta columna esencial
    FROM tbcanton c
    WHERE c.idProvincia = p_idProvincia
    ORDER BY c.nombreCanton;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerCodigoUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerCodigoUsuario`(
    IN p_correoUsuario VARCHAR(255),
    OUT p_numCodigo VARCHAR(6)
)
BEGIN
    DECLARE v_idUsuario INT;
    
    -- Verificar si el correo existe
    SELECT idUsuario INTO v_idUsuario
    FROM tbusuario
    WHERE correoUsuario = p_correoUsuario;
    
    IF v_idUsuario IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no está registrado';
    ELSE
        -- Obtener el código de verificación asociado al usuario
        SELECT numCodigo INTO p_numCodigo
        FROM tbcodigoverificacion
        WHERE idUsuario = v_idUsuario;
        
        IF p_numCodigo IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se encontró un código de verificación para este usuario';
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerDistritosPorCanton` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerDistritosPorCanton`(
    IN p_idCanton INT
)
BEGIN
    SELECT 
        d.idDistrito, 
        d.nombreDistrito,
        d.idCanton  -- Columna esencial para la relación
    FROM tbdistrito d
    WHERE d.idCanton = p_idCanton
    ORDER BY d.nombreDistrito;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerProvincias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerProvincias`()
BEGIN
    SELECT idProvincia, nombreProvincia
    FROM tbprovincia
    ORDER BY nombreProvincia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerTotalVentas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerTotalVentas`(
    IN p_periodo VARCHAR(10) -- 'dia', 'semana', 'mes', 'anio', 'total'
)
BEGIN
    -- Ventas del día actual (canceladas)
    IF p_periodo = 'dia' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'dia' AS periodo
        FROM tbpedido
        WHERE DATE(fechaPedido) = CURDATE()
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas de la semana actual (canceladas)
    ELSEIF p_periodo = 'semana' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'semana' AS periodo
        FROM tbpedido
        WHERE YEARWEEK(fechaPedido, 1) = YEARWEEK(CURDATE(), 1)
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas del mes actual (canceladas)
    ELSEIF p_periodo = 'mes' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'mes' AS periodo
        FROM tbpedido
        WHERE YEAR(fechaPedido) = YEAR(CURDATE())
        AND MONTH(fechaPedido) = MONTH(CURDATE())
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas del año actual (canceladas)
    ELSEIF p_periodo = 'anio' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'anio' AS periodo
        FROM tbpedido
        WHERE YEAR(fechaPedido) = YEAR(CURDATE())
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas totales (canceladas, sin filtro de fecha)
    ELSE
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'total' AS periodo
        FROM tbpedido
        WHERE estadoEntregaPedido = 'Entregado';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerUsuarioById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerUsuarioById`(IN `p_idUsuario` INT)
BEGIN
    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al obtener el usuario';
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Validar si el ID es nulo o menor que 1
    IF p_idUsuario IS NULL OR p_idUsuario < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID de usuario inválido';
    END IF;

    -- Seleccionar el usuario por el ID proporcionado
    SELECT idUsuario, cedulaUsuario, contraseniaUsuario, correoUsuario, fechaNacimiento, 
           nombreUsuario, primerApellido, segundoApellido, telefonoUsuario, idDireccion, 
           idRol, estadoUsuario
    FROM tbusuario
    WHERE idUsuario = p_idUsuario;

    -- Hacer commit si todo está bien
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spRegistrarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegistrarUsuario`(
    IN `p_correoUsuario` VARCHAR(255), 
    IN `p_contraseniaUsuario` VARCHAR(255), 
    IN `p_nombreUsuario` VARCHAR(255), 
    IN `p_primerApellido` VARCHAR(255), 
    IN `p_segundoApellido` VARCHAR(255), 
    IN `p_idRol` INT,  -- Acepta NULL
    IN `p_estadoUsuario` TINYINT,  -- Acepta NULL
    IN `p_numCodigo` VARCHAR(6)  -- Acepta NULL
)
BEGIN
    -- Declarar la variable para almacenar el ID de la dirección insertada
    DECLARE idDireccion INT;
    DECLARE idUsuario INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al agregar el usuario';
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Validar si el correo es nulo o vacío
    IF p_correoUsuario IS NULL OR p_correoUsuario = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Correo vacío';
    END IF;

    -- Validar si la contraseña es nula o vacía
    IF p_contraseniaUsuario IS NULL OR p_contraseniaUsuario = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Contraseña vacía';
    END IF;

    -- Validar si el nombreUsuario es nulo o vacío
    IF p_nombreUsuario IS NULL OR p_nombreUsuario = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de usuario vacío';
    END IF;

    -- Validar si el primerApellido es nulo o vacío
    IF p_primerApellido IS NULL OR p_primerApellido = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Primer apellido vacío';
    END IF;

    -- Validar si el segundoApellido es nulo o vacío
    IF p_segundoApellido IS NULL OR p_segundoApellido = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Segundo apellido vacío';
    END IF;

    -- Validar que el correo sea único
    IF EXISTS (SELECT 1 FROM tbusuario WHERE correoUsuario = p_correoUsuario) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya está registrado';
    END IF;

    -- Insertar la dirección (puede ser NULL si no se proporciona)
    INSERT INTO tbdireccion () VALUES ();

    -- Obtener el ID de la dirección insertada
    SET idDireccion = LAST_INSERT_ID();

    -- Insertar el usuario (manejar valores NULL)
    INSERT INTO tbusuario (
        correoUsuario, 
        contraseniaUsuario, 
        nombreUsuario, 
        primerApellido, 
        segundoApellido, 
        idDireccion, 
        idRol, 
        estadoUsuario
    ) VALUES (
        p_correoUsuario, 
        p_contraseniaUsuario, 
        p_nombreUsuario, 
        p_primerApellido, 
        p_segundoApellido, 
        idDireccion, 
        IFNULL(p_idRol, 3),  -- Si p_idRol es NULL, usar 3 como valor predeterminado
        IFNULL(p_estadoUsuario, 1)  -- Si p_estadoUsuario es NULL, usar 1 (activo) como valor predeterminado
    );

    -- Obtener el ID del usuario insertado
    SET idUsuario = LAST_INSERT_ID();

    -- Insertar el código de verificación (solo si no es NULL)
    IF p_numCodigo IS NOT NULL THEN
        INSERT INTO tbcodigoverificacion (numCodigo, idUsuario)
        VALUES (p_numCodigo, idUsuario);
    END IF;

    -- Hacer commit si todo está bien
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spVerificarCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarCorreo`(IN `p_correoUsuario` VARCHAR(255))
BEGIN
    SELECT COUNT(*) AS existe FROM tbusuario WHERE correoUsuario = p_correoUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spVerificarIDUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarIDUsuario`(IN `p_idUsuario` INT)
BEGIN
    -- Declarar una variable para el resultado
    DECLARE usuarioExiste INT DEFAULT 0;

    -- Validar si el ID del usuario es nulo o menor que 1
    IF p_idUsuario IS NULL OR p_idUsuario <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID de usuario inválido';
    END IF;

    -- Verificar si el usuario con el ID especificado existe y asignar el resultado
    SELECT COUNT(*) INTO usuarioExiste FROM tbusuario WHERE idUsuario = p_idUsuario;

    -- Retornar el resultado
    SELECT usuarioExiste;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AgregarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AgregarPedido`(
    IN p_montoTotalPedido DECIMAL(10,2),
    IN p_fechaPedido DATETIME,
    IN p_estadoPedido BOOLEAN,
    IN p_estadoEntregaPedido VARCHAR(50),
    IN p_idCarrito INT,
    IN p_idTipoPago INT
)
BEGIN
    DECLARE v_idPedido INT;
    
    -- Intenta insertar el pedido directamente
    INSERT INTO bdcarniceria.tbpedido (
        montoTotalPedido,
        fechaPedido,
        estadoPedido,
        estadoEntregaPedido,
        idCarrito,
        idTipoPago
    ) VALUES (
        p_montoTotalPedido,
        p_fechaPedido,
        p_estadoPedido,
        p_estadoEntregaPedido,
        p_idCarrito,
        p_idTipoPago
    );
    
    -- Obtener el ID del pedido recién insertado
    SET v_idPedido = LAST_INSERT_ID();
    
    -- Insertar los productos asociados al carrito en la tabla tbpedidoproducto
    INSERT INTO bdcarniceria.tbpedidoproducto (idPedido, idProducto)
    SELECT v_idPedido, cp.idProducto 
    FROM bdcarniceria.tbcarritoproducto cp
    WHERE cp.idCarrito = p_idCarrito;
    
    -- Devolver el ID del pedido creado
    SELECT v_idPedido AS idPedido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerCarritoPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ObtenerCarritoPorId`(
    IN p_idCarrito INT
)
BEGIN
    SELECT 
        c.idCarrito,
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito
    FROM 
        bdcarniceria.tbcarrito c
    WHERE 
        c.idCarrito = p_idCarrito;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerCarritosUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ObtenerCarritosUsuario`(IN usuario_id INT)
BEGIN
    -- Primera consulta: obtener carritos del usuario
    SELECT 
        c.idCarrito,
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito
    FROM 
        tbcarrito c
    WHERE 
        c.idUsuario = usuario_id;
    
    -- Segunda consulta: obtener productos en los carritos con sus detalles
    SELECT 
        cp.idCarritoProducto,
        cp.idCarrito,
        cp.idProducto,
        cp.cantidadProducto,
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito,
        p.nombreProducto,
        p.imgProducto,
        p.montoPrecioProducto,
        p.descripcionProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria,
        p.estadoProducto
    FROM 
        tbcarritoproducto cp
    INNER JOIN 
        tbcarrito c ON cp.idCarrito = c.idCarrito
    INNER JOIN 
        tbproducto p ON cp.idProducto = p.idProducto
    WHERE 
        c.idUsuario = usuario_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-16 12:37:15
