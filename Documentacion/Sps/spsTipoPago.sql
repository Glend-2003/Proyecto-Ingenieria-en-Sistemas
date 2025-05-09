
-- Update

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarTipoPago`(IN `p_idTipoPago` INT, IN `p_descripcionTipoPago` VARCHAR(255), IN `p_estado` INT)
BEGIN
    
    UPDATE tbtipopago
    SET descripcionTipoPago = p_descripcionTipoPago,
        estadoTipoPago = p_estado 
    WHERE idTipoPago = p_idTipoPago;
END$$
DELIMITER ;

-- Create

DELIMITER $$

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
END$$

DELIMITER ;

-- Eliminar

DELIMITER $$

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

END$$

DELIMITER ;

-- Leer

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerTipoPago`()
BEGIN
    -- Leer solo los tipos de pago donde el estado sea 1 (activo)
    SELECT * FROM tbtipopago
    ORDER BY estadoTipoPago DESC;
END$$
DELIMITER ;

-- Leer por ID

DELIMITER $$

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
END$$

DELIMITER ;

DELIMITER $$
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
END
