DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarCategoria`(
    IN p_idCategoria INT,
    IN p_nombre VARCHAR(255),
    IN p_descripcion VARCHAR(255)
)
BEGIN
    -- Asegúrate de que se use WHERE para actualizar solo la fila con el id especificado
    UPDATE tbcategoria
    SET nombreCategoria = p_nombre,
        descripcionCategoria = p_descripcion
    WHERE idCategoria = p_idCategoria;
END$$
DELIMITER ;
--_____________________________________________________________________________________________________________________________
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarCategoria`(
    IN nombreCategoria VARCHAR(255),
    IN descripcionCategoria VARCHAR(255)
)
BEGIN
    -- Inserta la nueva categoría en la tabla
    INSERT INTO tbcategoria (nombreCategoria, descripcionCategoria)
    VALUES (nombreCategoria, descripcionCategoria);

    -- Devuelve el ID de la última categoría agregada
    SELECT LAST_INSERT_ID() AS idCategoria;
END$$
DELIMITER ;
--_____________________________________________________________________________________________________________________________
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarCategoria`(
    IN p_idCategoria INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Manejo de errores SQL
        ROLLBACK;
        SELECT 'Error al intentar eliminar la categoría' AS mensaje;
    END;

    START TRANSACTION;

    -- Verificar si la categoría existe
    IF EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        DELETE FROM tbcategoria
        WHERE idCategoria = p_idCategoria;

        COMMIT;
        SELECT 'Categoría eliminada con éxito' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Categoría no encontrada' AS mensaje;
    END IF;

END$$
DELIMITER ;
--_____________________________________________________________________________________________________________________________
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoria`(IN `p_filtrarInactivos` BOOLEAN)
BEGIN
    IF p_filtrarInactivos THEN
    SELECT * FROM tbcategoria
    WHERE estadoCategoria = 1;
    ELSE
      SELECT * FROM tbcategoria
    ORDER BY estadoCategoria DESC;
    END IF;
END$$
DELIMITER ;
--_____________________________________________________________________________________________________________________________

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActivarCategoria`(IN `p_idCategoria` INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE estadoActual INT;

    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SELECT 'Error al activar la categoria' AS mensaje;
    END;

    -- Verificar si la categoria existe
    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbcategoria WHERE idCategoria = p_idCategoria) THEN
        SET done = 1;
        SELECT 'Categoraía no encontrado' AS mensaje;
    END IF;

    -- Cambiar el estado de la categoria si existe
    IF done = 0 THEN
        -- Obtener el estado actual de la categoria
        SELECT estadoCategoria INTO estadoActual FROM tbcategoria WHERE idCategoria = p_idCategoria;

        -- Cambiar el valor de estado a 1 si es 0, o a 0 si es 1
        UPDATE tbcategoria
        SET estadoCategoria = CASE WHEN estadoActual = 1 THEN 0 ELSE 1 END
        WHERE idCategoria = p_idCategoria;  -- Aquí corregido: usar idProducto en lugar de p_idProducto

        SELECT 'Categoria activada con éxito' AS mensaje;
    END IF;
END