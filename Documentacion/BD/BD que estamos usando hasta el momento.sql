-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-11-2024 a las 04:54:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdcarniceria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarCategoria` (IN `p_idCategoria` INT, IN `p_nombre` VARCHAR(255), IN `p_descripcion` VARCHAR(255), IN `p_estado` INT)   BEGIN
    
    UPDATE tbcategoria
    SET nombreCategoria = p_nombre,
        descripcionCategoria = p_descripcion,
        estadoCategoria = p_estado 
    WHERE idCategoria = p_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarComentario` (IN `p_idComentario` INT, IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `P_idUsuario` INT, IN `p_numCalificacion` INT)   BEGIN
    
    UPDATE tbcomentario
    SET descripcionComentario = p_descripcionComentario,
        fechaComentario = p_fechaComentario,
        idUsuario = P_idUsuario,
        numCalificacion = p_numCalificacion
    WHERE idComentario = p_idComentario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarContrasena` (IN `p_idUsuario` INT, IN `p_nuevaContraseniaUsuario` VARCHAR(255))   BEGIN

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarProducto` (IN `p_idProducto` INT, IN `p_nombreProducto` VARCHAR(255), IN `p_imgProducto` VARCHAR(255), IN `p_montoPrecioProducto` DECIMAL(10,3), IN `p_descripcionProducto` VARCHAR(500), IN `p_idCategoria` INT, IN `p_estadoProducto` BOOLEAN)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarRol` (IN `p_idRol` INT(10), IN `p_nombre` VARCHAR(255), IN `p_descripcion` VARCHAR(255), IN `p_estado` TINYINT)   BEGIN
    -- Actualiza los campos del rol, incluyendo el estado
    UPDATE tbRol
    SET nombreRol = p_nombre,
        descripcionRol = p_descripcion,
        estadoRol = p_estado -- Actualizar el estado
    WHERE idRol = p_idRol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarUsuario` (IN `p_idUsuario` INT, IN `p_cedulaUsuario` VARCHAR(255), IN `p_nombreUsuario` VARCHAR(255), IN `p_primerApellido` VARCHAR(255), IN `p_segundoApellido` VARCHAR(255), IN `p_telefonoUsuario` VARCHAR(255), IN `p_correoUsuario` VARCHAR(255), IN `p_contraseniaUsuario` VARCHAR(255), IN `p_fechaNacimiento` DATE, IN `p_descripcionDireccion` VARCHAR(255), IN `p_codigoPostalDireccion` VARCHAR(255), IN `p_idDistrito` INT, IN `p_estadoUsuario` TINYINT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarCategoria` (IN `nombreCategoria` VARCHAR(255), IN `descripcionCategoria` VARCHAR(255), IN `estadoCategoria` INT)   BEGIN
    
    INSERT INTO tbcategoria (nombreCategoria, descripcionCategoria, estadoCategoria)
    VALUES (nombreCategoria, descripcionCategoria, estadoCategoria);

    
    SELECT LAST_INSERT_ID() AS idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarComentario` (IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `p_idUsuario` INT, IN `p_numCalificacionComentario` INT)   BEGIN
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
        INSERT INTO tbcomentario (descripcionComentario, fechaComentario, idUsuario, numCalificacion)
        VALUES (p_descripcionComentario, p_fechaComentario, p_idUsuario, p_numCalificacionComentario);

        -- Hacer commit si todo est  bien
        COMMIT;
   

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarProducto` (IN `p_nombreProducto` VARCHAR(255), IN `p_imgProducto` VARCHAR(255), IN `p_montoPrecioProducto` DECIMAL(10,3), IN `p_descripcionProducto` VARCHAR(500), IN `p_idCategoria` INT, IN `p_estadoProducto` BOOLEAN)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarRol` (IN `nombreRol` VARCHAR(255), IN `descripcionRol` VARCHAR(255), IN `estadoRol` TINYINT)   BEGIN
    -- Inserta el nuevo rol en la tabla incluyendo el estado
    INSERT INTO tbrol (nombreRol, descripcionRol, estadoRol)
    VALUES (nombreRol, descripcionRol, estadoRol);

    SELECT * FROM tbrol WHERE idRol = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarUsuario` (IN `p_cedulaUsuario` VARCHAR(255), IN `p_nombreUsuario` VARCHAR(255), IN `p_primerApellido` VARCHAR(255), IN `p_segundoApellido` VARCHAR(255), IN `p_telefonoUsuario` VARCHAR(255), IN `p_correoUsuario` VARCHAR(255), IN `p_contraseniaUsuario` VARCHAR(255), IN `p_fechaNacimiento` DATE, IN `p_descripcionDireccion` VARCHAR(255), IN `p_codigoPostalDireccion` VARCHAR(255), IN `p_idDistrito` INT, IN `p_idRol` INT, IN `p_estadoUsuario` TINYINT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarUsuarioPorCorreo` (IN `correoInput` VARCHAR(255))   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarCategoria` (IN `p_idCategoria` INT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarComentario` (IN `p_idComentario` INT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarProducto` (IN `p_idProducto` INT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarRol` (IN `p_idRol` INT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario` (IN `p_idUsuario` INT)   BEGIN
    
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoria` ()   BEGIN
    -- Leer solo las categorías donde el estado sea 1 (activo)
    SELECT * FROM tbcategoria
    WHERE estadoCategoria = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoriaPorId` (IN `p_idCategoria` INT)   BEGIN
    SELECT 
        idCategoria,
        descripcionCategoria,
        nombreCategoria,
        estadoCategoria
    FROM 
        tbcategoria
    WHERE 
        idCategoria = p_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentarios` ()   BEGIN
    SELECT * FROM tbcomentario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosAdmin` ()   BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosUsuario` ()   BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerDistrito` ()   BEGIN
    SELECT d.idDistrito, d.nombreDistrito, c.idCanton
    FROM tbdistrito d
    JOIN tbcanton c ON d.idCanton = c.idCanton;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerProducto` ()   BEGIN
    SELECT 
        p.idProducto,
        p.nombreProducto,
        p.imgProducto,  -- Ruta relativa de la imagen
        p.montoPrecioProducto,
        p.descripcionProducto,
        p.idCategoria,
        c.nombreCategoria,  -- Nombre de la categoría
        p.estadoProducto
    FROM 
        tbproducto p
    JOIN 
        tbcategoria c ON p.idCategoria = c.idCategoria;  -- Unión con la tabla de categorías
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerRol` ()   BEGIN
    -- Leer solo los roles donde el estado sea 1 (activo)
    SELECT * FROM tbrol
    WHERE estadoRol = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerUsuario` ()   BEGIN
    -- Leer solo los usuarios donde el estado sea 1 (activo)
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
    WHERE u.estadoUsuario = 1; -- Solo los usuarios activos
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarComentario` (IN `p_idComentario` INT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerUsuarioById` (IN `p_idUsuario` INT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegistrarUsuario` (IN `p_correoUsuario` VARCHAR(255), IN `p_contraseniaUsuario` VARCHAR(255), IN `p_nombreUsuario` VARCHAR(255), IN `p_primerApellido` VARCHAR(255), IN `p_segundoApellido` VARCHAR(255), IN `p_estadoUsuario` TINYINT)   BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarCorreo` (IN `p_correoUsuario` VARCHAR(255))   BEGIN
    SELECT COUNT(*) AS existe FROM tbusuario WHERE correoUsuario = p_correoUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarIDUsuario` (IN `p_idUsuario` INT)   BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbauditoriapedido`
--

CREATE TABLE `tbauditoriapedido` (
  `idPedido` int(11) NOT NULL,
  `montoTotalPedido` decimal(10,2) DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `estadoPedido` tinyint(4) DEFAULT NULL,
  `idCarrito` int(11) DEFAULT NULL,
  `idTipoPago` int(11) DEFAULT NULL,
  `accionPedido` varchar(50) DEFAULT NULL,
  `fechaModificacionPedido` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbauditoriaproducto`
--

CREATE TABLE `tbauditoriaproducto` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(100) DEFAULT NULL,
  `imgProducto` varchar(255) DEFAULT NULL,
  `montoPrecioProducto` decimal(10,2) DEFAULT NULL,
  `descripcionProducto` varchar(255) DEFAULT NULL,
  `estadoProducto` tinyint(4) DEFAULT NULL,
  `accionProducto` varchar(255) DEFAULT NULL,
  `fechaModificacionProducto` date DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbauditoriapromocion`
--

CREATE TABLE `tbauditoriapromocion` (
  `idPromocion` int(11) NOT NULL,
  `descripcionProducto` varchar(255) DEFAULT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `montoPromocion` decimal(10,2) DEFAULT NULL,
  `estadoPromocion` tinyint(4) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `accionPromocion` varchar(50) DEFAULT NULL,
  `fechaModificacionPromocion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbauditoriausuario`
--

CREATE TABLE `tbauditoriausuario` (
  `idUsuario` int(11) NOT NULL,
  `cedulaUsuario` varchar(255) DEFAULT NULL,
  `contraseniaUsuario` varchar(255) DEFAULT NULL,
  `correoUsuario` varchar(255) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `nombreUsuario` varchar(255) DEFAULT NULL,
  `primerApellido` varchar(255) DEFAULT NULL,
  `segundoApellido` varchar(255) DEFAULT NULL,
  `telefonoUsuario` varchar(255) DEFAULT NULL,
  `idDireccion` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `estadoUsuario` tinyint(4) DEFAULT NULL,
  `accionUsuario` varchar(255) DEFAULT NULL,
  `fechaModificacionUsuario` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbcanton`
--

CREATE TABLE `tbcanton` (
  `idCanton` int(11) NOT NULL,
  `nombreCanton` varchar(255) DEFAULT NULL,
  `idProvincia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbcanton`
--

INSERT INTO `tbcanton` (`idCanton`, `nombreCanton`, `idProvincia`) VALUES
(1, 'Pococí', 7),
(2, 'Guácimo', 7),
(3, 'Siquirres', 7),
(4, 'Matina', 7),
(5, 'Limón', 7),
(6, 'Talamanca', 7),
(7, 'San José', 1),
(8, 'Escazú', 1),
(9, 'Desamparados', 1),
(10, 'Puriscal', 1),
(11, 'Tarrazú', 1),
(12, 'Aserrí', 1),
(13, 'Mora', 1),
(14, 'Goicoechea', 1),
(15, 'Santa Ana', 1),
(16, 'Alajuelita', 1),
(17, 'Vázquez de Coronado', 1),
(18, 'Acosta', 1),
(19, 'Tibás', 1),
(20, 'Moravia', 1),
(21, 'Montes de Oca', 1),
(22, 'Turrubares', 1),
(23, 'Dota', 1),
(24, 'Curridabat', 1),
(25, 'Pérez Zeledón', 1),
(26, 'León Cortés Castro', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbcarrito`
--

CREATE TABLE `tbcarrito` (
  `idCarrito` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `montoTotalCarrito` decimal(10,2) DEFAULT NULL,
  `estadoCarrito` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbcarritoproducto`
--

CREATE TABLE `tbcarritoproducto` (
  `idCarritoProducto` int(11) NOT NULL,
  `idCarrito` int(11) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `cantidadProducto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbcategoria`
--

CREATE TABLE `tbcategoria` (
  `idCategoria` int(11) NOT NULL,
  `descripcionCategoria` varchar(255) DEFAULT NULL,
  `nombreCategoria` varchar(255) DEFAULT NULL,
  `estadoCategoria` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbcategoria`
--

INSERT INTO `tbcategoria` (`idCategoria`, `descripcionCategoria`, `nombreCategoria`, `estadoCategoria`) VALUES
(1, 'Descripción actualizada', 'Nombre actualizado', 1),
(2, 'Todas las partes de la res', 'Res', 1),
(3, 'Todas las partes de la cerdo', 'Cerdo', 1),
(4, 'Todas los tipos de mariscos', 'Marisco', 1),
(5, 'Todos los tipos de embutidos', 'Embutidos', 1),
(6, 'Todos los tipos de productos lácteos', 'Lácteos', 1),
(7, 'La mayoría de productos varios', 'Productos varios', 1),
(20, 'descripcionnnnnnnnnn', 'prueba', 1),
(23, 'afawfwadawdawd', 'awdad', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbcomentario`
--

CREATE TABLE `tbcomentario` (
  `idComentario` int(11) NOT NULL,
  `descripcionComentario` varchar(255) DEFAULT NULL,
  `fechaComentario` datetime DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `numCalificacion` int(11) DEFAULT NULL,
  `verificacion` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbcomentario`
--

INSERT INTO `tbcomentario` (`idComentario`, `descripcionComentario`, `fechaComentario`, `idUsuario`, `numCalificacion`, `verificacion`) VALUES
(4, 'Descripción actualizada22', '2024-10-30 12:35:30', 6, 5, b'1'),
(5, 'Este es un comentario de prueba 2', '2024-10-29 22:56:00', 6, 5, b'1'),
(6, 'Este es un comentario de prueba 2', '2024-10-29 23:07:15', 6, 5, b'1'),
(7, 'Este es un comentario de prueba 2', '2024-10-29 23:09:18', 6, 5, b'0'),
(8, 'Este es un comentario de prueba 2', '2024-10-29 23:11:39', 6, 5, b'1'),
(9, 'Este es un comentario de prueba 2', '2024-10-29 23:18:17', 6, 5, b'0'),
(10, 'Este es un comentario de prueba 2', '2024-10-29 23:18:29', 6, 5, b'0'),
(11, 'Este es un comentario de prueba', '2024-10-30 09:21:53', 11, 5, b'0'),
(12, 'Este es un comentario de prueba.', '2024-10-30 10:30:13', 11, 5, b'0'),
(13, 'Este es un comentario de prueba.', '2024-10-30 11:25:28', 11, 5, b'0'),
(14, 'Este es un comentario de prueba.', '2024-10-30 11:28:19', 11, 5, b'0'),
(15, 'Este es un comentario de prueba.', '2024-10-30 11:28:37', 11, 5, b'1'),
(16, 'Este es un comentario de prueba.', '2024-10-30 11:33:31', 11, 5, b'0'),
(17, 'Este es un comentario de prueba.', '2024-10-30 12:26:34', 11, 5, b'0'),
(19, 'dwdw', '2024-11-04 21:12:48', 11, 2, b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbdireccion`
--

CREATE TABLE `tbdireccion` (
  `idDireccion` int(11) NOT NULL,
  `codigoPostalDireccion` varchar(255) DEFAULT NULL,
  `descripcionDireccion` varchar(255) DEFAULT NULL,
  `idDistrito` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbdireccion`
--

INSERT INTO `tbdireccion` (`idDireccion`, `codigoPostalDireccion`, `descripcionDireccion`, `idDistrito`) VALUES
(13, '1234', 'Urbanización el Tejar', 26),
(15, NULL, NULL, NULL),
(16, '12345654654', 'Guacimoooo', 3),
(18, NULL, NULL, NULL),
(20, NULL, NULL, NULL),
(21, NULL, NULL, NULL),
(22, NULL, NULL, NULL),
(23, NULL, NULL, NULL),
(24, NULL, NULL, NULL),
(27, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbdistrito`
--

CREATE TABLE `tbdistrito` (
  `idDistrito` int(11) NOT NULL,
  `nombreDistrito` varchar(255) DEFAULT NULL,
  `idCanton` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbdistrito`
--

INSERT INTO `tbdistrito` (`idDistrito`, `nombreDistrito`, `idCanton`) VALUES
(1, 'Limón', 5),
(2, 'Valle La Estrella', 5),
(3, 'Río Blanco', 5),
(4, 'Matama', 5),
(5, 'Guápiles', 1),
(6, 'Jiménez', 1),
(7, 'La Rita', 1),
(8, 'Roxana', 1),
(9, 'Cariari', 1),
(10, 'Colorado', 1),
(11, 'La Colonia', 1),
(12, 'Siquirres', 3),
(13, 'Pacuarito', 3),
(14, 'Florida', 3),
(15, 'Germania', 3),
(16, 'El Cairo', 3),
(17, 'Alegría', 3),
(18, 'Reventazón', 3),
(19, 'Bratsi', 6),
(20, 'Sixaola', 6),
(21, 'Cahuita', 6),
(22, 'Telire', 6),
(23, 'Matina', 4),
(24, 'Batán', 4),
(25, 'Carrandi', 4),
(26, 'Guácimo', 2),
(27, 'Mercedes', 2),
(28, 'Pocora', 2),
(29, 'Río Jiménez', 2),
(30, 'Duacarí', 2),
(31, 'Carmen', 7),
(32, 'Merced', 7),
(33, 'Hospital', 7),
(34, 'Catedral', 7),
(35, 'San Francisco de Dos Ríos', 7),
(36, 'La Uruca', 7),
(37, 'Mata Redonda', 7),
(38, 'Pavas', 7),
(39, 'Hatillo', 7),
(40, 'San Sebastián', 7),
(41, 'Escazú', 8),
(42, 'San Antonio', 8),
(43, 'San Rafael', 8),
(44, 'Desamparados', 9),
(45, 'San Miguel', 9),
(46, 'San Juan de Dios', 9),
(47, 'San Rafael Arriba', 9),
(48, 'San Antonio', 9),
(49, 'Frailes', 9),
(50, 'Patarrá', 9),
(51, 'San Cristóbal', 9),
(52, 'Rosario', 9),
(53, 'Damas', 9),
(54, 'San Rafael Abajo', 9),
(55, 'Gravilias', 9),
(56, 'Los Guido', 9),
(57, 'Santiago', 10),
(58, 'Mercedes Sur', 10),
(59, 'Barbacoas', 10),
(60, 'Grifo Alto', 10),
(61, 'San Rafael', 10),
(62, 'Candelarita', 10),
(63, 'Desamparaditos', 10),
(64, 'San Antonio', 10),
(65, 'Chires', 10),
(66, 'San Marcos', 11),
(67, 'San Lorenzo', 11),
(68, 'San Carlos', 11),
(69, 'Aserrí', 12),
(70, 'Tarbaca', 12),
(71, 'Vuelta de Jorco', 12),
(72, 'San Gabriel', 12),
(73, 'Legua', 12),
(74, 'Monterrey', 12),
(75, 'Salitrillos', 12),
(76, 'Colón', 13),
(77, 'Guayabo', 13),
(78, 'Tabarcia', 13),
(79, 'Piedras Negras', 13),
(80, 'Picagres', 13),
(81, 'Jaris', 13),
(82, 'Quitirrisí', 13),
(83, 'Guadalupe', 14),
(84, 'San Francisco', 14),
(85, 'Calle Blancos', 14),
(86, 'Mata de Plátano', 14),
(87, 'Ipís', 14),
(88, 'Rancho Redondo', 14),
(89, 'Purral', 14),
(90, 'Santa Ana', 15),
(91, 'Salitral', 15),
(92, 'Pozos', 15),
(93, 'Uruca', 15),
(94, 'Piedades', 15),
(95, 'Brasil', 15),
(96, 'Alajuelita', 16),
(97, 'San Josecito', 16),
(98, 'San Antonio', 16),
(99, 'Concepción', 16),
(100, 'San Felipe', 16),
(101, 'San Isidro', 17),
(102, 'San Rafael', 17),
(103, 'Dulce Nombre de Jesús', 17),
(104, 'Patalillo', 17),
(105, 'Cascajal', 17),
(106, 'San Ignacio', 18),
(107, 'Guaitil', 18),
(108, 'Palmichal', 18),
(109, 'Cangrejal', 18),
(110, 'Sabanillas', 18),
(111, 'San Juan', 19),
(112, 'Cinco Esquinas', 19),
(113, 'Anselmo Llorente', 19),
(114, 'León XIII', 19),
(115, 'Colima', 19),
(116, 'San Vicente', 20),
(117, 'San Jerónimo', 20),
(118, 'La Trinidad', 20),
(119, 'San Pedro', 21),
(120, 'Sabanilla', 21),
(121, 'Mercedes', 21),
(122, 'San Rafael', 21),
(123, 'San Pablo', 22),
(124, 'San Pedro', 22),
(125, 'San Juan de Mata', 22),
(126, 'San Luis', 22),
(127, 'Carara', 22),
(128, 'Santa María', 23),
(129, 'Jardín', 23),
(130, 'Copey', 23),
(131, 'Curridabat', 24),
(132, 'Granadilla', 24),
(133, 'Sánchez', 24),
(134, 'Tirrases', 24),
(135, 'San Isidro de El General', 25),
(136, 'El General', 25),
(137, 'Daniel Flores', 25),
(138, 'Rivas', 25),
(139, 'San Pedro', 25),
(140, 'Platanares', 25),
(141, 'Pejibaye', 25),
(142, 'Cajón', 25),
(143, 'Barú', 25),
(144, 'Río Nuevo', 25),
(145, 'Páramo', 25),
(146, 'La Amistad', 25),
(147, 'San Pablo', 26),
(148, 'San Andrés', 26),
(149, 'Llano Bonito', 26),
(150, 'San Isidro', 26),
(151, 'Santa Cruz', 26),
(152, 'San Antonio', 26);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbfactura`
--

CREATE TABLE `tbfactura` (
  `idFactura` int(11) NOT NULL,
  `fechaFactura` date DEFAULT NULL,
  `idPedido` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbmensaje`
--

CREATE TABLE `tbmensaje` (
  `idMensaje` int(11) NOT NULL,
  `descripcionMensaje` varchar(255) DEFAULT NULL,
  `fechaEnvioMensaje` date DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idPromocion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbpedido`
--

CREATE TABLE `tbpedido` (
  `idPedido` int(11) NOT NULL,
  `montoTotalPedido` decimal(10,2) DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `estadoPedido` tinyint(4) DEFAULT NULL,
  `estadoEntregaPedido` varchar(50) DEFAULT NULL,
  `idCarrito` int(11) DEFAULT NULL,
  `idTipoPago` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbpedidoproducto`
--

CREATE TABLE `tbpedidoproducto` (
  `idPedidoProducto` int(11) NOT NULL,
  `idPedido` int(11) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbproducto`
--

CREATE TABLE `tbproducto` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(255) DEFAULT NULL,
  `imgProducto` varchar(255) DEFAULT NULL,
  `montoPrecioProducto` decimal(38,2) DEFAULT NULL,
  `descripcionProducto` varchar(255) DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  `estadoProducto` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbproducto`
--

INSERT INTO `tbproducto` (`idProducto`, `nombreProducto`, `imgProducto`, `montoPrecioProducto`, `descripcionProducto`, `idCategoria`, `estadoProducto`) VALUES
(6, 'Producto1', '911fe0f1-9987-4506-8a1a-7393ac03f08d.jpg', 2300.00, 'Descripcion de prueba', 5, 1),
(7, 'PruebaCambios', 'd8d76da7-8f90-4c6c-95a0-5dba9e97e89e.jpg', 9000.00, 'Ayer la probe', 7, 0),
(8, 'Holaa', 'd0991041-874a-4171-a5c9-9b7f0db2bb4a.png', 2222.00, 'Depende', 4, 1),
(9, 'PruebaFinal', '8bdd33a9-ca23-4b99-a197-ca570489ce98.jpg', 3020.00, 'ayer bla bla bla', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbpromocion`
--

CREATE TABLE `tbpromocion` (
  `idPromocion` int(11) NOT NULL,
  `descripcionPromocion` varchar(255) DEFAULT NULL,
  `fechaInicioPromocion` date DEFAULT NULL,
  `fechaFinPromocion` date DEFAULT NULL,
  `montoPromocion` decimal(10,2) DEFAULT NULL,
  `estadoPromocion` tinyint(1) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbprovincia`
--

CREATE TABLE `tbprovincia` (
  `idProvincia` int(11) NOT NULL,
  `nombreProvincia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbprovincia`
--

INSERT INTO `tbprovincia` (`idProvincia`, `nombreProvincia`) VALUES
(1, 'San José'),
(2, 'Alajuela'),
(3, 'Cartago'),
(4, 'Heredia'),
(5, 'Guanacaste'),
(6, 'Puntarenas'),
(7, 'Limón');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbrol`
--

CREATE TABLE `tbrol` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(255) DEFAULT NULL,
  `descripcionRol` varchar(255) DEFAULT NULL,
  `estadoRol` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbrol`
--

INSERT INTO `tbrol` (`idRol`, `nombreRol`, `descripcionRol`, `estadoRol`) VALUES
(1, 'Administrador', 'El que se encarga de realizar lo más importante', b'1'),
(2, 'Gerente', 'El que se encarga de algunas cosas', b'1'),
(3, 'Usuario', 'El que se encarga de ver productos y realizar pedidos', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbtipopago`
--

CREATE TABLE `tbtipopago` (
  `idTipoPago` int(11) NOT NULL,
  `descripcioTipoPago` varchar(225) DEFAULT NULL,
  `estadoTipoPago` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbusuario`
--

CREATE TABLE `tbusuario` (
  `idUsuario` int(11) NOT NULL,
  `cedulaUsuario` varchar(255) DEFAULT NULL,
  `contraseniaUsuario` varchar(255) NOT NULL,
  `correoUsuario` varchar(255) NOT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `nombreUsuario` varchar(255) DEFAULT NULL,
  `primerApellido` varchar(255) DEFAULT NULL,
  `segundoApellido` varchar(255) DEFAULT NULL,
  `telefonoUsuario` varchar(255) DEFAULT NULL,
  `idDireccion` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `estadoUsuario` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbusuario`
--

INSERT INTO `tbusuario` (`idUsuario`, `cedulaUsuario`, `contraseniaUsuario`, `correoUsuario`, `fechaNacimiento`, `nombreUsuario`, `primerApellido`, `segundoApellido`, `telefonoUsuario`, `idDireccion`, `idRol`, `estadoUsuario`) VALUES
(6, '703100064', '$2a$12$fBMZLlt6aCS9iNemYH7h0e8m/YexlGy.13W2GTCFbnHLLe6fyTqOG', 'jsandi1299@gmail.com', '2004-08-09', 'Jamel', 'Sandí', 'Anderson', '88955772', 13, 3, b'1'),
(11, NULL, '$2a$12$H7xEK8HgTEGRCaE4flNwL.E1VyjkxeENA7DB9bwB85xUn6S4A0w0q', 'dilan@gmail.com', NULL, 'Dilan', 'Gutiérrez', 'Hérnanandez', NULL, 15, 2, b'1'),
(12, '7031000222', '$2a$12$woA1cDNHz2UW.Ek3.qyMwuU6qwdzaWkhslWgKGjOjXK5dH8xf.QGy', 'glend@gmail.com', '2004-08-09', 'Glend', 'Rojas', 'Alvarado', '88955771', 16, 2, b'1'),
(14, NULL, '$2a$12$//YmSKyCUaOul9TXIWPZEO9gr5yyzKc00AG8Wmi8IQUqy9dPPaqwK', 'jsandi12199@gmail.com', NULL, 'JamelZito', 'prueba', 'Sandi', NULL, 18, 3, b'1'),
(23, NULL, '$2a$12$ARcwI6LAA/et4dwOF1QC9.ysaT65uDNz8VBdcblaYooyEQpoj/0YG', 'cucho@gmail.com', NULL, 'cucho', 'Rojas', 'Alvarado', NULL, 27, 3, b'1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbauditoriapedido`
--
ALTER TABLE `tbauditoriapedido`
  ADD PRIMARY KEY (`idPedido`);

--
-- Indices de la tabla `tbauditoriaproducto`
--
ALTER TABLE `tbauditoriaproducto`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `tbauditoriapromocion`
--
ALTER TABLE `tbauditoriapromocion`
  ADD PRIMARY KEY (`idPromocion`);

--
-- Indices de la tabla `tbauditoriausuario`
--
ALTER TABLE `tbauditoriausuario`
  ADD PRIMARY KEY (`idUsuario`);

--
-- Indices de la tabla `tbcanton`
--
ALTER TABLE `tbcanton`
  ADD PRIMARY KEY (`idCanton`),
  ADD KEY `FK7k27spfr0xmfgd7t6f9yw0chf` (`idProvincia`);

--
-- Indices de la tabla `tbcarrito`
--
ALTER TABLE `tbcarrito`
  ADD PRIMARY KEY (`idCarrito`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `tbcarritoproducto`
--
ALTER TABLE `tbcarritoproducto`
  ADD PRIMARY KEY (`idCarritoProducto`),
  ADD KEY `idCarrito` (`idCarrito`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `tbcategoria`
--
ALTER TABLE `tbcategoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `tbcomentario`
--
ALTER TABLE `tbcomentario`
  ADD PRIMARY KEY (`idComentario`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `tbdireccion`
--
ALTER TABLE `tbdireccion`
  ADD PRIMARY KEY (`idDireccion`),
  ADD KEY `FKp8gg1h5t049ujh0lbtip4y2ld` (`idDistrito`);

--
-- Indices de la tabla `tbdistrito`
--
ALTER TABLE `tbdistrito`
  ADD PRIMARY KEY (`idDistrito`),
  ADD KEY `FKcmru33riglx1giuu7m2wo2moq` (`idCanton`);

--
-- Indices de la tabla `tbfactura`
--
ALTER TABLE `tbfactura`
  ADD PRIMARY KEY (`idFactura`),
  ADD KEY `idPedido` (`idPedido`);

--
-- Indices de la tabla `tbmensaje`
--
ALTER TABLE `tbmensaje`
  ADD PRIMARY KEY (`idMensaje`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idPromocion` (`idPromocion`);

--
-- Indices de la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `idCarrito` (`idCarrito`),
  ADD KEY `idTipoPago` (`idTipoPago`);

--
-- Indices de la tabla `tbpedidoproducto`
--
ALTER TABLE `tbpedidoproducto`
  ADD PRIMARY KEY (`idPedidoProducto`),
  ADD KEY `idPedido` (`idPedido`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `tbproducto`
--
ALTER TABLE `tbproducto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indices de la tabla `tbpromocion`
--
ALTER TABLE `tbpromocion`
  ADD PRIMARY KEY (`idPromocion`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `tbprovincia`
--
ALTER TABLE `tbprovincia`
  ADD PRIMARY KEY (`idProvincia`);

--
-- Indices de la tabla `tbrol`
--
ALTER TABLE `tbrol`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `tbtipopago`
--
ALTER TABLE `tbtipopago`
  ADD PRIMARY KEY (`idTipoPago`);

--
-- Indices de la tabla `tbusuario`
--
ALTER TABLE `tbusuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `FK2tbdw6lsgbsdrhyex64u5kbij` (`idDireccion`),
  ADD KEY `FK6dgi775fekruot59lqiv650ns` (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbauditoriapedido`
--
ALTER TABLE `tbauditoriapedido`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbauditoriaproducto`
--
ALTER TABLE `tbauditoriaproducto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbauditoriapromocion`
--
ALTER TABLE `tbauditoriapromocion`
  MODIFY `idPromocion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbauditoriausuario`
--
ALTER TABLE `tbauditoriausuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbcanton`
--
ALTER TABLE `tbcanton`
  MODIFY `idCanton` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `tbcarrito`
--
ALTER TABLE `tbcarrito`
  MODIFY `idCarrito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbcarritoproducto`
--
ALTER TABLE `tbcarritoproducto`
  MODIFY `idCarritoProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbcategoria`
--
ALTER TABLE `tbcategoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `tbcomentario`
--
ALTER TABLE `tbcomentario`
  MODIFY `idComentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `tbdireccion`
--
ALTER TABLE `tbdireccion`
  MODIFY `idDireccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `tbdistrito`
--
ALTER TABLE `tbdistrito`
  MODIFY `idDistrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT de la tabla `tbfactura`
--
ALTER TABLE `tbfactura`
  MODIFY `idFactura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbmensaje`
--
ALTER TABLE `tbmensaje`
  MODIFY `idMensaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbpedidoproducto`
--
ALTER TABLE `tbpedidoproducto`
  MODIFY `idPedidoProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbproducto`
--
ALTER TABLE `tbproducto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tbpromocion`
--
ALTER TABLE `tbpromocion`
  MODIFY `idPromocion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbprovincia`
--
ALTER TABLE `tbprovincia`
  MODIFY `idProvincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbrol`
--
ALTER TABLE `tbrol`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbtipopago`
--
ALTER TABLE `tbtipopago`
  MODIFY `idTipoPago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbusuario`
--
ALTER TABLE `tbusuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbcanton`
--
ALTER TABLE `tbcanton`
  ADD CONSTRAINT `FK7k27spfr0xmfgd7t6f9yw0chf` FOREIGN KEY (`idProvincia`) REFERENCES `tbprovincia` (`idProvincia`);

--
-- Filtros para la tabla `tbcarrito`
--
ALTER TABLE `tbcarrito`
  ADD CONSTRAINT `tbcarrito_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`);

--
-- Filtros para la tabla `tbcarritoproducto`
--
ALTER TABLE `tbcarritoproducto`
  ADD CONSTRAINT `tbcarritoproducto_ibfk_1` FOREIGN KEY (`idCarrito`) REFERENCES `tbcarrito` (`idCarrito`),
  ADD CONSTRAINT `tbcarritoproducto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`);

--
-- Filtros para la tabla `tbcomentario`
--
ALTER TABLE `tbcomentario`
  ADD CONSTRAINT `tbcomentario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`);

--
-- Filtros para la tabla `tbdireccion`
--
ALTER TABLE `tbdireccion`
  ADD CONSTRAINT `FKp8gg1h5t049ujh0lbtip4y2ld` FOREIGN KEY (`idDistrito`) REFERENCES `tbdistrito` (`idDistrito`);

--
-- Filtros para la tabla `tbdistrito`
--
ALTER TABLE `tbdistrito`
  ADD CONSTRAINT `FKcmru33riglx1giuu7m2wo2moq` FOREIGN KEY (`idCanton`) REFERENCES `tbcanton` (`idCanton`);

--
-- Filtros para la tabla `tbfactura`
--
ALTER TABLE `tbfactura`
  ADD CONSTRAINT `tbfactura_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tbpedido` (`idPedido`);

--
-- Filtros para la tabla `tbmensaje`
--
ALTER TABLE `tbmensaje`
  ADD CONSTRAINT `tbmensaje_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`),
  ADD CONSTRAINT `tbmensaje_ibfk_2` FOREIGN KEY (`idPromocion`) REFERENCES `tbpromocion` (`idPromocion`);

--
-- Filtros para la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  ADD CONSTRAINT `tbpedido_ibfk_1` FOREIGN KEY (`idCarrito`) REFERENCES `tbcarrito` (`idCarrito`),
  ADD CONSTRAINT `tbpedido_ibfk_2` FOREIGN KEY (`idTipoPago`) REFERENCES `tbtipopago` (`idTipoPago`);

--
-- Filtros para la tabla `tbpedidoproducto`
--
ALTER TABLE `tbpedidoproducto`
  ADD CONSTRAINT `tbpedidoproducto_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tbpedido` (`idPedido`),
  ADD CONSTRAINT `tbpedidoproducto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`);

--
-- Filtros para la tabla `tbproducto`
--
ALTER TABLE `tbproducto`
  ADD CONSTRAINT `tbproducto_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `tbcategoria` (`idCategoria`);

--
-- Filtros para la tabla `tbpromocion`
--
ALTER TABLE `tbpromocion`
  ADD CONSTRAINT `tbpromocion_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idProducto`);

--
-- Filtros para la tabla `tbusuario`
--
ALTER TABLE `tbusuario`
  ADD CONSTRAINT `FK2tbdw6lsgbsdrhyex64u5kbij` FOREIGN KEY (`idDireccion`) REFERENCES `tbdireccion` (`idDireccion`),
  ADD CONSTRAINT `FK6dgi775fekruot59lqiv650ns` FOREIGN KEY (`idRol`) REFERENCES `tbrol` (`idRol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
