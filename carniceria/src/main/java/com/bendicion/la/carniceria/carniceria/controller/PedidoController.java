package com.bendicion.la.carniceria.carniceria.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
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
import com.bendicion.la.carniceria.carniceria.service.NotificacionService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/pedido")
public class PedidoController {

    private static final String IMAGE_DIRECTORY = "src/main/resources/static/images";

    @Autowired
    private IPedidoService pedidoService;

    @Autowired
    private NotificacionService notificacionService;

    @GetMapping("/")
    public List<Map<String, Object>> getAllPedidos() {
        List<Map<String, Object>> pedidosPlanos = pedidoService.getPedido();
        Map<Integer, Map<String, Object>> pedidosPorId = new HashMap<>();

        for (Map<String, Object> fila : pedidosPlanos) {
            Integer idPedido = ((Number) fila.get("idPedido")).intValue();

            if (!pedidosPorId.containsKey(idPedido)) {
                Map<String, Object> pedido = new HashMap<>();
                Map<String, Object> carrito = new HashMap<>();
                Map<String, Object> usuario = new HashMap<>();
                Map<String, Object> tipoPago = new HashMap<>();
                List<Map<String, Object>> productos = new ArrayList<>();

                pedido.put("idPedido", idPedido);
                pedido.put("montoTotalPedido", fila.get("montoTotalPedido"));
                pedido.put("fechaPedido", fila.get("fechaPedido"));
                pedido.put("estadoPedido", fila.get("estadoPedido"));
                pedido.put("estadoPedidoTexto", fila.get("estadoPedidoTexto"));
                pedido.put("estadoEntregaPedido", fila.get("estadoEntregaPedido"));

                tipoPago.put("idTipoPago", fila.get("idTipoPago"));
                tipoPago.put("descripcionTipoPago", fila.get("descripcionTipoPago"));
                tipoPago.put("estadoTipoPago", fila.get("estadoTipoPago"));
                pedido.put("tipoPago", tipoPago);

                usuario.put("idUsuario", fila.get("idUsuario"));
                usuario.put("nombreUsuario", fila.get("nombreUsuario"));
                usuario.put("primerApellido", fila.get("primerApellido"));
                usuario.put("segundoApellido", fila.get("segundoApellido"));
                usuario.put("nombreCompletoUsuario", fila.get("nombreCompletoUsuario"));
                usuario.put("cedulaUsuario", fila.get("cedulaUsuario"));
                usuario.put("correoUsuario", fila.get("correoUsuario"));
                usuario.put("telefonoUsuario", fila.get("telefonoUsuario"));
                usuario.put("fechaNacimiento", fila.get("fechaNacimiento"));

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

            if (fila.get("idProducto") != null) {
                Map<String, Object> producto = new HashMap<>();
                producto.put("idCarritoProducto", fila.get("idCarritoProducto"));
                producto.put("idProducto", fila.get("idProducto"));
                producto.put("nombreProducto", fila.get("nombreProducto"));

                String imgProducto = (String) fila.get("imgProducto");
                if (imgProducto != null && !imgProducto.isEmpty()) {

                    if (!imgProducto.startsWith("http")) {
                        producto.put("imgProducto", "http://localhost:8080/producto/images/" + imgProducto);
                    } else {
                        producto.put("imgProducto", imgProducto);
                    }
                } else {
                    producto.put("imgProducto", null);
                }

                producto.put("montoPrecioProducto", fila.get("montoPrecioProducto"));
                producto.put("descripcionProducto", fila.get("descripcionProducto"));
                producto.put("cantidadProducto", fila.get("cantidadProducto"));
                producto.put("stockProducto", fila.get("stockProducto"));
                producto.put("tipoPesoProducto", fila.get("tipoPesoProducto"));
                producto.put("codigoProducto", fila.get("codigoProducto"));
                producto.put("idCategoria", fila.get("idCategoria"));
                producto.put("estadoProducto", fila.get("estadoProducto"));

                List<Map<String, Object>> productos = (List<Map<String, Object>>) ((Map<String, Object>) pedidosPorId.get(idPedido).get("carrito")).get("productos");
                productos.add(producto);
            }
        }
        return new ArrayList<>(pedidosPorId.values());
    }

    @GetMapping("/Entregado")
    public List<Map<String, Object>> getAllPedidosEntregados() {
        List<Map<String, Object>> pedidosPlanos = pedidoService.getPedidoEntregado();
        Map<Integer, Map<String, Object>> pedidosPorId = new HashMap<>();

        for (Map<String, Object> fila : pedidosPlanos) {
            Integer idPedido = ((Number) fila.get("idPedido")).intValue();

            if (!pedidosPorId.containsKey(idPedido)) {
                Map<String, Object> pedido = new HashMap<>();
                Map<String, Object> carrito = new HashMap<>();
                Map<String, Object> usuario = new HashMap<>();
                Map<String, Object> tipoPago = new HashMap<>();
                List<Map<String, Object>> productos = new ArrayList<>();

                pedido.put("idPedido", idPedido);
                pedido.put("montoTotalPedido", fila.get("montoTotalPedido"));
                pedido.put("fechaPedido", fila.get("fechaPedido"));
                pedido.put("estadoPedido", fila.get("estadoPedido"));
                pedido.put("estadoPedidoTexto", fila.get("estadoPedidoTexto"));
                pedido.put("estadoEntregaPedido", fila.get("estadoEntregaPedido"));

                tipoPago.put("idTipoPago", fila.get("idTipoPago"));
                tipoPago.put("descripcionTipoPago", fila.get("descripcionTipoPago"));
                tipoPago.put("estadoTipoPago", fila.get("estadoTipoPago"));
                pedido.put("tipoPago", tipoPago);

                usuario.put("idUsuario", fila.get("idUsuario"));
                usuario.put("nombreUsuario", fila.get("nombreUsuario"));
                usuario.put("primerApellido", fila.get("primerApellido"));
                usuario.put("segundoApellido", fila.get("segundoApellido"));
                usuario.put("nombreCompletoUsuario", fila.get("nombreCompletoUsuario"));
                usuario.put("cedulaUsuario", fila.get("cedulaUsuario"));
                usuario.put("correoUsuario", fila.get("correoUsuario"));
                usuario.put("telefonoUsuario", fila.get("telefonoUsuario"));
                usuario.put("fechaNacimiento", fila.get("fechaNacimiento"));

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

            if (fila.get("idProducto") != null) {
                Map<String, Object> producto = new HashMap<>();
                producto.put("idCarritoProducto", fila.get("idCarritoProducto"));
                producto.put("idProducto", fila.get("idProducto"));
                producto.put("nombreProducto", fila.get("nombreProducto"));

                String imgProducto = (String) fila.get("imgProducto");
                if (imgProducto != null && !imgProducto.isEmpty()) {

                    if (!imgProducto.startsWith("http")) {
                        producto.put("imgProducto", "http://localhost:8080/producto/images/" + imgProducto);
                    } else {
                        producto.put("imgProducto", imgProducto);
                    }
                } else {
                    producto.put("imgProducto", null);
                }

                producto.put("montoPrecioProducto", fila.get("montoPrecioProducto"));
                producto.put("descripcionProducto", fila.get("descripcionProducto"));
                producto.put("cantidadProducto", fila.get("cantidadProducto"));
                producto.put("stockProducto", fila.get("stockProducto"));
                producto.put("tipoPesoProducto", fila.get("tipoPesoProducto"));
                producto.put("codigoProducto", fila.get("codigoProducto"));
                producto.put("idCategoria", fila.get("idCategoria"));
                producto.put("estadoProducto", fila.get("estadoProducto"));

                List<Map<String, Object>> productos = (List<Map<String, Object>>) ((Map<String, Object>) pedidosPorId.get(idPedido).get("carrito")).get("productos");
                productos.add(producto);
            }
        }
        return new ArrayList<>(pedidosPorId.values());
    }

    @GetMapping("/usuario/{id}")
    public ResponseEntity<List<Map<String, Object>>> getPedidosByUsuario(@PathVariable int id) {
        List<Map<String, Object>> pedidosPlanos = pedidoService.getPedidoByUsuario(id);
        if (pedidosPlanos.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Collections.emptyList());
        } else {
            Map<Integer, Map<String, Object>> pedidosPorId = new HashMap<>();

            for (Map<String, Object> fila : pedidosPlanos) {
                Integer idPedido = ((Number) fila.get("idPedido")).intValue();

                if (!pedidosPorId.containsKey(idPedido)) {
                    Map<String, Object> pedido = new HashMap<>();
                    Map<String, Object> carrito = new HashMap<>();
                    Map<String, Object> usuario = new HashMap<>();
                    Map<String, Object> tipoPago = new HashMap<>();
                    List<Map<String, Object>> productos = new ArrayList<>();

                    pedido.put("idPedido", idPedido);
                    pedido.put("montoTotalPedido", fila.get("montoTotalPedido"));
                    pedido.put("fechaPedido", fila.get("fechaPedido"));
                    pedido.put("estadoPedido", fila.get("estadoPedido"));
                    pedido.put("estadoPedidoTexto", fila.get("estadoPedidoTexto"));
                    pedido.put("estadoEntregaPedido", fila.get("estadoEntregaPedido"));

                    tipoPago.put("idTipoPago", fila.get("idTipoPago"));
                    tipoPago.put("descripcionTipoPago", fila.get("descripcionTipoPago"));
                    tipoPago.put("estadoTipoPago", fila.get("estadoTipoPago"));
                    pedido.put("tipoPago", tipoPago);

                    usuario.put("idUsuario", fila.get("idUsuario"));
                    usuario.put("nombreUsuario", fila.get("nombreUsuario"));
                    usuario.put("primerApellido", fila.get("primerApellido"));
                    usuario.put("segundoApellido", fila.get("segundoApellido"));
                    usuario.put("nombreCompletoUsuario", fila.get("nombreCompletoUsuario"));
                    usuario.put("cedulaUsuario", fila.get("cedulaUsuario"));
                    usuario.put("correoUsuario", fila.get("correoUsuario"));
                    usuario.put("telefonoUsuario", fila.get("telefonoUsuario"));
                    usuario.put("fechaNacimiento", fila.get("fechaNacimiento"));

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

                if (fila.get("idProducto") != null) {
                    Map<String, Object> producto = new HashMap<>();
                    producto.put("idCarritoProducto", fila.get("idCarritoProducto"));
                    producto.put("idProducto", fila.get("idProducto"));
                    producto.put("nombreProducto", fila.get("nombreProducto"));

                    String imgProducto = (String) fila.get("imgProducto");
                    if (imgProducto != null && !imgProducto.isEmpty()) {

                        if (!imgProducto.startsWith("http")) {
                            producto.put("imgProducto", "http://localhost:8080/producto/images/" + imgProducto);
                        } else {
                            producto.put("imgProducto", imgProducto);
                        }
                    } else {
                        producto.put("imgProducto", null);
                    }

                    producto.put("montoPrecioProducto", fila.get("montoPrecioProducto"));
                    producto.put("descripcionProducto", fila.get("descripcionProducto"));
                    producto.put("cantidadProducto", fila.get("cantidadProducto"));
                    producto.put("stockProducto", fila.get("stockProducto"));
                    producto.put("tipoPesoProducto", fila.get("tipoPesoProducto"));
                    producto.put("codigoProducto", fila.get("codigoProducto"));
                    producto.put("idCategoria", fila.get("idCategoria"));
                    producto.put("estadoProducto", fila.get("estadoProducto"));

                    List<Map<String, Object>> productos = (List<Map<String, Object>>) ((Map<String, Object>) pedidosPorId.get(idPedido).get("carrito")).get("productos");
                    productos.add(producto);
                }
            }
            return ResponseEntity.ok(new ArrayList<>(pedidosPorId.values()));
        }
    }

    @GetMapping("/images/{imageName}")
    public ResponseEntity<byte[]> getImage(@PathVariable String imageName) {
        try {
            Path filePath = Paths.get(IMAGE_DIRECTORY, imageName);
            System.out.println("Buscando imagen en: " + filePath.toString());
            byte[] image = Files.readAllBytes(filePath);

            String contentType = Files.probeContentType(filePath);

            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(image);
        } catch (IOException e) {
            System.err.println("Error al encontrar la imagen: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @GetMapping("/filtrar")
    public ResponseEntity<List<Map<String, Object>>> filtrarPedidos(
            @RequestParam int idUsuario,
            @RequestParam(required = false) String estadoEntrega,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") java.util.Date fechaInicio,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") java.util.Date fechaFin,
            @RequestParam(required = false) Integer estadoPedido
    ) {
        System.out.println("Filtro - idUsuario: " + idUsuario);
        System.out.println("Filtro - estadoEntrega: " + estadoEntrega);
        System.out.println("Filtro - fechaInicio: " + fechaInicio);
        System.out.println("Filtro - fechaFin: " + fechaFin);
        System.out.println("Filtro - estadoPedido: " + estadoPedido);

        try {
            List<Map<String, Object>> pedidosPlanos = pedidoService.filtrarPedidos(
                    idUsuario, estadoEntrega, fechaInicio, fechaFin, estadoPedido
            );

            if (pedidosPlanos.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Collections.emptyList());
            } else {

                Map<Integer, Map<String, Object>> pedidosPorId = new HashMap<>();

                for (Map<String, Object> fila : pedidosPlanos) {
                    Integer idPedido = ((Number) fila.get("idPedido")).intValue();

                    if (!pedidosPorId.containsKey(idPedido)) {
                        Map<String, Object> pedido = new HashMap<>();
                        Map<String, Object> carrito = new HashMap<>();
                        Map<String, Object> usuario = new HashMap<>();
                        Map<String, Object> tipoPago = new HashMap<>();
                        List<Map<String, Object>> productos = new ArrayList<>();

                        pedido.put("idPedido", idPedido);
                        pedido.put("montoTotalPedido", fila.get("montoTotalPedido"));
                        pedido.put("fechaPedido", fila.get("fechaPedido"));
                        pedido.put("estadoPedido", fila.get("estadoPedido"));
                        pedido.put("estadoPedidoTexto", fila.get("estadoPedidoTexto"));
                        pedido.put("estadoEntregaPedido", fila.get("estadoEntregaPedido"));

                        tipoPago.put("idTipoPago", fila.get("idTipoPago"));
                        tipoPago.put("descripcionTipoPago", fila.get("descripcionTipoPago"));
                        tipoPago.put("estadoTipoPago", fila.get("estadoTipoPago"));
                        pedido.put("tipoPago", tipoPago);

                        usuario.put("idUsuario", fila.get("idUsuario"));
                        usuario.put("nombreUsuario", fila.get("nombreUsuario"));
                        usuario.put("primerApellido", fila.get("primerApellido"));
                        usuario.put("segundoApellido", fila.get("segundoApellido"));
                        usuario.put("nombreCompletoUsuario", fila.get("nombreCompletoUsuario"));
                        usuario.put("cedulaUsuario", fila.get("cedulaUsuario"));
                        usuario.put("correoUsuario", fila.get("correoUsuario"));
                        usuario.put("telefonoUsuario", fila.get("telefonoUsuario"));
                        usuario.put("fechaNacimiento", fila.get("fechaNacimiento"));

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

                    if (fila.get("idProducto") != null) {
                        Map<String, Object> producto = new HashMap<>();
                        producto.put("idCarritoProducto", fila.get("idCarritoProducto"));
                        producto.put("idProducto", fila.get("idProducto"));
                        producto.put("nombreProducto", fila.get("nombreProducto"));

                        String imgProducto = (String) fila.get("imgProducto");
                        if (imgProducto != null && !imgProducto.isEmpty()) {
                            if (!imgProducto.startsWith("http")) {
                                producto.put("imgProducto", "http://localhost:8080/producto/images/" + imgProducto);
                            } else {
                                producto.put("imgProducto", imgProducto);
                            }
                        } else {
                            producto.put("imgProducto", null);
                        }

                        producto.put("montoPrecioProducto", fila.get("montoPrecioProducto"));
                        producto.put("descripcionProducto", fila.get("descripcionProducto"));
                        producto.put("cantidadProducto", fila.get("cantidadProducto"));
                        producto.put("stockProducto", fila.get("stockProducto"));
                        producto.put("tipoPesoProducto", fila.get("tipoPesoProducto"));
                        producto.put("codigoProducto", fila.get("codigoProducto"));
                        producto.put("idCategoria", fila.get("idCategoria"));
                        producto.put("estadoProducto", fila.get("estadoProducto"));

                        List<Map<String, Object>> productos = (List<Map<String, Object>>) ((Map<String, Object>) pedidosPorId.get(idPedido).get("carrito")).get("productos");
                        productos.add(producto);
                    }
                }
                return ResponseEntity.ok(new ArrayList<>(pedidosPorId.values()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error al filtrar pedidos: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addPedido(@RequestBody Pedido pedido) {
        try {
            Pedido pedidoNuevo = pedidoService.addPedido(pedido);

            Map<String, Object> response = new HashMap<>();
            response.put("mensaje", "Pedido agregado con éxito");
            response.put("pedido", pedidoNuevo.getIdPedido());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el pedido: " + e.getMessage()));
        }
    }

    @PostMapping("/actualizar")
    public ResponseEntity<?> updatePedido(@RequestBody Pedido pedido) {
        try {
            Pedido pedidoActualizado = pedidoService.updatePedido(pedido);

            Map<String, Object> response = new HashMap<>();
            response.put("mensaje", "Pedido actualizado con éxito");
            response.put("pedido", pedidoActualizado.getIdPedido());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar el pedido: " + e.getMessage()));
        }
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deletePedido(@PathVariable int id) {
        boolean eliminado = pedidoService.deletePedido(id);
        if (eliminado) {
            return ResponseEntity.ok(true);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

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
            @RequestParam String correoCliente,
            @RequestParam String nuevoEstado) {

        try {
            pedidoService.updateStateEntregaPedido(idPedido, nuevoEstado);
            pedidoService.sendMail(correoCliente, nuevoEstado);
            return ResponseEntity.ok().body(
                    Collections.singletonMap("mensaje", "Estado de entrega actualizado correctamente")
            );
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(
                    Collections.singletonMap("error", e.getMessage())
            );
        }
    }

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
