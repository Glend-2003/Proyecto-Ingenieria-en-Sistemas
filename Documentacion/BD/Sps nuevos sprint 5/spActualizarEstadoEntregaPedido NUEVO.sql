CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarEstadoEntregaPedido`(
    IN p_idPedido INT,
    IN p_nuevoEstado VARCHAR(50)
)
BEGIN
    IF p_nuevoEstado IN ('Pendiente', 'En proceso', 'Cancelado', 'Entregado','Listo') THEN
        UPDATE tbpedido 
        SET estadoEntregaPedido = p_nuevoEstado
        WHERE idPedido = p_idPedido;

        IF ROW_COUNT() > 0 THEN
            SELECT CONCAT('Estado actualizado a "', p_nuevoEstado, '" para pedido ', p_idPedido) AS Resultado;
        ELSE
            SELECT CONCAT('No existe pedido con ID: ', p_idPedido) AS Error;
        END IF;
    ELSE
        SELECT 'Error: Valores permitidos: Pendiente, En proceso, Cancelado, Entregado y Listo' AS Error;
    END IF;
END