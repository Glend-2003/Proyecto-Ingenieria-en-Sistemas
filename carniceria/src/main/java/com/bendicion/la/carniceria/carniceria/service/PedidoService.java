package com.bendicion.la.carniceria.carniceria.service;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import com.bendicion.la.carniceria.carniceria.jpa.GraficosPedidoRepository;
import com.bendicion.la.carniceria.carniceria.jpa.PedidoRepository;
import jakarta.transaction.Transactional;
import java.util.HashMap;

/**
 *
 * @author jsand
 */

@Service
@Primary
public class PedidoService implements IPedidoService {

    @Autowired
    private PedidoRepository pedidoRepo;
    
    @Autowired
    private CarritoService carritoRepo;
    
    @Autowired
    private GraficosPedidoRepository graficosRepo;

    @Transactional
    @Override
    public Pedido addPedido(Pedido pedido) {
        Integer idCarrito = pedido.getCarrito().getIdCarrito();
        Integer idTipoPago = pedido.getTipoPago().getIdTipoPago();
        
        Carrito carritos = carritoRepo.obtenerCarritoPorId(idCarrito);
        if (carritos == null) {
            throw new RuntimeException("El carrito con ID " + idCarrito + " no existe");
        }
        
        Date fechaPedido = Date.from(pedido.getFechaPedido().atZone(ZoneId.systemDefault()).toInstant());
        pedidoRepo.saveProcedurePedido(
            pedido.getMontoTotalPedido(),
            fechaPedido,
            pedido.isEstadoPedido(),
            pedido.getEstadoEntregaPedido(), 
            idCarrito, 
            idTipoPago
        );
        
        return pedido;
    }

    @Transactional
    @Override
    public Pedido updatePedido(Pedido pedido) {
        try {
            Date fecha = java.sql.Timestamp.valueOf(pedido.getFechaPedido());
            Integer estadoInt = pedido.isEstadoPedido() ? 1 : 0;
            
            pedidoRepo.updateProcedurePedido(
                pedido.getIdPedido(),
                pedido.getMontoTotalPedido(), 
                fecha, 
                estadoInt, 
                pedido.getEstadoEntregaPedido(), 
                pedido.getCarrito().getIdCarrito(),
                pedido.getTipoPago().getIdTipoPago()
            );
            
            return pedido;
        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar pedido: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Map<String, Object>> getPedido() {
        try {
            return pedidoRepo.listaPedido();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
public List<Map<String, Object>> getPedidoByUsuario(int id) {
    try {
        return pedidoRepo.getPedidoByUsuario(id);
    } catch (Exception e) {
        e.printStackTrace();
        return new ArrayList<>();
    }
}
    
    // Este elimina del todo, por medio de una cascada, lo que hace a eliminarlo d etodas las tablas
    
    @Transactional
    @Override
    public boolean deletePedido(int id) {
        pedidoRepo.deleteProcedurePedido(id);
        return true;
    }

    
    // Este lo que hace es cambiar el estado del pedido, y ocultar los que tienen estado 0
    
    @Transactional
    @Override
    public boolean updateStatePedido(int id) {
        pedidoRepo.deleteStateProcedurePedido(id);
        return true;
    }


    @Override
    @Transactional
    public void updateStateEntregaPedido(int idPedido, String nuevoEstado) {
        try {
            pedidoRepo.updateStateEntrega(idPedido, nuevoEstado);
        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar estado de entrega: " + e.getMessage());
        }
    }
    
    @Transactional
    public Map<String, Object> getTotalVentas() {
        try {
            return graficosRepo.obtenerVentasPorPeriodo("total");
        } catch (Exception e) {
            throw new RuntimeException("Error al obtener el reporte de ventas: " + e.getMessage());
        }
    }
    
    @Transactional
    public Map<String, Map<String, Object>> getReporteVentasCompleto() {
        try {
            Map<String, Map<String, Object>> reporte = new HashMap<>();
            
            reporte.put("diario", graficosRepo.obtenerVentasPorPeriodo("dia"));
            reporte.put("semanal", graficosRepo.obtenerVentasPorPeriodo("semana"));
            reporte.put("mensual", graficosRepo.obtenerVentasPorPeriodo("mes"));
            reporte.put("anual", graficosRepo.obtenerVentasPorPeriodo("anio"));
            reporte.put("total", graficosRepo.obtenerVentasPorPeriodo("total"));
            
            return reporte;
        } catch (Exception e) {
            throw new RuntimeException("Error al obtener el reporte completo de ventas: " + e.getMessage());
        }
    }
    
}

