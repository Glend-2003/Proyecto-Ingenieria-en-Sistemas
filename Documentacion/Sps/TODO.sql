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
  `accionPedido` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `nombreProducto` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imgProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `montoPrecioProducto` decimal(10,2) DEFAULT NULL,
  `descripcionProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoProducto` tinyint DEFAULT NULL,
  `accionProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `descripcionProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `montoPromocion` decimal(10,2) DEFAULT NULL,
  `estadoPromocion` tinyint DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `accionPromocion` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
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

--
-- Table structure for table `tbcanton`
--

DROP TABLE IF EXISTS `tbcanton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcanton` (
  `idCanton` int NOT NULL AUTO_INCREMENT,
  `nombreCanton` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `montoTotalCarrito` decimal(10,2) DEFAULT NULL,
  `estadoCarrito` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idCarrito`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `tbcarrito_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcarrito`
--

LOCK TABLES `tbcarrito` WRITE;
/*!40000 ALTER TABLE `tbcarrito` DISABLE KEYS */;
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
  CONSTRAINT `tbcarritoproducto_ibfk_1` FOREIGN KEY (`idCarrito`) REFERENCES `tbcarrito` (`idCarrito`),
  CONSTRAINT `tbcarritoproducto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcarritoproducto`
--

LOCK TABLES `tbcarritoproducto` WRITE;
/*!40000 ALTER TABLE `tbcarritoproducto` DISABLE KEYS */;
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
  `descripcionCategoria` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombreCategoria` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoCategoria` tinyint(1) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcategoria`
--

LOCK TABLES `tbcategoria` WRITE;
/*!40000 ALTER TABLE `tbcategoria` DISABLE KEYS */;
INSERT INTO `tbcategoria` VALUES (1,'Descripción actualizada','Nombre actualizado',0),(2,'Todas las partes de la res','Res',1),(3,'Todas las partes de la cerdo','Cerdo',1),(4,'Todas los tipos de mariscos','Marisco',1),(5,'Todos los tipos de embutidos','Embutidos',1),(6,'Todos los tipos de productos lácteos','Lácteos',1),(7,'La mayoría de productos varios','Productos varios',0),(20,'descripcionnnnnnnnnn','prueba',0),(23,'afawfwadawdawd','awdad',0);
/*!40000 ALTER TABLE `tbcategoria` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `tbcomentario` VALUES (4,'Descripción actualizada22','2024-10-30 12:35:30',6,5,_binary '\0'),(5,'Este es un comentario de prueba 2','2024-10-29 22:56:00',6,5,_binary '\0'),(6,'Este es un comentario de prueba 2','2024-10-29 23:07:15',6,5,_binary '\0'),(7,'Este es un comentario de prueba 2','2024-10-29 23:09:18',6,5,_binary '\0'),(8,'Este es un comentario de prueba 2','2024-10-29 23:11:39',6,5,_binary ''),(9,'Este es un comentario de prueba 2','2024-10-29 23:18:17',6,5,_binary '\0'),(10,'Este es un comentario de prueba 2','2024-10-29 23:18:29',6,5,_binary '\0'),(11,'Este es un comentario de prueba','2024-10-30 09:21:53',11,5,_binary '\0'),(12,'Este es un comentario de prueba.','2024-10-30 10:30:13',11,5,_binary '\0'),(13,'Este es un comentario de prueba.','2024-10-30 11:25:28',11,5,_binary '\0'),(14,'Este es un comentario de prueba.','2024-10-30 11:28:19',11,5,_binary '\0'),(15,'Este es un comentario de prueba.','2024-10-30 11:28:37',11,5,_binary ''),(16,'Este es un comentario de prueba.','2024-10-30 11:33:31',11,5,_binary '\0'),(17,'Este es un comentario de prueba.','2024-10-30 12:26:34',11,5,_binary '\0'),(19,'dwdw','2024-11-04 21:12:48',11,2,_binary ''),(20,'malo','2024-12-11 21:34:47',11,3,_binary '\0'),(21,'zzzz','2024-12-11 21:41:52',11,1,_binary '\0');
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
  `codigoPostalDireccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcionDireccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idDistrito` int DEFAULT NULL,
  PRIMARY KEY (`idDireccion`),
  KEY `FKp8gg1h5t049ujh0lbtip4y2ld` (`idDistrito`),
  CONSTRAINT `FKp8gg1h5t049ujh0lbtip4y2ld` FOREIGN KEY (`idDistrito`) REFERENCES `tbdistrito` (`idDistrito`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdireccion`
--

LOCK TABLES `tbdireccion` WRITE;
/*!40000 ALTER TABLE `tbdireccion` DISABLE KEYS */;
INSERT INTO `tbdireccion` VALUES (13,'1234','Urbanización el Tejar',26),(15,NULL,NULL,NULL),(16,'12345654654','Guacimoooo',3),(18,NULL,NULL,NULL),(20,NULL,NULL,NULL),(21,NULL,NULL,NULL),(22,NULL,NULL,NULL),(23,NULL,NULL,NULL),(24,NULL,NULL,NULL),(27,NULL,NULL,NULL),(28,NULL,NULL,NULL);
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
  `descripcionMensaje` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `estadoEntregaPedido` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idCarrito` int DEFAULT NULL,
  `idTipoPago` int DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idCarrito` (`idCarrito`),
  KEY `idTipoPago` (`idTipoPago`),
  CONSTRAINT `tbpedido_ibfk_1` FOREIGN KEY (`idCarrito`) REFERENCES `tbcarrito` (`idCarrito`),
  CONSTRAINT `tbpedido_ibfk_2` FOREIGN KEY (`idTipoPago`) REFERENCES `tbtipopago` (`idTipoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedido`
--

LOCK TABLES `tbpedido` WRITE;
/*!40000 ALTER TABLE `tbpedido` DISABLE KEYS */;
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
  CONSTRAINT `tbpedidoproducto_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tbpedido` (`idPedido`),
  CONSTRAINT `tbpedidoproducto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedidoproducto`
--

LOCK TABLES `tbpedidoproducto` WRITE;
/*!40000 ALTER TABLE `tbpedidoproducto` DISABLE KEYS */;
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
  `nombreProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imgProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `montoPrecioProducto` decimal(38,2) DEFAULT NULL,
  `descripcionProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cantidadProducto` double DEFAULT NULL,
  `tipoPesoProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codigoProducto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stockProducto` int DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  `estadoProducto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `tbproducto_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `tbcategoria` (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbproducto`
--

LOCK TABLES `tbproducto` WRITE;
/*!40000 ALTER TABLE `tbproducto` DISABLE KEYS */;
INSERT INTO `tbproducto` VALUES (6,'Producto1','911fe0f1-9987-4506-8a1a-7393ac03f08d.jpg',2300.00,'Descripcion de prueba',100,'Gr','skd002',10,5,1),(7,'PruebaCambios','d8d76da7-8f90-4c6c-95a0-5dba9e97e89e.jpg',9000.00,'Ayer la probe',1,'Ud','sgy882',7,7,1),(8,'Holaa','d0991041-874a-4171-a5c9-9b7f0db2bb4a.png',2222.00,'Depende',2,'Kg','bnw225',4,4,1),(9,'PruebaFinal','8bdd33a9-ca23-4b99-a197-ca570489ce98.jpg',3020.00,'ayer bla bla bla',1,'Ud','fkl490',20,3,0);
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
  `descripcionPromocion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
INSERT INTO `tbpromocion` VALUES (1,'PAPAS','2025-02-21 00:00:00.000000','2025-02-22 00:00:00.000000',135.44,1,6),(2,'RUTRT','2025-02-22 00:00:00.000000','2025-02-28 00:00:00.000000',1.00,1,9),(3,'sh','2025-02-22 00:00:00.000000','2025-02-26 00:00:00.000000',1.00,1,6),(4,'sdfg','2025-02-22 00:00:00.000000','2025-02-25 00:00:00.000000',1.00,0,6);
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
  `nombreProvincia` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `nombreRol` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcionRol` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `descripcioTipoPago` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoTipoPago` tinyint(1) DEFAULT NULL,
  `descripcionTipoPago` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idTipoPago`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbtipopago`
--

LOCK TABLES `tbtipopago` WRITE;
/*!40000 ALTER TABLE `tbtipopago` DISABLE KEYS */;
INSERT INTO `tbtipopago` VALUES (1,NULL,1,'SINPE'),(2,NULL,0,'CREDITO');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusuario`
--

LOCK TABLES `tbusuario` WRITE;
/*!40000 ALTER TABLE `tbusuario` DISABLE KEYS */;
INSERT INTO `tbusuario` VALUES (6,'703100064','$2a$12$fBMZLlt6aCS9iNemYH7h0e8m/YexlGy.13W2GTCFbnHLLe6fyTqOG','jsandi1299@gmail.com','2004-08-09','Jamel','Sandí','Anderson','88955772',13,3,_binary '\0'),(11,NULL,'$2a$12$H7xEK8HgTEGRCaE4flNwL.E1VyjkxeENA7DB9bwB85xUn6S4A0w0q','dilan@gmail.com',NULL,'Dilan','Gutiérrez','Hérnanandez',NULL,15,2,_binary '\0'),(12,'7031000222','$2a$12$woA1cDNHz2UW.Ek3.qyMwuU6qwdzaWkhslWgKGjOjXK5dH8xf.QGy','glend@gmail.com','2004-08-09','Glend','Rojas','Alvarado','88955771',16,2,_binary ''),(14,NULL,'$2a$12$//YmSKyCUaOul9TXIWPZEO9gr5yyzKc00AG8Wmi8IQUqy9dPPaqwK','jsandi12199@gmail.com',NULL,'JamelZito','prueba','Sandi',NULL,18,3,_binary ''),(23,NULL,'$2a$12$ARcwI6LAA/et4dwOF1QC9.ysaT65uDNz8VBdcblaYooyEQpoj/0YG','cucho@gmail.com',NULL,'cucho','Rojas','Alvarado',NULL,27,3,_binary ''),(24,NULL,'$2a$12$Trh6gkqkvJ/G70gSFVvGB.kIQzglNndLNcHMbghjijtr79RpaMVXG','degutierrezh02@gmail.com',NULL,'Dilan','f','f',NULL,28,3,_binary '\0');
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
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarProducto`(IN `p_idProducto` INT, IN `p_nombreProducto` VARCHAR(255), IN `p_imgProducto` VARCHAR(255), IN `p_montoPrecioProducto` DECIMAL(10,3), IN `p_descripcionProducto` VARCHAR(500), IN `p_idCategoria` INT, IN `p_estadoProducto` BOOLEAN)
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarUsuario`(IN `p_idUsuario` INT, IN `p_cedulaUsuario` VARCHAR(255), IN `p_nombreUsuario` VARCHAR(255), IN `p_primerApellido` VARCHAR(255), IN `p_segundoApellido` VARCHAR(255), IN `p_telefonoUsuario` VARCHAR(255), IN `p_correoUsuario` VARCHAR(255), IN `p_contraseniaUsuario` VARCHAR(255), IN `p_fechaNacimiento` DATE, IN `p_descripcionDireccion` VARCHAR(255), IN `p_codigoPostalDireccion` VARCHAR(255), IN `p_idDistrito` INT, IN `p_estadoUsuario` TINYINT)
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
/*!50003 DROP PROCEDURE IF EXISTS `spAgregarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarProducto`(IN `p_nombreProducto` VARCHAR(255), IN `p_imgProducto` VARCHAR(255), IN `p_montoPrecioProducto` DECIMAL(10,3), IN `p_descripcionProducto` VARCHAR(500), IN `p_idCategoria` INT, IN `p_estadoProducto` BOOLEAN)
BEGIN
    DECLARE done INT DEFAULT 0;

    -- Manejador de errores genéricos
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
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

    IF p_descripcionProducto IS NOT NULL AND CHAR_LENGTH(p_descripcionProducto) > 500 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Descripción demasiado larga';
    END IF;

    IF p_imgProducto IS NOT NULL AND CHAR_LENGTH(p_imgProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de imagen demasiado largo';
    END IF;

    -- Validar existencia de categoría
    IF NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen (extensiones permitidas: .jpg, .png, .jpeg)
    IF p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg" THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Validación de unicidad del nombre dentro de la categoría
    IF EXISTS (SELECT 1 FROM tbproducto WHERE nombreProducto = p_nombreProducto AND idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto ya existe en esta categoría';
    END IF;

    -- Insertar el producto si todas las validaciones son exitosas
    INSERT INTO tbproducto (nombreProducto, imgProducto, montoPrecioProducto, descripcionProducto, idCategoria, estadoProducto)
    VALUES (p_nombreProducto, p_imgProducto, p_montoPrecioProducto, p_descripcionProducto, p_idCategoria, p_estadoProducto);

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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegistrarUsuario`(IN `p_correoUsuario` VARCHAR(255), IN `p_contraseniaUsuario` VARCHAR(255), IN `p_nombreUsuario` VARCHAR(255), IN `p_primerApellido` VARCHAR(255), IN `p_segundoApellido` VARCHAR(255), IN `p_estadoUsuario` TINYINT)
BEGIN
    -- Declarar la variable para almacenar el ID de la dirección insertada
    DECLARE idDireccion INT;

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

    -- Insertar la dirección
    INSERT INTO tbdireccion () VALUES ();

    -- Obtener el ID de la dirección insertada
    SET idDireccion = LAST_INSERT_ID();

    -- Insertar el usuario
    INSERT INTO tbusuario (correoUsuario, contraseniaUsuario, nombreUsuario, primerApellido, segundoApellido, idDireccion, idRol, estadoUsuario)
    VALUES (p_correoUsuario, p_contraseniaUsuario, p_nombreUsuario, p_primerApellido, p_segundoApellido, idDireccion, 3, p_estadoUsuario);

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-25 16:26:15
