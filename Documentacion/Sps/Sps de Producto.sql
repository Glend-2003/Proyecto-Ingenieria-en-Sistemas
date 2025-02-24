DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarProducto`(
    IN `p_nombreProducto` VARCHAR(255), 
    IN `p_imgProducto` VARCHAR(255), 
    IN `p_montoPrecioProducto` DECIMAL(12,2), 
    IN `p_descripcionProducto` VARCHAR(255), 
    IN `p_cantidadProducto` DECIMAL(10,2), 
    IN `p_tipoPesoProducto` VARCHAR(50), 
    IN `p_codigoProducto` VARCHAR(50), 
    IN `p_stockProducto` INT, 
    IN `p_idCategoria` INT, 
    IN `p_estadoProducto` TINYINT(1)
)
BEGIN
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción del producto';
    END;

    -- Iniciar transacción
    START TRANSACTION;

    -- Validar campos obligatorios y sus longitudes
    IF p_nombreProducto IS NULL OR CHAR_LENGTH(p_nombreProducto) = 0 OR CHAR_LENGTH(p_nombreProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de producto inválido';
    END IF;

    IF p_montoPrecioProducto IS NULL OR p_montoPrecioProducto <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio debe ser mayor a cero';
    END IF;

    IF p_descripcionProducto IS NOT NULL AND CHAR_LENGTH(p_descripcionProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Descripción demasiado larga';
    END IF;

    IF p_imgProducto IS NOT NULL AND CHAR_LENGTH(p_imgProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de imagen demasiado largo';
    END IF;

    IF p_codigoProducto IS NOT NULL AND CHAR_LENGTH(p_codigoProducto) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código de producto demasiado largo';
    END IF;

    IF p_tipoPesoProducto IS NOT NULL AND CHAR_LENGTH(p_tipoPesoProducto) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de peso demasiado largo';
    END IF;

    -- Validar existencia de categoría
    IF NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen (extensiones permitidas: .jpg, .png, .jpeg)
    IF p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg" THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Validar cantidad y stock
    IF p_cantidadProducto IS NOT NULL AND p_cantidadProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad de producto no puede ser negativa';
    END IF;

    IF p_stockProducto IS NOT NULL AND p_stockProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock de producto no puede ser negativo';
    END IF;

    -- Validación de unicidad del nombre dentro de la categoría
    IF EXISTS (SELECT 1 FROM tbproducto WHERE nombreProducto = p_nombreProducto AND idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto ya existe en esta categoría';
    END IF;

    -- Insertar el producto si todas las validaciones son exitosas
    INSERT INTO tbproducto (
        nombreProducto, imgProducto, montoPrecioProducto, descripcionProducto, 
        cantidadProducto, tipoPesoProducto, codigoProducto, stockProducto, 
        idCategoria, estadoProducto
    )
    VALUES (
        p_nombreProducto, p_imgProducto, p_montoPrecioProducto, p_descripcionProducto, 
        p_cantidadProducto, p_tipoPesoProducto, p_codigoProducto, p_stockProducto, 
        p_idCategoria, p_estadoProducto
    );

    COMMIT;
END$$

DELIMITER ;





DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarProducto`(
    IN `p_idProducto` INT, 
    IN `p_nombreProducto` VARCHAR(255), 
    IN `p_imgProducto` VARCHAR(255), 
    IN `p_montoPrecioProducto` DECIMAL(12,2), 
    IN `p_descripcionProducto` VARCHAR(255), 
    IN `p_cantidadProducto` DECIMAL(10,2), 
    IN `p_tipoPesoProducto` VARCHAR(50), 
    IN `p_codigoProducto` VARCHAR(50), 
    IN `p_stockProducto` INT, 
    IN `p_idCategoria` INT, 
    IN `p_estadoProducto` TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización del producto';
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

    IF p_descripcionProducto IS NOT NULL AND CHAR_LENGTH(p_descripcionProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Descripción demasiado larga';
    END IF;

    IF p_imgProducto IS NOT NULL AND CHAR_LENGTH(p_imgProducto) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de imagen demasiado largo';
    END IF;

    IF p_codigoProducto IS NOT NULL AND CHAR_LENGTH(p_codigoProducto) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código de producto demasiado largo';
    END IF;

    IF p_tipoPesoProducto IS NOT NULL AND CHAR_LENGTH(p_tipoPesoProducto) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de peso demasiado largo';
    END IF;

    -- Validar existencia de categoría
    IF p_idCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no existe';
    END IF;

    -- Validar formato de imagen si se proporciona
    IF p_imgProducto IS NOT NULL AND (p_imgProducto NOT LIKE "%.jpg" AND p_imgProducto NOT LIKE "%.png" AND p_imgProducto NOT LIKE "%.jpeg") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de imagen inválido';
    END IF;

    -- Validar cantidad y stock
    IF p_cantidadProducto IS NOT NULL AND p_cantidadProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad de producto no puede ser negativa';
    END IF;

    IF p_stockProducto IS NOT NULL AND p_stockProducto < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock de producto no puede ser negativo';
    END IF;

    -- Actualizar el producto si todas las validaciones son exitosas
    UPDATE tbproducto
    SET 
        nombreProducto = IFNULL(p_nombreProducto, nombreProducto),
        imgProducto = IFNULL(p_imgProducto, imgProducto),
        montoPrecioProducto = IFNULL(p_montoPrecioProducto, montoPrecioProducto),
        descripcionProducto = IFNULL(p_descripcionProducto, descripcionProducto),
        cantidadProducto = IFNULL(p_cantidadProducto, cantidadProducto),
        tipoPesoProducto = IFNULL(p_tipoPesoProducto, tipoPesoProducto),
        codigoProducto = IFNULL(p_codigoProducto, codigoProducto),
        stockProducto = IFNULL(p_stockProducto, stockProducto),
        idCategoria = IFNULL(p_idCategoria, idCategoria),
        estadoProducto = IFNULL(p_estadoProducto, estadoProducto)
    WHERE idProducto = p_idProducto;

    COMMIT;
END$$

DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerProducto`(IN p_filtrarInactivos BOOLEAN)
BEGIN
IF p_filtrarInactivos THEN
    SELECT 
        p.idProducto,
        p.nombreProducto,
        p.imgProducto,  -- Ruta relativa de la imagen
        p.montoPrecioProducto,
        p.descripcionProducto,
        p.cantidadProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria,
        c.nombreCategoria,  -- Nombre de la categoría
        p.estadoProducto
    FROM 
        tbproducto p
    JOIN 
        tbcategoria c ON p.idCategoria = c.idCategoria  -- Unión con la tabla de categorías
    WHERE p.estadoProducto = 1;
    ELSE
    SELECT 	
       p.idProducto,
        p.nombreProducto,
        p.imgProducto,  -- Ruta relativa de la imagen
        p.montoPrecioProducto,
        p.descripcionProducto,
        p.cantidadProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria,
        c.nombreCategoria,  -- Nombre de la categoría
        p.estadoProducto
    FROM 
        tbproducto p
    JOIN 
        tbcategoria c ON p.idCategoria = c.idCategoria  -- Unión con la tabla de categorías
    ORDER BY p.estadoProducto DESC;
 
    END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarProducto`(
    IN p_idProducto INT
)
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Validar existencia del producto antes de eliminar
    IF NOT EXISTS (SELECT 1 FROM tbproducto WHERE idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe';
    END IF;

    -- Eliminar el producto
    DELETE FROM tbproducto WHERE idProducto = p_idProducto;

    COMMIT;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarProductoPorId`(IN p_idProducto INT)
BEGIN
    -- Selecciona todos los campos del usuario basándose en el correo proporcionado
    SELECT 
        p.idProducto, 
        p.nombreProducto, 
        p.imgProducto, 
        p.montoPrecioProducto, 
        p.descripcionProducto,
        p.cantidadProducto,
        p.tipoPesoProducto,
        p.codigoProducto,
        p.stockProducto,
        p.idCategoria, 
        p.estadoProducto
       
    FROM 
        tbproducto p

        WHERE p.idProducto = p_idProducto;
 
END$$
DELIMITER ;

--_____________________________Modificar estado producto________________________________________

DELIMITER $$
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
        WHERE idProducto = p_idProducto;  -- Aquí corregido: usar idProducto en lugar de p_idProducto

        SELECT 'Producto activado con éxito' AS mensaje;
    END IF;
END