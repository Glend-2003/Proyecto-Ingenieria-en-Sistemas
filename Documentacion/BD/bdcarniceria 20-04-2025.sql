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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcanton`
--

LOCK TABLES `tbcanton` WRITE;
/*!40000 ALTER TABLE `tbcanton` DISABLE KEYS */;
INSERT INTO `tbcanton` VALUES (1,'Pococí',7),(2,'Guácimo',7),(3,'Siquirres',7),(4,'Matina',7),(5,'Limón',7),(6,'Talamanca',7),(7,'San José',1),(8,'Escazú',1),(9,'Desamparados',1),(10,'Puriscal',1),(11,'Tarrazú',1),(12,'Aserrí',1),(13,'Mora',1),(14,'Goicoechea',1),(15,'Santa Ana',1),(16,'Alajuelita',1),(17,'Vázquez de Coronado',1),(18,'Acosta',1),(19,'Tibás',1),(20,'Moravia',1),(21,'Montes de Oca',1),(22,'Turrubares',1),(23,'Dota',1),(24,'Curridabat',1),(25,'Pérez Zeledón',1),(26,'León Cortés Castro',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcarrito`
--

LOCK TABLES `tbcarrito` WRITE;
/*!40000 ALTER TABLE `tbcarrito` DISABLE KEYS */;
INSERT INTO `tbcarrito` VALUES (37,59,5000.00,0,1),(45,59,2500.00,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcarritoproducto`
--

LOCK TABLES `tbcarritoproducto` WRITE;
/*!40000 ALTER TABLE `tbcarritoproducto` DISABLE KEYS */;
INSERT INTO `tbcarritoproducto` VALUES (72,37,13,1),(80,45,12,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcodigoverificacion`
--

LOCK TABLES `tbcodigoverificacion` WRITE;
/*!40000 ALTER TABLE `tbcodigoverificacion` DISABLE KEYS */;
INSERT INTO `tbcodigoverificacion` VALUES (1,29,'319480',NULL),(2,30,'123432',NULL),(3,31,'441004',NULL),(4,32,'356493',NULL),(5,33,'292243',NULL),(6,34,'947661',NULL),(7,35,'947216',NULL),(24,52,'393498',NULL),(25,53,'098247',NULL),(26,54,'418492',NULL),(27,55,'271699',NULL),(28,56,'601504',NULL),(29,57,'515845',NULL),(30,58,'864579',NULL),(31,59,'241545',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcomentario`
--

LOCK TABLES `tbcomentario` WRITE;
/*!40000 ALTER TABLE `tbcomentario` DISABLE KEYS */;
INSERT INTO `tbcomentario` VALUES (4,'Descripción actualizada22','2024-10-30 12:35:30',6,5,_binary ''),(5,'Este es un comentario de prueba 2','2024-10-29 22:56:00',6,5,_binary ''),(6,'Este es un comentario de prueba 2','2024-10-29 23:07:15',6,5,_binary ''),(7,'Este es un comentario de prueba 2','2024-10-29 23:09:18',6,5,_binary '\0'),(8,'Este es un comentario de prueba 2','2024-10-29 23:11:39',6,5,_binary ''),(9,'Este es un comentario de prueba 2','2024-10-29 23:18:17',6,5,_binary '\0'),(10,'Este es un comentario de prueba 2','2024-10-29 23:18:29',6,5,_binary '\0'),(11,'Este es un comentario de prueba','2024-10-30 09:21:53',11,5,_binary '\0'),(12,'Este es un comentario de prueba.','2024-10-30 10:30:13',11,5,_binary '\0'),(13,'Este es un comentario de prueba.','2024-10-30 11:25:28',11,5,_binary '\0'),(14,'Este es un comentario de prueba.','2024-10-30 11:28:19',11,5,_binary '\0'),(15,'Este es un comentario de prueba.','2024-10-30 11:28:37',11,5,_binary ''),(16,'Este es un comentario de prueba.','2024-10-30 11:33:31',11,5,_binary '\0'),(17,'Este es un comentario de prueba.','2024-10-30 12:26:34',11,5,_binary '\0'),(19,'dwdw','2024-11-04 21:12:48',11,2,_binary ''),(20,'malo','2024-12-11 21:34:47',11,3,_binary '\0'),(21,'zzzz','2024-12-11 21:41:52',11,1,_binary '\0'),(22,'prueba 3','2025-02-26 15:57:08',11,2,_binary '\0');
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdireccion`
--

LOCK TABLES `tbdireccion` WRITE;
/*!40000 ALTER TABLE `tbdireccion` DISABLE KEYS */;
INSERT INTO `tbdireccion` VALUES (13,'1234','Urbanización el Tejar',26),(15,NULL,NULL,NULL),(16,'12345654654','Guacimoooo',3),(18,NULL,NULL,NULL),(20,NULL,NULL,NULL),(21,NULL,NULL,NULL),(22,NULL,NULL,NULL),(23,NULL,NULL,NULL),(24,NULL,NULL,NULL),(27,NULL,NULL,NULL),(32,NULL,NULL,NULL),(33,NULL,NULL,NULL),(34,NULL,NULL,NULL),(35,NULL,NULL,NULL),(36,NULL,NULL,NULL),(37,NULL,NULL,NULL),(38,NULL,NULL,NULL),(39,NULL,NULL,NULL),(40,NULL,NULL,NULL),(41,NULL,NULL,NULL),(42,NULL,NULL,NULL),(43,NULL,NULL,NULL),(44,NULL,NULL,NULL),(45,NULL,NULL,NULL),(46,NULL,NULL,NULL),(47,NULL,NULL,NULL),(48,NULL,NULL,NULL),(49,NULL,NULL,NULL),(50,NULL,NULL,NULL),(51,NULL,NULL,NULL),(52,NULL,NULL,NULL),(53,NULL,NULL,NULL),(54,NULL,NULL,NULL),(55,NULL,NULL,NULL),(56,NULL,NULL,NULL),(57,NULL,NULL,NULL),(58,NULL,NULL,NULL),(59,NULL,NULL,NULL),(60,'00000','San Luis de jimenez',5),(61,NULL,NULL,NULL),(62,NULL,NULL,NULL),(63,NULL,NULL,NULL);
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
  `descripcionNotificacion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idUsuario` int NOT NULL,
  `leidos` tinyint(1) DEFAULT NULL,
  `fechaNotificacion` date DEFAULT NULL,
  PRIMARY KEY (`idNotificacion`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbnotificacion_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbnotificacion`
--

LOCK TABLES `tbnotificacion` WRITE;
/*!40000 ALTER TABLE `tbnotificacion` DISABLE KEYS */;
INSERT INTO `tbnotificacion` VALUES (7,'El cliente ha cancelado su pedido el  por medio de la aplicación.',59,1,'2025-04-20'),(8,'El cliente ha cancelado su pedido el  por medio de la aplicación.',59,1,'2025-04-20');
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedido`
--

LOCK TABLES `tbpedido` WRITE;
/*!40000 ALTER TABLE `tbpedido` DISABLE KEYS */;
INSERT INTO `tbpedido` VALUES (30,2825.00,'2025-03-17 12:22:00.000000',_binary '','Entregado',45,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedidoproducto`
--

LOCK TABLES `tbpedidoproducto` WRITE;
/*!40000 ALTER TABLE `tbpedidoproducto` DISABLE KEYS */;
INSERT INTO `tbpedidoproducto` VALUES (27,30,12);
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
INSERT INTO `tbproducto` VALUES (6,'Producto1','911fe0f1-9987-4506-8a1a-7393ac03f08d.jpg',2300.00,'Descripcion de prueba',100,'Gr','skd002',10,5,0),(7,'PruebaCambios','d8d76da7-8f90-4c6c-95a0-5dba9e97e89e.jpg',9000.00,'Ayer la probe',1,'Ud','sgy882',7,7,0),(8,'Holaa','d0991041-874a-4171-a5c9-9b7f0db2bb4a.png',2222.00,'Depende',2,'Kg','bnw225',4,4,1),(9,'PruebaFinal','8bdd33a9-ca23-4b99-a197-ca570489ce98.jpg',3020.00,'ayer bla bla bla',1,'Ud','fkl490',20,3,0),(10,'Papas','59138d57-d0f8-4fc2-a562-5ca486d44a2a.jpg',1200.00,'ad',1,'ud','12414',11,1,0),(11,'Alitas de pollo','4722713c-8c42-4997-81b9-c92cf44e16ca.png',1500.00,'Alitas de pollo de engorde',1,'Kg','ALA01',100,24,1),(12,'Chuletas','a1da1bbe-d118-42b2-bb00-da3a5519cb3d.png',2500.00,'Chuletas de cerdo de la mas alta calidad',1,'Kg','Ch01',50,3,1),(13,'Punta de solomo','11dbb17d-a326-40fc-a367-09b55926d71f.png',5000.00,'Punta de solomo de Angus',1,'Kg','Pt01',25,2,1);
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
  `fechaInicioPromocion` datetime(6) DEFAULT NULL,
  `fechaFinPromocion` datetime(6) DEFAULT NULL,
  `montoPromocion` decimal(38,2) DEFAULT NULL,
  `estadoPromocion` tinyint(1) DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  PRIMARY KEY (`idPromocion`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `tbpromocion_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpromocion`
--

LOCK TABLES `tbpromocion` WRITE;
/*!40000 ALTER TABLE `tbpromocion` DISABLE KEYS */;
INSERT INTO `tbpromocion` VALUES (1,'PAPAS','2025-02-21 00:00:00.000000','2025-02-22 00:00:00.000000',135.44,1,6),(2,'RUTRT','2025-02-22 00:00:00.000000','2025-02-28 00:00:00.000000',1.00,0,9),(3,'sh','2025-02-22 00:00:00.000000','2025-02-26 00:00:00.000000',1.00,1,6),(4,'sdfg','2025-02-22 00:00:00.000000','2025-02-25 00:00:00.000000',1.00,1,6);
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
INSERT INTO `tbtipopago` VALUES (1,NULL,1,'SINPE'),(2,NULL,1,'CREDITO'),(3,NULL,1,'EFECTIVO');
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusuario`
--

LOCK TABLES `tbusuario` WRITE;
/*!40000 ALTER TABLE `tbusuario` DISABLE KEYS */;
INSERT INTO `tbusuario` VALUES (6,'703100064','$2a$12$fBMZLlt6aCS9iNemYH7h0e8m/YexlGy.13W2GTCFbnHLLe6fyTqOG','jsandi1299@gmail.com','2004-08-09','Jamel','Sandí','Andersons','88955772',13,1,_binary ''),(11,NULL,'$2a$12$H7xEK8HgTEGRCaE4flNwL.E1VyjkxeENA7DB9bwB85xUn6S4A0w0q','dilan@gmail.com',NULL,'Dilan','Gutiérrez','Hérnanandez',NULL,15,2,_binary ''),(14,NULL,'$2a$12$//YmSKyCUaOul9TXIWPZEO9gr5yyzKc00AG8Wmi8IQUqy9dPPaqwK','jsandi12199@gmail.com',NULL,'JamelZito','prueba','Sandi',NULL,18,3,_binary ''),(23,NULL,'$2a$12$ARcwI6LAA/et4dwOF1QC9.ysaT65uDNz8VBdcblaYooyEQpoj/0YG','cucho@gmail.com',NULL,'cucho','Rojas','Alvarado',NULL,27,3,_binary '\0'),(28,NULL,'contrasenia123','correo@gmail.com',NULL,'Juan','Pérez','Gómez',NULL,32,3,_binary ''),(29,NULL,'$2a$12$cM0U3Bmt9FlpyK0M1cU0SO.9KHOvJRNTB4mQKyv3B6z3lKWhqR2x.','primero@gmail.com',NULL,'Esteban','Primero','Segundo',NULL,33,3,_binary ''),(30,NULL,'12345678','pruebas3214@gmail.com',NULL,'prueba','dos','els',NULL,34,3,_binary ''),(31,NULL,'$2a$12$XAXieNUh4uq0p63tgYas0.cFjDylO//cePrqyb4RPtjKmTaYEUbDi','degutierrezh02@gmail.com',NULL,'fgj','fdjs','sdfj',NULL,35,3,_binary ''),(32,NULL,'$2a$12$j0hHtFKV8VYgUDkReYsPm.7aXC2c8D3zdQV5VuKQgK.b8XOgvk3oa','pppp@gmail.com',NULL,'dsh','sdh','sdh',NULL,36,3,_binary ''),(33,NULL,'$2a$12$jXCxxUDeduNw1K8YydDPBugqO4QQh2iqG8zIECXaIdvl.dzdRZ3ci','dilan.gutierrez.hernandez@est.una.ac.cr',NULL,'zdg','dsg','sdg',NULL,37,3,_binary ''),(34,NULL,'$2a$12$pSGMTA/MuXz9gih591ukJOz.24/3D1IzCGFzH4JpMHRJg6Aq1aEBi','dilan.gutierrez@est.una.ac.cr',NULL,'adsf','adf','adgf',NULL,38,3,_binary ''),(35,NULL,'$2a$12$Z0ZBDIWcgO8qETX6PJorlek2Y9V/gJFwXthpFsp4Ax0QUcuKCZddi','dilan.gutierrez.hernandez2@est.una.ac.cr',NULL,'dssa','dga','ga',NULL,39,3,_binary ''),(52,NULL,'$2a$12$RAhTkU5PcJsq5ZhCmAZzguoPjmlD99XJ3l15BRCSoKZBHEURRYBqC','sdg@gmail.com',NULL,'Dilasfa','sdg','asdg',NULL,56,3,_binary ''),(53,NULL,'$2a$12$wxpinMmDpXb81OSNb8ixYe41ZjL4k8g3KFkR87Za0EFsY7aLOXspW','asfafs@gmailcom',NULL,'saf','asf','asf',NULL,57,3,_binary ''),(54,NULL,'$2a$12$LQFT7OJUAofpgE6ftgZsg.oof8rRo/oGuu6OB8E1Lok8.nkrPdvye','asf@gmail.com',NULL,'sfa','asf','asfa',NULL,58,1,_binary ''),(55,NULL,'$2a$12$KGDvJ718zuuszp3Rdow8/OjBosJDciixCcoNIBKJ2nwrY3Ztv6E9K','dilan.gutierrez.hernandesssz@est.una.ac.cr',NULL,'dgss','dgs','sdgs',NULL,59,3,_binary ''),(56,'111111','$2a$12$1Lty/kvWrEDYeIzyPuA1RuqaafGE0kH2quMVwJ7yP6xx7inoQbdDq','glendrojas1040@gmail.com','2025-04-10','Glend','Rojas','Alvarado','86237034',60,3,_binary ''),(57,NULL,'$2a$12$Iu37sYbB1/FNUDvQsHW0mO8Odu4lOVvTdll4A1X7OkpIZWt9dcjUy','d.cedeno2004@gmail.com',NULL,'Daisy','Cedeño','Sanabria',NULL,61,3,_binary ''),(58,NULL,'$2a$12$kDrOgYYYI.1/CUaUDRiyiODfE1ppJBNKkyOZJ3DMZ0zKo61eW5EYi','deboflor80@gmail.com',NULL,'Debora','Mendez ','Castillo',NULL,62,3,_binary ''),(59,NULL,'$2a$12$cuiOj0AQ40AegBlp/KEja.DzNbma0KUQ4AFRaNWVt6ZGlxjH7abzy','dilangh020711@gmail.com',NULL,'dlk','gutierrez','XZv',NULL,63,3,_binary '');
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

-- Dump completed on 2025-04-20 20:48:02
