-- Procedimiento para Agregar Notificación
DELIMITER //
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
END //
DELIMITER ;

-- Procedimiento para Eliminar Notificación
DELIMITER //
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
END //
DELIMITER ;

-- Procedimiento para Leer Notificaciones
DELIMITER //
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
END //
DELIMITER ;

-- Procedimiento para Marcar Notificación como Leída
DELIMITER //
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
END //
DELIMITER ;