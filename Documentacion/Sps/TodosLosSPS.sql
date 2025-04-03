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
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarPedido`(
    IN p_idPedido INT,
    IN p_montoTotalPedido DECIMAL(38,2),
    IN p_fechaPedido DATETIME(6),
    IN p_estadoPedido BIT(1),
    IN p_estadoEntregaPedido VARCHAR(255),
    IN p_idCarrito INT,
    IN p_idTipoPago INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al actualizar el pedido' AS Mensaje;
    END;
    
    START TRANSACTION;
    
    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM tbpedido WHERE idPedido = p_idPedido) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El pedido especificado no existe';
    END IF;
    
    -- Validar relaciones
    IF NOT EXISTS (SELECT 1 FROM tbcarrito WHERE idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carrito especificado no existe';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM tbtipopago WHERE idTipoPago = p_idTipoPago) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de pago especificado no existe';
    END IF;
    
    -- Actualizar el pedido
    UPDATE tbpedido
    SET 
        montoTotalPedido = p_montoTotalPedido,
        fechaPedido = p_fechaPedido,
        estadoPedido = p_estadoPedido,
        estadoEntregaPedido = p_estadoEntregaPedido,
        idCarrito = p_idCarrito,
        idTipoPago = p_idTipoPago
    WHERE 
        idPedido = p_idPedido;
    
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
/*!50003 DROP PROCEDURE IF EXISTS `spEliminarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarPedido`(
    IN p_idPedido INT
)
BEGIN
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
    
    -- Eliminar el pedido
    DELETE FROM tbpedido WHERE idPedido = p_idPedido;
    
    SELECT ROW_COUNT() AS filasAfectadas, 'Pedido eliminado exitosamente' AS Mensaje;
    
    COMMIT;
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

-- Dump completed on 2025-04-02 23:22:42
