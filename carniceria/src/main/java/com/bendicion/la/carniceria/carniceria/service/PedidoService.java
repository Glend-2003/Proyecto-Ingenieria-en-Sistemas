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
        try {
            // Convertir LocalDateTime a Date 
            Date fecha = java.sql.Timestamp.valueOf(pedido.getFechaPedido());
            
            // Convertir boolean a int
            Integer estadoInt = pedido.isEstadoPedido() ? 1 : 0;
            
            // LOGS DE DEPURACIÓN
            System.out.println("Valores a pasar al SP:");
System.out.println("idPedido: " + pedido.getIdPedido());
System.out.println("montoTotalPedido: " + pedido.getMontoTotalPedido());
System.out.println("fechaPedido: " + fecha);
System.out.println("estadoPedido: " + estadoInt);
System.out.println("estadoEntregaPedido: " + pedido.getEstadoEntregaPedido());
System.out.println("idCarrito: " + pedido.getCarrito().getIdCarrito());
System.out.println("idTipoPago: " + pedido.getTipoPago().getIdTipoPago());
            
            // Llamar al SP
            pedidoRepo.updateProcedurePedido(
                pedido.getIdPedido(),
                pedido.getMontoTotalPedido(), 
                fecha, 
                estadoInt, 
                pedido.getEstadoEntregaPedido(), 
                pedido.getCarrito().getIdCarrito(),
                pedido.getTipoPago().getIdTipoPago()
            );
            
            System.out.println("Pedido actualizado exitosamente: {}"+ pedido.getIdPedido());
            
            return pedido;
        } catch (Exception e) {
            System.out.println("Error al actualizar pedido: {}" + e.getMessage() + e);
            throw new RuntimeException("Error al actualizar pedido: " + e.getMessage(), e);
        }
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

    @Transactional
    @Override
    public boolean deletePedido(int id) {
        pedidoRepo.deleteProcedurePedido(id);
        return true;
    }


    

    
}
