/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import com.bendicion.la.carniceria.carniceria.jpa.PedidoRepository;

import jakarta.transaction.Transactional;
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


    @Transactional
    @Override
    public Pedido addPedido(Pedido pedido) {
        // Obtener el ID del carrito del objeto pedido
        Integer idCarrito = pedido.getCarrito().getIdCarrito();
        Integer idTipoPago = pedido.getTipoPago().getIdTipoPago();
        
        // Verificar que el carrito exista antes de usarlo
        Carrito carritos = carritoRepo.obtenerCarritoPorId(idCarrito);
        if (carritos == null ) {
            throw new RuntimeException("El carrito con ID " + idCarrito + " no existe");
        }
        
        // Una vez verificado que el carrito existe, proceder con el pedido
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

        Date fechaPedido = Date.from(pedido.getFechaPedido().atZone(ZoneId.systemDefault()).toInstant());
        pedidoRepo.updateProcedurePedido(pedido.getIdPedido(),pedido.getMontoTotalPedido(), fechaPedido, pedido.isEstadoPedido(), pedido.getEstadoEntregaPedido(), 1, 1);
        return pedido;
    }

    @Override
    @Transactional
    public List<Pedido> getPedido() {
        return pedidoRepo.listaPedido();

        // Mapea cada fila a un mapa de claves y valores
         
    }

    @Transactional
    @Override
    public boolean deletePedido(int id) {
        pedidoRepo.deleteProcedurePedido(id);
        return true;
    }


    @Override
    @Transactional
    public void updateStatePedido(int idPedido, String nuevoEstado) {
        try {
            pedidoRepo.updateStateEntrega(idPedido, nuevoEstado);
        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar estado de entrega: " + e.getMessage());
        }
    }
    
}
