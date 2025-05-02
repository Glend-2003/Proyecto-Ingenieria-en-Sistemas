CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerTotalVentas`(
    IN p_periodo VARCHAR(10) -- 'dia', 'semana', 'mes', 'anio', 'total'
)
BEGIN
    -- Ventas del día actual (canceladas)
    IF p_periodo = 'dia' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'dia' AS periodo
        FROM tbpedido
        WHERE DATE(fechaPedido) = CURDATE()
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas de la semana actual (canceladas)
    ELSEIF p_periodo = 'semana' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'semana' AS periodo
        FROM tbpedido
        WHERE YEARWEEK(fechaPedido, 1) = YEARWEEK(CURDATE(), 1)
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas del mes actual (canceladas)
    ELSEIF p_periodo = 'mes' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'mes' AS periodo
        FROM tbpedido
        WHERE YEAR(fechaPedido) = YEAR(CURDATE())
        AND MONTH(fechaPedido) = MONTH(CURDATE())
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas del año actual (canceladas)
    ELSEIF p_periodo = 'anio' THEN
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'anio' AS periodo
        FROM tbpedido
        WHERE YEAR(fechaPedido) = YEAR(CURDATE())
        AND estadoEntregaPedido = 'Entregado';
    
    -- Ventas totales (canceladas, sin filtro de fecha)
    ELSE
        SELECT 
            IFNULL(SUM(montoTotalPedido), 0) AS totalVentas,
            COUNT(idPedido) AS cantidadPedidos,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido), 0), 2)) AS totalFormateado,
            IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0) AS promedio,
            CONCAT('₡', FORMAT(IFNULL(SUM(montoTotalPedido)/NULLIF(COUNT(idPedido), 0), 0), 2)) AS promedioFormateado,
            'total' AS periodo
        FROM tbpedido
        WHERE estadoEntregaPedido = 'Entregado';
    END IF;
END
DELIMITER ;