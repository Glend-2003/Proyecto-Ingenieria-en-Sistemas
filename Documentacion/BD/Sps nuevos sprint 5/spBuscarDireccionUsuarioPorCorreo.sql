CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarDireccionUsuarioPorCorreo`(
    IN p_correoUsuario VARCHAR(100)
)
BEGIN
    SELECT 
        u.idUsuario,
        u.nombreUsuario,
        u.primerApellido,
        u.segundoApellido,
        u.correoUsuario,
        u.telefonoUsuario,
        u.cedulaUsuario,
        d.idDireccion,
        d.codigoPostalDireccion,
        d.descripcionDireccion,
        dis.idDistrito,
        dis.nombreDistrito,
        c.idCanton,
        c.nombreCanton,
        p.idProvincia,
        p.nombreProvincia
    FROM 
        bdcarniceria.tbusuario u
    LEFT JOIN 
        bdcarniceria.tbdireccion d ON u.idDireccion = d.idDireccion
    LEFT JOIN 
        bdcarniceria.tbdistrito dis ON d.idDistrito = dis.idDistrito
    LEFT JOIN 
        bdcarniceria.tbcanton c ON dis.idCanton = c.idCanton
    LEFT JOIN 
        bdcarniceria.tbprovincia p ON c.idProvincia = p.idProvincia
    WHERE 
        u.correoUsuario = p_correoUsuario;
END