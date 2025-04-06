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
import com.bendicion.la.carniceria.carniceria.jpa.PedidoRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class PedidoService implements IPedidoService {

    @Autowired
    private PedidoRepository pedidoRepo;
    
    @Autowired
    private CarritoService carritoRepo;

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

    @Transactional
    @Override
    public boolean deletePedido(int id) {
        pedidoRepo.deleteProcedurePedido(id);
        return true;
    }
}