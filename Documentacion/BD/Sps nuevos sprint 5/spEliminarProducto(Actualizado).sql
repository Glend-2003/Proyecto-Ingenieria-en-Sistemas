CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarProducto`(IN `p_idProducto` INT)
BEGIN
    DECLARE v_producto_existe INT DEFAULT 0;
    
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Error al eliminar el producto' AS mensaje;
    END;
    
    -- Verificar si el producto existe
    SELECT COUNT(*) INTO v_producto_existe FROM tbproducto WHERE idProducto = p_idProducto;
    
    IF v_producto_existe = 0 THEN
        SELECT 'Producto no encontrado' AS mensaje;
    ELSE
        -- Iniciar transacción para operación atómica
        START TRANSACTION;
        
        -- Eliminar el producto
        DELETE FROM tbproducto WHERE idProducto = p_idProducto;
        
        -- Confirmar transacción
        COMMIT;
        
        SELECT 'Producto eliminado con éxito' AS mensaje;
    END IF;
END