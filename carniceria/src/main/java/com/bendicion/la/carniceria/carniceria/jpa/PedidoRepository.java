package com.bendicion.la.carniceria.carniceria.jpa;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import java.util.Map;

@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Integer> {

    @Query(value = "{call sp_AgregarPedido(:montoTotalPedido, :fechaPedido, :estadoPedido, :estadoEntregaPedido, :idCarrito, :idTipoPago)}", nativeQuery = true)
    void saveProcedurePedido(
        @Param("montoTotalPedido") BigDecimal montoTotalPedido, 
        @Param("fechaPedido") Date fechaPedido,
        @Param("estadoPedido") boolean estadoPedido,
        @Param("estadoEntregaPedido") String estadoEntregaPedido,
        @Param("idCarrito") Integer idCarrito,
        @Param("idTipoPago") Integer idTipoPago
    );

    @Query(value = "CALL spLeerPedidoDetallado()", nativeQuery = true)
    List<Map<String, Object>> listaPedido();

    @Modifying
    @Query(value = "{call spActualizarPedido(:idPedido, :montoTotalPedido, :fechaPedido, :estadoPedido, :estadoEntregaPedido, :idCarrito, :idTipoPago)}", nativeQuery = true)
    void updateProcedurePedido(
        @Param("idPedido") Integer idPedido,
        @Param("montoTotalPedido") BigDecimal montoTotalPedido, 
        @Param("fechaPedido") Date fechaPedido,
        @Param("estadoPedido") Integer estadoPedido,
        @Param("estadoEntregaPedido") String estadoEntregaPedido,
        @Param("idCarrito") Integer idCarrito,
        @Param("idTipoPago") Integer idTipoPago
    );

    @Query(value = "{call spEliminarPedido(:idPedido)}", nativeQuery = true)
    void deleteProcedurePedido(@Param("idPedido") Integer idPedido);

    
    @Query(value = "{call spActualizarEstadoPedido(:idPedido)}", nativeQuery = true)
    void deleteStateProcedurePedido(@Param("idPedido") Integer idPedido);
    
    @Modifying
    @Query(value = "{call spActualizarEstadoEntregaPedido(:idPedido, :nuevoEstado)}", nativeQuery = true)
    void updateStateEntrega(
        @Param("idPedido") Integer idPedido,
        @Param("nuevoEstado") String nuevoEstado
    );
    
    @Query(value = "{call spObtenerTotalVentas(:periodo)}", nativeQuery = true)
    Map<String, Object> getTotalVentasConPeriodo(@Param("periodo") String periodo);
    
}
