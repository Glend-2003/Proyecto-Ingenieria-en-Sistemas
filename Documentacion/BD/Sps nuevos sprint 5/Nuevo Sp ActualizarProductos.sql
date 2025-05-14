CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarProducto`(IN `p_idProducto` INT, 
 IN `p_nombreProducto` VARCHAR(255),
 IN `p_imgProducto` VARCHAR(255), 
 IN `p_montoPrecioProducto` DECIMAL(10,3), 
 IN `p_descripcionProducto` VARCHAR(500), 
 IN `p_cantidadProducto` DECIMAL(10,2), 
 IN `p_tipoPesoProducto` VARCHAR(50), 
 IN `p_codigoProducto` VARCHAR(50), 
 IN `p_stockProducto` INT, 
 IN `p_idCategoria` INT,
 IN `p_estadoProducto` BOOLEAN)
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Validar existencia del producto
    IF NOT EXISTS (SELECT 1 FROM tbproducto WHERE idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe';
    END IF;

    -- Validar campos obligatorios y sus longitudes
    IF p_nombreProducto IS NOT NULL AND CHAR_LENGTH(p_nombreProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de producto demasiado largo';
    END IF;

    IF p_montoPrecioProducto IS NOT NULL AND p_montoPrecioProducto <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio debe ser mayor a cero';
    END IF;

    IF p_descripcionProducto IS NOT NULL AND CHAR_LENGTH(p_descripcionProducto) > 500 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Descripción demasiado larga';
    END IF;

    IF p_imgProducto IS NOT NULL AND CHAR_LENGTH(p_imgProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de imagen demasiado largo';
    END IF;

    -- Validar existencia de categoría
    IF p_idCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen si se proporciona
    IF p_imgProducto IS NOT NULL AND (p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Actualizar el producto si todas las validaciones son exitosas
    UPDATE tbproducto
    SET 
        nombreProducto = IFNULL(p_nombreProducto, nombreProducto),
        imgProducto = IFNULL(p_imgProducto, imgProducto),
        montoPrecioProducto = IFNULL(p_montoPrecioProducto, montoPrecioProducto),
        descripcionProducto = IFNULL(p_descripcionProducto, descripcionProducto),
        cantidadProducto = ifnull(p_cantidadProducto, cantidadProducto),
        tipoPesoProducto = IFNULL(p_tipoPesoProducto, tipoPesoProducto),
        codigoProducto = IFNULL(p_codigoProducto, codigoProducto),
        stockProducto = IFNULL(p_stockProducto, stockProducto),
        idCategoria = IFNULL(p_idCategoria, idCategoria),
        estadoProducto = IFNULL(p_estadoProducto, estadoProducto)
    WHERE idProducto = p_idProducto;

    COMMIT;
END