package com.bendicion.la.carniceria.carniceria.jpa;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Integer>{

    @Modifying
    @Query(value = "{call spAgregarPedido(:montoTotalPedido, :fechaPedido, :estadoPedido, :estadoEntregaPedido, :idCarrito, :idTipoPago)}", nativeQuery = true)
    void saveProcedurePedido(
        @Param("montoTotalPedido") BigDecimal montoTotalPedido, 
        @Param("fechaPedido") Date fechaPedido,
        @Param("estadoPedido") boolean estadoPedido,
        @Param("estadoEntregaPedido") String estadoEntregaPedido,
        @Param("idCarrito") Integer idCarrito,
        @Param("idTipoPago") Integer idTipoPago
    );

    @Query(value = "{call spLeerPedido()}", nativeQuery = true)
    List<Pedido> listaPedido();

    @Modifying
    @Query(value = "{call spActualizarPedido(:idPedido, :montoTotalPedido, :fechaPedido, :estadoPedido, :estadoEntregaPedido, :idCarrito, :idTipoPago)}", nativeQuery = true)
    void updateProcedurePedido(
        @Param("idPedido") Integer idPedido,
        @Param("montoTotalPedido") BigDecimal montoTotalPedido, 
        @Param("fechaPedido") Date fechaPedido,
        @Param("estadoPedido") boolean estadoPedido,
        @Param("estadoEntregaPedido") String estadoEntregaPedido,
        @Param("idCarrito") Integer idCarrito,
        @Param("idTipoPago") Integer idTipoPago
    );

    @Query(value = "{call spEliminarPedido(:idPedido)}", nativeQuery = true)
    void deleteProcedurePedido(@Param("idPedido") Integer idPedido);
    
}
