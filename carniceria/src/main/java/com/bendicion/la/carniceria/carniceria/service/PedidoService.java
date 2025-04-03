/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
    public List<Map<String, Object>> getPedido() {
       try {
        List<Map<String, Object>> resultado = pedidoRepo.listaPedido();
        System.out.println("Resultado obtenido: " + resultado);
        return resultado;
    } catch (Exception e) {
        System.err.println("Error al obtener pedidos: " + e.getMessage());
        e.printStackTrace();
        // Devuelve una lista vacía o maneja el error de otra manera
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
    
}
