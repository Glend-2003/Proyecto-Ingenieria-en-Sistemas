DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarRol`(IN `nombreRol` VARCHAR(255), IN `descripcionRol` VARCHAR(255))
BEGIN
    -- Inserta el nuevo rol en la tabla
    INSERT INTO tbrol (nombreRol, descripcionRol)
    VALUES (nombreRol, descripcionRol);

    SELECT * FROM tbrol WHERE idRol = LAST_INSERT_ID();
END$$
DELIMITER ;

-----------------------------------------

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarRol`(IN `p_idRol` INT(10), IN `p_nombre` VARCHAR(255), IN `p_descripcion` VARCHAR(255))
BEGIN
    -- Asegúrate de que se use WHERE para actualizar solo la fila con el id especificado
    UPDATE tbRol
    SET nombreRol = p_nombre,
        descripcionRol = p_descripcion
    WHERE idRol = p_idRol;
END$$
DELIMITER ;

-------------------------------------------

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarRol`(IN `p_idRol` INT)
BEGIN
    -- Usar WHERE para eliminar solo la fila con el id especificado
    DELETE FROM tbrol
    WHERE idRol = p_idRol;
END$$
DELIMITER ;

--------------------------------------------

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerRol`()
BEGIN
    SELECT * FROM tbrol;
END$$
DELIMITER ;