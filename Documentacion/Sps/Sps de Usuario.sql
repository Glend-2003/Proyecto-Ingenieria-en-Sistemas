------------------------------------------------Usuario---------------------------------------------------|


---------------------sp agregar usuario----------------------|
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
    IN p_idRol INT
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

        -- Insertar en la tabla de usuarios
        INSERT INTO tbusuario (cedulaUsuario, nombreUsuario, primerApellido, segundoApellido, telefonoUsuario, correoUsuario, contraseniaUsuario, fechaNacimiento, idDireccion, idRol)
        VALUES (p_cedulaUsuario, p_nombreUsuario, p_primerApellido, p_segundoApellido, p_telefonoUsuario, p_correoUsuario, p_contraseniaUsuario, IFNULL(p_fechaNacimiento, NULL), @idDireccion, p_idRol);

        -- Confirmar la transacción
        COMMIT;
    ELSE
        -- Si hubo errores, deshacer la transacción
        ROLLBACK;
    END IF;

END$$
DELIMITER ;

--***************************************************************
----------------------sp actualizar usuario----------------------
--***************************************************************

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarUsuario`(
    IN `p_idUsuario` INT, 
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
    IN `p_idDistrito` INT
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

    -- Actualizar la información del usuario solo si se proporcionan los valores
    UPDATE tbusuario
    SET cedulaUsuario = IFNULL(p_cedulaUsuario, cedulaUsuario),
        nombreUsuario = IFNULL(p_nombreUsuario, nombreUsuario),
        primerApellido = IFNULL(p_primerApellido, primerApellido),
        segundoApellido = IFNULL(p_segundoApellido, segundoApellido),
        telefonoUsuario = IFNULL(p_telefonoUsuario, telefonoUsuario),
        correoUsuario = IFNULL(p_correoUsuario, correoUsuario),
        contraseniaUsuario = IFNULL(p_contraseniaUsuario, contraseniaUsuario),
        fechaNacimiento = IFNULL(p_fechaNacimiento, fechaNacimiento)
    WHERE idUsuario = p_idUsuario;

    -- Obtener el idDireccion del usuario
    SELECT idDireccion INTO @idDireccion FROM tbusuario WHERE idUsuario = p_idUsuario;

    -- Actualizar la información de la dirección relacionada
    UPDATE tbdireccion
    SET descripcionDireccion = IFNULL(p_descripcionDireccion, descripcionDireccion),
        codigoPostalDireccion = IFNULL(p_codigoPostalDireccion, codigoPostalDireccion),
        idDistrito = IFNULL(p_idDistrito, idDistrito)
    WHERE idDireccion = @idDireccion;

END$$
DELIMITER ;


---------------------sp eliminar usuario----------------------|

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario`(IN p_idUsuario INT, OUT p_salida VARCHAR(30))
BEGIN
		
    -- Variable de control
    DECLARE done INT DEFAULT 0;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback y se asigna un mensaje genérico
        ROLLBACK;
        SET p_salida = 'Error al eliminar';
    END;

 		IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbusuario WHERE idUsuario = p_idUsuario) THEN
        SET p_salida = 'El id del usuario no existe';
        SET done = 1; -- Detener flujo si hay error
    END IF;

	 IF done = 0 THEN
    -- Obtener la idDireccion del usuario
    SELECT idDireccion INTO @idDireccion FROM tbusuario WHERE idUsuario = p_idUsuario;

    -- Eliminar el usuario
    DELETE FROM tbusuario WHERE idUsuario = p_idUsuario;

    -- Eliminar la dirección relacionada
    DELETE FROM tbdireccion WHERE idDireccion = @idDireccion;
    
    SET p_salida = 'Usuario eliminado exitosamente';
   ELSE
        -- Si ocurrió algún error de validación, hacer rollback
        ROLLBACK;
    END IF;

END$$

---------------------sp leer usuario----------------------|

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
    ORDER BY estadoUsuario DESC;
END$$
DELIMITER ;

---------------------sp buscar usuario por id----------------------|
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
        u.idDireccion  -- Asegúrate de incluir esto
    FROM 
        tbusuario u
    LEFT JOIN 
        tbrol r ON u.idRol = r.idRol
    WHERE 
        u.correoUsuario = correoInput;
END$$
DELIMITER ;

---------------------sp verificar por correo----------------------|
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerificarCorreo`(IN p_correoUsuario VARCHAR(255))
BEGIN
    SELECT COUNT(*) AS existe FROM tbusuario WHERE correoUsuario = p_correoUsuario;
END$$
DELIMITER ;

---------------------sp registrar usuario----------------------|
DELIMITER $$
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
END;
DELIMITER ;


---------------------sp actualizar contraseña usuario----------------------|

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


---------------------sp cambiar estado usuario----------------------|
DELIMITER $$
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
END