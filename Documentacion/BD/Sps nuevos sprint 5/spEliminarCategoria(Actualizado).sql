CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarCategoria`(IN `p_idCategoria` INT)
BEGIN
    DECLARE v_categoria_existe INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al intentar eliminar la categoría' AS mensaje;
    END;
    
    -- Verificar si la categoría existe
    SELECT COUNT(*) INTO v_categoria_existe FROM tbcategoria WHERE idCategoria = p_idCategoria;
    
    IF v_categoria_existe = 0 THEN
        SELECT 'Categoria no encontrada' AS mensaje;
    ELSE
        START TRANSACTION;
        
        DELETE FROM tbcategoria WHERE idCategoria = p_idCategoria;
        
        COMMIT;
        
        SELECT 'Categoría eliminada con éxito' AS mensaje;
    END IF;
END