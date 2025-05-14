CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarStock`(IN `p_idProducto` INT,
 IN `p_cantidadProducto` INT)
BEGIN
    DECLARE restarStock INT;
    
    SELECT stockProducto INTO restarStock
    FROM tbproducto
    WHERE idProducto = p_idProducto;
    
    IF restarStock < p_cantidadProducto THEN
    ROLLBACK;
        SELECT 'No hay suficientes productos en stock.' AS mensaje;
    END IF;
    
    SET restarStock = restarStock - p_cantidadProducto;
    
    UPDATE tbproducto
    SET stockProducto = restarStock
    WHERE idProducto = p_idProducto;
END