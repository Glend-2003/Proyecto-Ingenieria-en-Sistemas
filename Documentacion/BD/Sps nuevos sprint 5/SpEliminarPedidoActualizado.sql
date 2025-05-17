CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarPedido`(
    IN p_idPedido INT
)
BEGIN
    DECLARE v_idCarrito INT;
    DECLARE v_idProducto INT;
    DECLARE v_cantidadProducto INT;
    DECLARE done INT DEFAULT FALSE;

    DECLARE cur CURSOR FOR
        SELECT cp.idProducto, cp.cantidadProducto
        FROM tbcarritoproducto cp
        INNER JOIN tbpedido p ON p.idCarrito = cp.idCarrito
        WHERE p.idPedido = p_idPedido;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

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

    -- Obtener el idCarrito asociado al pedido
    SELECT idCarrito INTO v_idCarrito
    FROM tbpedido
    WHERE idPedido = p_idPedido;

    -- Actualizar el stock de los productos antes de eliminar
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_idProducto, v_cantidadProducto;
        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE tbproducto
        SET stockProducto = stockProducto + v_cantidadProducto
        WHERE idProducto = v_idProducto;
    END LOOP;

    CLOSE cur;

    -- Eliminar productos del carrito (dependen del carrito)
    DELETE FROM tbcarritoproducto WHERE idCarrito = v_idCarrito;

    -- Eliminar el carrito
    DELETE FROM tbcarrito WHERE idCarrito = v_idCarrito;

    -- Eliminar el pedido
    DELETE FROM tbpedido WHERE idPedido = p_idPedido;

    COMMIT;

    SELECT 'Pedido, carrito y productos relacionados eliminados correctamente, y stock actualizado' AS Mensaje;
END