CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario`(IN `p_idUsuario` INT)
BEGIN
    DECLARE v_idDireccion INT;
    DECLARE v_usuario_existe INT DEFAULT 0;

    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Error al eliminar el usuario' AS mensaje;
    END;

    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO v_usuario_existe FROM tbusuario WHERE idUsuario = p_idUsuario;
    
    IF v_usuario_existe = 0 THEN
        SELECT 'Usuario no encontrado' AS mensaje;
    ELSE
        -- Obtener el idDireccion asociado al usuario
        SELECT idDireccion INTO v_idDireccion
        FROM tbusuario
        WHERE idUsuario = p_idUsuario;

        -- Iniciar transacción
        START TRANSACTION;

        -- Primero eliminar el usuario (que referencia la dirección)
        DELETE FROM tbusuario WHERE idUsuario = p_idUsuario;
        
        -- Luego eliminar la dirección (ahora que no hay referencias)
        DELETE FROM tbdireccion WHERE idDireccion = v_idDireccion;

        -- Confirmar transacción
        COMMIT;

        SELECT 'Usuario eliminado con éxito' AS mensaje;
    END IF;
END