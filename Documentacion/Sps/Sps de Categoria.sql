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
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerCategoria`()
BEGIN
    SELECT * FROM tbcategoria;
END$$
DELIMITER ;
--_____________________________________________________________________________________________________________________________
