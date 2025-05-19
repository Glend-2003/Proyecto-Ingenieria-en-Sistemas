package com.bendicion.la.carniceria.carniceria.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.domain.CarritoProducto;
import com.bendicion.la.carniceria.carniceria.service.ICarritoProductoService;
import com.bendicion.la.carniceria.carniceria.service.ICarritoService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/carrito")
public class CarritoController {

    @Autowired
    private ICarritoService carritoService;

    @Autowired
    private ICarritoProductoService carritoProductoService;

    @PostMapping
    public ResponseEntity<Carrito> crearCarrito(@RequestBody Carrito carrito) {
        Carrito nuevoCarrito = carritoService.addCarrito(carrito);
        return ResponseEntity.ok(nuevoCarrito);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Carrito> actualizarCarrito(@PathVariable int id, @RequestBody Carrito carrito) {
        carrito.setIdCarrito(id);
        Carrito carritoActualizado = carritoService.updateCarrito(carrito);
        return ResponseEntity.ok(carritoActualizado);
    }

    @GetMapping
    public ResponseEntity<List<Carrito>> listarCarritos(@RequestParam boolean estado) {
        return ResponseEntity.ok(carritoService.getCarrito(estado));
    }

    @GetMapping("/usuario/{idUsuario}")
    public ResponseEntity<Map<String, List<Object[]>>> obtenerCarritosUsuario(@PathVariable Integer idUsuario) {
        Map<String, List<Object[]>> resultado = carritoService.obtenerCarritosUsuario(idUsuario);
        return ResponseEntity.ok(resultado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarCarrito(@PathVariable int id) {
        carritoService.deleteCarrito(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{idCarrito}/productos")
    public ResponseEntity<CarritoProducto> agregarProducto(
            @PathVariable int idCarrito,
            @RequestBody CarritoProducto producto) {

        Carrito carrito = new Carrito();
        carrito.setIdCarrito(idCarrito);
        producto.setCarrito(carrito);

        CarritoProducto nuevoProducto = carritoProductoService.addProductoAlCarrito(producto);
        CarritoProducto actualizarStock = carritoProductoService.updateStock(producto);
        return ResponseEntity.ok(nuevoProducto);
    }

}
