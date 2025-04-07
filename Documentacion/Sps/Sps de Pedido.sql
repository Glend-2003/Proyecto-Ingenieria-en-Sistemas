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
END