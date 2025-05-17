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
        WHERE idProducto = p_idProducto;

        -- Desactivar las promociones asociadas solo si el producto se desactiva
        IF estadoActual = 1 THEN
            UPDATE tbpromocion
            SET estadoPromocion = 0
            WHERE idProducto = p_idProducto;
        END IF;

        SELECT 'Producto activado/desactivado con éxito' AS mensaje;
    END IF;
END