--*******************************************ACTUALIZAR COMENTARIO********************************************************************

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarComentario`(IN `p_idComentario` INT, IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `P_idUsuario` INT, IN `p_numCalificacion` INT)
BEGIN
    
    UPDATE tbcomentario
    SET descripcionComentario = p_descripcionComentario,
        fechaComentario = p_fechaComentario,
        idUsuario = P_idUsuario,
        numCalificacion = p_numCalificacion
    WHERE idComentario = p_idComentario;
END$$
DELIMITER ;


--*******************************************AGREGAR COMENTARIO********************************************************************


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAgregarComentario`(IN `p_descripcionComentario` VARCHAR(1000), IN `p_fechaComentario` DATETIME, IN `p_idUsuario` INT, IN `p_numCalificacionComentario` INT)
BEGIN
    -- Manejador de errores para capturar excepciones SQL genéricas
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error SQL, se hace rollback
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al agregar el comentario';
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    
        -- Insertar en la tabla comentario sin incluir el campo autoincremental idComentario
        INSERT INTO tbcomentario (descripcionComentario, fechaComentario, idUsuario, numCalificacion)
        VALUES (p_descripcionComentario, p_fechaComentario, p_idUsuario, p_numCalificacionComentario);

        -- Hacer commit si todo está bien
        COMMIT;
   

END$$
DELIMITER ;


--*******************************************ELIMINAR COMENTARIO********************************************************************

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarComentario`(IN `p_idComentario` INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      
        ROLLBACK;
        SELECT 'Error al intentar eliminar el comentario' AS mensaje;
    END;

    START TRANSACTION;

   
    IF EXISTS (SELECT 1 FROM tbcomentario WHERE idComentario = p_idComentario) THEN
     
          DELETE FROM tbcomentario
   		 WHERE idComentario = p_idComentario;

        COMMIT;
        SELECT 'Comentario eliminado con exito' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Error al borrar comentario' AS mensaje;
    END IF;

END$$
DELIMITER ;




--*******************************************LEER COMENTARIO ADMIN********************************************************************

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosAdmin`()
BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 0;
END$$
DELIMITER ;

--*******************************************LEER COMENTARIO USUARIO********************************************************************

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerComentariosUsuario`()
BEGIN
    SELECT * FROM tbcomentario
    WHERE verificacion = 1;
END$$
DELIMITER ;

--*******************************************MOSTRAR COMENTARIO********************************************************************

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarComentario`(IN `p_idComentario` INT)
BEGIN
    
    DECLARE done INT DEFAULT 0;

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
      
        ROLLBACK;
     
        SELECT 'Error al mostrar el comentario' AS mensaje;
    END;

    IF done = 0 AND NOT EXISTS (SELECT 1 FROM tbcomentario WHERE idComentario = p_idComentario) THEN
     
        SET done = 1;
       
        SELECT 'Comentario no encontrado' AS mensaje;
    END IF;

    IF done = 0 THEN
        
        UPDATE tbcomentario
        SET verificacion = 1
        WHERE idComentario = p_idComentario;

    
        SELECT 'Comentario verificado con éxito' AS mensaje;
    END IF;

END$$
DELIMITER ;