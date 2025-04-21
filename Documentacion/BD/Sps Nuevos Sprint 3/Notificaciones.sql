CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarNotificacion`(

IN `p_descripcionNotificacion` VARCHAR(255), 
IN `p_idUsuario` int ,
 IN `p_fechaNotificacion` date)
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
    INSERT INTO tbnotificacion (descripcionNotificacion, idUsuario, leidos,fechaNotificacion)
    VALUES (p_descripcionNotificacion,p_idUsuario,1, p_fechaNotificacion);

    
    SELECT LAST_INSERT_ID() AS idNotificacion;
      -- Hacer commit si todo est  bien
        COMMIT;
END

----------------------------------------Eliminar--------------------------------------

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
    IF NOT EXISTS (SELECT 1 FROM `tbnotificacion` WHERE `idNotificacion` = `p_idNotificacion`) THEN
        SELECT 'La notificación no existe' AS mensaje;
    ELSE
        -- Eliminar la notificación
        DELETE FROM `tbnotificacion` WHERE `idNotificacion` = `p_idNotificacion`;
        SELECT CONCAT('Notificación con ID ', `p_idNotificacion`, ' eliminada correctamente.') AS `Mensaje`;
    END IF;

    COMMIT;
END


---------------------------Leeeerr--------------------------------
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
END

-----------------------Marcar como leida----------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMarcarNotificacionLeida`(
    IN `p_idNotificacion` INT  
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        Select 'Error al marcar la notificación como leída'AS mensaje;
    END;

    START TRANSACTION;

    -- Verifica si la notificación existe
    IF NOT EXISTS (SELECT 1 FROM `tbnotificacion` WHERE `idNotificacion` = `p_idNotificacion`) THEN
       Select 'La notificación no existe' AS mensaje;
    ELSE
        -- Marca como leída
        UPDATE `tbnotificacion` 
        SET `leidos` = 0 
        WHERE `idNotificacion` = `p_idNotificacion`;
        
        SELECT 'Notificación marcada como leída correctamente.' AS `Mensaje`;
    END IF;

    COMMIT;
END