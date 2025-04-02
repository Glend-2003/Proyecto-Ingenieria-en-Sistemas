package com.bendicion.la.carniceria.carniceria.controller;

import java.util.ArrayList;
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
    public List<Map<String, Object>> getAllPedidos() {
        List<Map<String, Object>> pedidosPlanos = pedidoService.getPedido();
        Map<Integer, Map<String, Object>> pedidosPorId = new HashMap<>();
        
        for (Map<String, Object> fila : pedidosPlanos) {
            Integer idPedido = ((Number) fila.get("idPedido")).intValue();
            
            // Si este pedido no ha sido procesado todavía, crea una nueva estructura para él
            if (!pedidosPorId.containsKey(idPedido)) {
                Map<String, Object> pedido = new HashMap<>();
                Map<String, Object> carrito = new HashMap<>();
                Map<String, Object> usuario = new HashMap<>();
                Map<String, Object> tipoPago = new HashMap<>();
                List<Map<String, Object>> productos = new ArrayList<>();
                
                // Datos básicos del pedido
                pedido.put("idPedido", idPedido);
                pedido.put("montoTotalPedido", fila.get("montoTotalPedido"));
                pedido.put("fechaPedido", fila.get("fechaPedido"));
                pedido.put("estadoPedido", fila.get("estadoPedido"));
                pedido.put("estadoPedidoTexto", fila.get("estadoPedidoTexto"));
                pedido.put("estadoEntregaPedido", fila.get("estadoEntregaPedido"));
                
                // Datos del tipo de pago
                tipoPago.put("idTipoPago", fila.get("idTipoPago"));
                tipoPago.put("descripcionTipoPago", fila.get("descripcionTipoPago"));
                tipoPago.put("estadoTipoPago", fila.get("estadoTipoPago"));
                pedido.put("tipoPago", tipoPago);
                
                // Datos del usuario
                usuario.put("idUsuario", fila.get("idUsuario"));
                usuario.put("nombreUsuario", fila.get("nombreUsuario"));
                usuario.put("primerApellido", fila.get("primerApellido"));
                usuario.put("segundoApellido", fila.get("segundoApellido"));
                usuario.put("nombreCompletoUsuario", fila.get("nombreCompletoUsuario"));
                usuario.put("cedulaUsuario", fila.get("cedulaUsuario"));
                usuario.put("correoUsuario", fila.get("correoUsuario"));
                usuario.put("telefonoUsuario", fila.get("telefonoUsuario"));
                usuario.put("fechaNacimiento", fila.get("fechaNacimiento"));
                
                // Datos del carrito
                carrito.put("idCarrito", fila.get("idCarrito"));
                carrito.put("cantidadCarrito", fila.get("cantidadCarrito"));
                carrito.put("montoTotalCarrito", fila.get("montoTotalCarrito"));
                carrito.put("estadoCarrito", fila.get("estadoCarrito"));
                carrito.put("cantidadProductosDistintos", fila.get("cantidadProductosDistintos"));
                carrito.put("cantidadTotalItems", fila.get("cantidadTotalItems"));
                carrito.put("usuario", usuario);
                carrito.put("productos", productos);
                
                pedido.put("carrito", carrito);
                
                pedidosPorId.put(idPedido, pedido);
            }
            
            // Si hay datos de producto en esta fila, añadirlos a la lista de productos
            if (fila.get("idProducto") != null) {
                Map<String, Object> producto = new HashMap<>();
                producto.put("idCarritoProducto", fila.get("idCarritoProducto"));
                producto.put("idProducto", fila.get("idProducto"));
                producto.put("nombreProducto", fila.get("nombreProducto"));
                producto.put("imgProducto", fila.get("imgProducto"));
                producto.put("montoPrecioProducto", fila.get("montoPrecioProducto"));
                producto.put("descripcionProducto", fila.get("descripcionProducto"));
                producto.put("cantidadProducto", fila.get("cantidadProducto"));
                producto.put("stockProducto", fila.get("stockProducto"));
                producto.put("tipoPesoProducto", fila.get("tipoPesoProducto"));
                producto.put("codigoProducto", fila.get("codigoProducto"));
                producto.put("idCategoria", fila.get("idCategoria"));
                producto.put("estadoProducto", fila.get("estadoProducto"));
                
                List<Map<String, Object>> productos = (List<Map<String, Object>>) 
                        ((Map<String, Object>) pedidosPorId.get(idPedido).get("carrito")).get("productos");
                productos.add(producto);
            }
        }
        
        return new ArrayList<>(pedidosPorId.values());
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
