CREATE DEFINER=`root`@`localhost` PROCEDURE `spLeerPedidosPorId`(IN p_idUsuario INT)
BEGIN
    -- Listar todos los pedidos con su información relacionada filtrados por idUsuario
    SELECT 
        p.idPedido,
        p.montoTotalPedido,
        p.fechaPedido,
        p.estadoPedido,
        CASE 
            WHEN p.estadoPedido = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS estadoPedidoTexto,
        p.estadoEntregaPedido,
        p.idCarrito,
        p.idTipoPago,
        
        -- Información del Tipo de Pago
        tp.descripcionTipoPago,
        tp.estadoTipoPago,
        
        -- Información del Carrito
        c.idUsuario,
        c.montoTotalCarrito,
        c.estadoCarrito,
        c.cantidadCarrito,
        
        -- Información del Usuario
        u.nombreUsuario,
        u.primerApellido,
        u.segundoApellido,
        CONCAT(u.nombreUsuario, ' ', u.primerApellido, ' ', u.segundoApellido) AS nombreCompletoUsuario,
        u.cedulaUsuario,
        u.correoUsuario,
        u.telefonoUsuario,
        u.fechaNacimiento,
        
        -- Conteo de productos en el carrito
        (
            SELECT COUNT(*) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadProductosDistintos,
        
        -- Total de items (sumando cantidades)
        (
            SELECT SUM(cantidadProducto) 
            FROM tbcarritoproducto 
            WHERE idCarrito = p.idCarrito
        ) AS cantidadTotalItems,
        
        -- Información del carrito-producto
        cp.idCarritoProducto,
        cp.cantidadProducto,
        
        -- Información del producto
        pr.idProducto,
        pr.nombreProducto,
        pr.imgProducto,
        pr.montoPrecioProducto,
        pr.descripcionProducto,
        pr.cantidadProducto AS stockProducto,
        pr.tipoPesoProducto,
        pr.codigoProducto,
        pr.idCategoria,
        pr.estadoProducto
        
    FROM tbpedido p
    INNER JOIN tbtipopago tp ON p.idTipoPago = tp.idTipoPago
    INNER JOIN tbcarrito c ON p.idCarrito = c.idCarrito
    INNER JOIN tbusuario u ON c.idUsuario = u.idUsuario
    LEFT JOIN tbcarritoproducto cp ON c.idCarrito = cp.idCarrito
    LEFT JOIN tbproducto pr ON cp.idProducto = pr.idProducto
    WHERE c.idUsuario = p_idUsuario  -- Filtro por idUsuario
    ORDER BY p.fechaPedido DESC, pr.nombreProducto ASC;
END