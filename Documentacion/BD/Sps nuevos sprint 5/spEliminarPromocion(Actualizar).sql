CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarPromocion`(IN `p_idPromocion` INT)
BEGIN
    DECLARE v_promocion_existe INT DEFAULT 0;
    
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al intentar eliminar la promoción' AS mensaje;
    END;
    
    -- Verificar si la promoción existe
    SELECT COUNT(*) INTO v_promocion_existe 
    FROM tbpromocion 
    WHERE idPromocion = p_idPromocion;
    
    IF v_promocion_existe = 0 THEN
        SELECT 'Promoción no encontrada' AS mensaje;
    ELSE
        -- Iniciar transacción
        START TRANSACTION;
        
        -- Eliminación física de la promoción
        DELETE FROM tbpromocion
        WHERE idPromocion = p_idPromocion;
        
        -- Confirmar transacción
        COMMIT;
        
        SELECT 'Promoción eliminada con éxito' AS mensaje;
    END IF;
END