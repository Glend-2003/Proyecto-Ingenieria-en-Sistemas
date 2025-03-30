package com.bendicion.la.carniceria.carniceria.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import com.bendicion.la.carniceria.carniceria.service.IPedidoService;



/**
 *
 * @author Jamel Sandí
 */

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/pedido")
public class PedidoController {

    @Autowired
    private IPedidoService pedidoService;

    @GetMapping("/")
    public ResponseEntity<List<Pedido>> getPedido() {
        List<Pedido> pedidos = pedidoService.getPedido();
        System.out.println("Listando pedidos: " + pedidos.size() + " registros encontrados");
        return ResponseEntity.ok(pedidos);
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addPedido(@RequestBody Pedido pedido) {
        try {
            // Imprimir detalles del pedido recibido para depuración
            System.out.println("Pedido recibido:");
            System.out.println("MontoTotal: " + pedido.getMontoTotalPedido());
            System.out.println("FechaPedido: " + pedido.getFechaPedido());
            System.out.println("Estado: " + pedido.isEstadoPedido());
            System.out.println("EstadoEntrega: " + pedido.getEstadoEntregaPedido());
            
            // Imprimir detalles del carrito
            if (pedido.getCarrito() != null) {
                System.out.println("Carrito ID: " + pedido.getCarrito().getIdCarrito());
                // Si el carrito tiene un usuario asociado, imprimirlo también
                if (pedido.getCarrito().getUsuario() != null) {
                    System.out.println("Usuario ID en carrito: " + pedido.getCarrito().getUsuario().getIdUsuario());
                } else {
                    System.out.println("El carrito no tiene usuario asociado");
                }
            } else {
                System.out.println("¡ATENCIÓN! El carrito es NULL");
            }
            
            // Imprimir detalles del tipo de pago
            if (pedido.getTipoPago() != null) {
                System.out.println("TipoPago ID: " + pedido.getTipoPago().getIdTipoPago());
            } else {
                System.out.println("¡ATENCIÓN! El tipo de pago es NULL");
            }
            
            Pedido pedidoNuevo = pedidoService.addPedido(pedido);
            System.out.println("Pedido agregado: " + pedidoNuevo.getIdPedido());
    
            Map<String, Object> response = new HashMap<>();
            response.put("mensaje", "Pedido agregado con éxito");
            response.put("pedido", pedidoNuevo.getIdPedido());
    
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace(); // Imprimir stack trace para ver el error completo
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error","Error al agregar el pedido: "+ e.getMessage()));
        }
    }

    @PostMapping("/actualizar")
    public ResponseEntity<?> updatePedido(@RequestBody Pedido pedido) {
        try {
            Pedido pedidoActualizado = pedidoService.updatePedido(pedido);
            System.out.println("Pedido actualizado: " + pedidoActualizado.getIdPedido());

            Map<String, Object> response = new HashMap<>();
            response.put("mensaje", "Pedido actualizado con éxito");
            response.put("pedido", pedidoActualizado.getIdPedido());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error","Error al actualizar el pedido: "+ e.getMessage()));
        }
    }

    @PostMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deletePedido(@RequestBody int id) {
        boolean eliminado = pedidoService.deletePedido(id);
        if (eliminado) {
            System.out.println("Pedido eliminado: " + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("Error al eliminar el pedido: " + id + " no encontrado");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    
    
    }




    

    


    
}
