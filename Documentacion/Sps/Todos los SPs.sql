DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarCategoria`(IN `p_idCategoria` INT, IN `p_nombre` VARCHAR(255), IN `p_descripcion` VARCHAR(255), IN `p_estado` INT)
BEGIN
    
    UPDATE tbcategoria
    SET nombreCategoria = p_nombre,
        descripcionCategoria = p_descripcion,
        estadoCategoria = p_estado 
    WHERE idCategoria = p_idCategoria;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarComentario`(IN `p_idComentario` INT, IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `P_idUsuario` INT, IN `p_numCalificacion` INT)
BEGIN
    
    UPDATE tbcomentario
    SET descripcionComentario = p_descripcionComentario,
        fechaComentario = p_fechaComentario,
        idUsuario = P_idUsuario,
        numCalificacion = p_numCalificacion
    WHERE idComentario = p_idComentario;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarContrasena`(
    IN p_idUsuario INT,  
    IN p_nuevaContraseniaUsuario VARCHAR(255)
)
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
END$$
DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarProducto`(
    IN `p_idProducto` INT, 
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
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización del producto';
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
    IF p_idCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen si se proporciona
    IF p_imgProducto IS NOT NULL AND (p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Validar cantidad y stock
    IF p_cantidadProducto IS NOT NULL AND p_cantidadProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad de producto no puede ser negativa';
    END IF;

    IF p_stockProducto IS NOT NULL AND p_stockProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock de producto no puede ser negativo';
    END IF;

    -- Actualizar el producto si todas las validaciones son exitosas
    UPDATE tbproducto
    SET 
        nombreProducto = IFNULL(p_nombreProducto, nombreProducto),
        imgProducto = IFNULL(p_imgProducto, imgProducto),
        montoPrecioProducto = IFNULL(p_montoPrecioProducto, montoPrecioProducto),
        descripcionProducto = IFNULL(p_descripcionProducto, descripcionProducto),
        cantidadProducto = IFNULL(p_cantidadProducto, cantidadProducto),
        tipoPesoProducto = IFNULL(p_tipoPesoProducto, tipoPesoProducto),
        codigoProducto = IFNULL(p_codigoProducto, codigoProducto),
        stockProducto = IFNULL(p_stockProducto, stockProducto),
        idCategoria = IFNULL(p_idCategoria, idCategoria),
        estadoProducto = IFNULL(p_estadoProducto, estadoProducto)
    WHERE idProducto = p_idProducto;

    COMMIT;
END$$

DELIMITER ;



DELIMITER $$
CREATE PROCEDURE `spLeerProducto`()
BEGIN
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
    WHERE 
        p.estadoProducto = true;  -- Solo muestra productos activos
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarRol`(
    IN p_idRol INT(10),
    IN p_nombre VARCHAR(255),
    IN p_descripcion VARCHAR(255),
    IN p_estado TINYINT -- Nueva entrada para estado
)
BEGIN
    -- Actualiza los campos del rol, incluyendo el estado
    UPDATE tbRol
    SET nombreRol = p_nombre,
        descripcionRol = p_descripcion,
        estadoRol = p_estado -- Actualizar el estado
    WHERE idRol = p_idRol;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarUsuario`(
    IN p_idUsuario INT, 
    IN p_cedulaUsuario VARCHAR(255), 
    IN p_nombreUsuario VARCHAR(255), 
    IN p_primerApellido VARCHAR(255), 
    IN p_segundoApellido VARCHAR(255), 
    IN p_telefonoUsuario VARCHAR(255), 
    IN p_correoUsuario VARCHAR(255), 
    IN p_contraseniaUsuario VARCHAR(255), 
    IN p_fechaNacimiento DATE, 
    IN p_descripcionDireccion VARCHAR(255), 
    IN p_codigoPostalDireccion VARCHAR(255), 
    IN p_idDistrito INT,
    IN p_estadoUsuario TINYINT -- Nueva entrada para el estado
)
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarCategoria`(
    IN nombreCategoria VARCHAR(255),
    IN descripcionCategoria VARCHAR(255),
    IN estadoCategoria INT 
)
BEGIN
    
    INSERT INTO tbcategoria (nombreCategoria, descripcionCategoria, estadoCategoria)
    VALUES (nombreCategoria, descripcionCategoria, estadoCategoria);

    
    SELECT LAST_INSERT_ID() AS idCategoria;
END$$
DELIMITER ;

DELIMITER $$
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
        INSERT INTO tbcomentario (descripcionComentario, fechaComentario, idUsuario, numCalificacion)
        VALUES (p_descripcionComentario, p_fechaComentario, p_idUsuario, p_numCalificacionComentario);

        -- Hacer commit si todo est  bien
        COMMIT;
   

END$$
DELIMITER ;

DELIMITER $$

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
END$$

DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarRol`(
    IN nombreRol VARCHAR(255),
    IN descripcionRol VARCHAR(255),
    IN estadoRol TINYINT -- Nueva entrada para estado
)
BEGIN
    -- Inserta el nuevo rol en la tabla incluyendo el estado
    INSERT INTO tbrol (nombreRol, descripcionRol, estadoRol)
    VALUES (nombreRol, descripcionRol, estadoRol);

    SELECT * FROM tbrol WHERE idRol = LAST_INSERT_ID();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarUsuario`(
    IN p_cedulaUsuario VARCHAR(255), 
    IN p_nombreUsuario VARCHAR(255), 
    IN p_primerApellido VARCHAR(255), 
    IN p_segundoApellido VARCHAR(255), 
    IN p_telefonoUsuario VARCHAR(255), 
    IN p_correoUsuario VARCHAR(255), 
    IN p_contraseniaUsuario VARCHAR(255), 
    IN p_fechaNacimiento DATE,  
    IN p_descripcionDireccion VARCHAR(255), 
    IN p_codigoPostalDireccion VARCHAR(255), 
    IN p_idDistrito INT, 
    IN p_idRol INT,
    IN p_estadoUsuario TINYINT -- Nueva entrada para el estado
)
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarUsuarioPorCorreo`(
    IN correoInput VARCHAR(255)
)
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
END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarProducto`(
    IN p_idProducto INT
)
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarRol`(
    IN p_idRol INT
)
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario`(
    IN p_idUsuario INT
)
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoria`()
BEGIN
    -- Leer solo las categorías donde el estado sea 1 (activo)
    SELECT * FROM tbcategoria
    WHERE estadoCategoria = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoriaPorId`(
    IN p_idCategoria INT
)
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
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentarios`()
BEGIN
    SELECT 
        c.idComentario,
        c.descripcionComentario,
        c.fechaComentario,
        c.numCalificacion,
        c.verificacion,
        u.idUsuario,
        u.nombreUsuario
    FROM 
        tbcomentario c
    LEFT JOIN 
        tbusuario u ON c.idUsuario = u.idUsuario;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosAdmin`()
BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 0;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosUsuario`()
BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerDistrito`()
BEGIN
    SELECT d.idDistrito, d.nombreDistrito, c.idCanton
    FROM tbdistrito d
    JOIN tbcanton c ON d.idCanton = c.idCanton;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerProducto`()
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerRol`()
BEGIN
    -- Leer solo los roles donde el estado sea 1 (activo)
    SELECT * FROM tbrol
    WHERE estadoRol = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerUsuario`()
BEGIN
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
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegistrarUsuario`(
    IN `p_correoUsuario` VARCHAR(255), 
    IN `p_contraseniaUsuario` VARCHAR(255),
    IN `p_nombreUsuario` VARCHAR(255), 
    IN `p_primerApellido` VARCHAR(255), 
    IN `p_segundoApellido` VARCHAR(255),
    IN `p_estadoUsuario` TINYINT
)
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarCorreo`(IN p_correoUsuario VARCHAR(255))
BEGIN
    SELECT COUNT(*) AS existe FROM tbusuario WHERE correoUsuario = p_correoUsuario;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarIDUsuario`(
    IN `p_idUsuario` INT
)
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
END$$
DELIMITER ;
