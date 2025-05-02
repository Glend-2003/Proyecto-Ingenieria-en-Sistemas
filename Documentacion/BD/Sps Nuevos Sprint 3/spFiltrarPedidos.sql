CREATE DEFINER=`root`@`localhost` PROCEDURE `spFiltrarPedidos`(
    IN p_idUsuario INT,
    IN p_estadoEntregaPedido INT,
    IN p_fechaInicio DATETIME,
    IN p_fechaFin DATETIME,
    IN p_estadoPedido INT
)
BEGIN
    -- Variables para construir la consulta dinámica
    DECLARE whereClause VARCHAR(1000);
    
    -- Construir la cláusula WHERE base
    SET whereClause = ' WHERE c.idUsuario = p_idUsuario';
    
    -- Agregar condición de filtro por estadoEntregaPedido si se proporciona
    IF p_estadoEntregaPedido IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.estadoEntregaPedido = ', p_estadoEntregaPedido);
    END IF;
    
    -- Agregar condición de filtro por fechas si se proporcionan (usando DATETIME)
    IF p_fechaInicio IS NOT NULL AND p_fechaFin IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.fechaPedido BETWEEN "', p_fechaInicio, '" AND "', p_fechaFin, '"');
    ELSEIF p_fechaInicio IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.fechaPedido >= "', p_fechaInicio, '"');
    ELSEIF p_fechaFin IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.fechaPedido <= "', p_fechaFin, '"');
    END IF;
    
    -- Agregar condición de filtro por estadoPedido si se proporciona
    IF p_estadoPedido IS NOT NULL THEN
        SET whereClause = CONCAT(whereClause, ' AND p.estadoPedido = ', p_estadoPedido);
    END IF;
    
    -- Reemplazar el parámetro en la cláusula WHERE
    SET @sql = REPLACE(whereClause, 'p_idUsuario', p_idUsuario);
    
    -- Construir la consulta completa
    SET @fullQuery = CONCAT('
        SELECT 
            p.idPedido,
            p.montoTotalPedido,
            p.fechaPedido,
            p.estadoPedido,
            CASE 
                WHEN p.estadoPedido = 1 THEN "Activo"
                ELSE "Inactivo"
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
            CONCAT(u.nombreUsuario, " ", u.primerApellido, " ", u.segundoApellido) AS nombreCompletoUsuario,
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
        LEFT JOIN tbproducto pr ON cp.idProducto = pr.idProducto', 
        @sql,
        ' ORDER BY p.fechaPedido DESC, pr.nombreProducto ASC');
    
    -- Preparar y ejecutar la consulta
    PREPARE stmt FROM @fullQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END