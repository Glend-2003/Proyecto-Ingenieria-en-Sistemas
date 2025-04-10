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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import com.bendicion.la.carniceria.carniceria.service.IPedidoService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "Error al agregar el pedido: " + e.getMessage()));
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
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "Error al actualizar el pedido: " + e.getMessage()));
        }
    }
    
     // Este elimina del todo, por medio de una cascada, lo que hace a eliminarlo d etodas las tablas
    
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
    
    // Este lo que hace es cambiar el estado del pedido, y ocultar los que tienen estado 1, pasan a 0 los ocultos
    
    @PostMapping("/ocultar/{id}")
    public ResponseEntity<Boolean> updateStatePedido(@RequestBody int id) {
        boolean oculto = pedidoService.updateStatePedido(id);
        if (oculto) {
            System.out.println("Pedido oculto: " + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("Error al ocultar el pedido: " + id + " no encontrado");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }

    }

    @PutMapping("/actualizarEstadoPedido/{idPedido}")
    public ResponseEntity<?> updateStateEntregaPedido(
            @PathVariable int idPedido,
            @RequestParam String estado) {

        try {
            pedidoService.updateStateEntregaPedido(idPedido, estado);
            return ResponseEntity.ok().body(
                    Collections.singletonMap("mensaje", "Estado de entrega actualizado correctamente")
            );
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(
                    Collections.singletonMap("error", e.getMessage())
            );
        }
    }
    
    // Lleva el control de ventas
    @GetMapping("/reporteVentas")
    public ResponseEntity<?> getReporteVentas() {
        try {
            Map<String, Map<String, Object>> reporte = pedidoService.getReporteVentasCompleto();
            System.out.println("Reporte de ventas generado: " + reporte);
            return ResponseEntity.ok(reporte);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al generar el reporte: " + e.getMessage()));
        }
    }

}
