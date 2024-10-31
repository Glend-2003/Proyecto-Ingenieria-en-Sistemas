package com.bendicion.la.carniceria.carniceria.controller;

import com.bendicion.la.carniceria.carniceria.domain.Producto;
import com.bendicion.la.carniceria.carniceria.service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Jamel Sandí
 */

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/producto")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    // Obtener lista de productos
    @GetMapping("/")
    public ResponseEntity<List<Producto>> listProductos() {
        List<Producto> productos = productoService.getProducto();
        return ResponseEntity.ok(productos);
    }

    // Agregar producto
    @PostMapping("/agregar")
    public ResponseEntity<?> addProducto(@RequestBody Producto producto) {
        try {
            Producto nuevoProducto = productoService.addProducto(producto);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Producto agregado con éxito con ID: " + nuevoProducto.getIdProducto());
            response.put("id", nuevoProducto.getIdProducto());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el producto: " + e.getMessage()));
        }
    }

    // Actualizar producto
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateProducto(@RequestBody Producto producto) {
        try {
            Producto productoActualizado = productoService.updateProducto(producto);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Producto actualizado con éxito con ID: " + productoActualizado.getIdProducto());
            response.put("id", productoActualizado.getIdProducto());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar el producto: " + e.getMessage()));
        }
    }

    // Eliminar producto
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deleteProducto(@PathVariable int id) {
        boolean eliminado = productoService.deleteProducto(id);
        if (eliminado) {
            return ResponseEntity.ok(true);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }
}
