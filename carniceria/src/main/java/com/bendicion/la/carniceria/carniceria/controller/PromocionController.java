package com.bendicion.la.carniceria.carniceria.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

import com.bendicion.la.carniceria.carniceria.domain.Producto;
import com.bendicion.la.carniceria.carniceria.domain.Promocion;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.service.IProductoService;
import com.bendicion.la.carniceria.carniceria.service.IPromocionService;
import com.bendicion.la.carniceria.carniceria.service.IUsuarioService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/promocion")
public class PromocionController {

    @Autowired
    IPromocionService promocionService;

    @Autowired
    IUsuarioService iUsuarioService;

    @Autowired
    IProductoService iProductoService;

    @GetMapping("/")
    public ResponseEntity<List<Map<String, Object>>> listaPromociones() {
        List<Map<String, Object>> promociones = promocionService.getPromociones();
        System.out.println("Listando todas las promociones: " + promociones.size() + " promociones encontradas.");
        return ResponseEntity.ok(promociones);

    }

    @PostMapping("/agregarPromocion")
    public ResponseEntity<?> addPromocion(@RequestBody Promocion promocion) {
        try {

            System.out.println("Promocion recibida: " + promocion);
            System.out.println("Producto asociado: " + (promocion.getProducto() != null ? promocion.getProducto().getIdProducto() : "Producto es null"));

            System.out.println("Datos de la promocion recibidos: " + promocion);

            Promocion nuevaPromocion = promocionService.addPromocion(promocion);

            List<Usuario> usuarios = iUsuarioService.getUsuario();

            Producto producto = iProductoService.buscarUsuario(promocion.getProducto().getIdProducto());

            if (nuevaPromocion != null) {
                Map<String, Object> response = new HashMap<>();
                response.put("message", "Promocion guardada con éxito con ID: " + nuevaPromocion.getIdPromocion());

                return ResponseEntity.ok(response);
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(Collections.singletonMap("error", "Error al agregar el comentario"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el comentario: " + e.getMessage()));
        }
    }

    @PutMapping(value = "/actualizar")
    public ResponseEntity<?> updatePromocion(@RequestBody Promocion promocion) {

        try {

            System.out.println("Promocion recibida: " + promocion);
            System.out.println("Producto asociado: " + (promocion.getProducto() != null ? promocion.getProducto().getIdProducto() : "Producto es null"));

            System.out.println("Datos de la promocion recibidos: " + promocion);

            Promocion promocionActualizada = promocionService.updatePromocion(promocion);

            if (promocionActualizada != null) {
                Map<String, Object> response = new HashMap<>();
                response.put("message", "Promocion Actualizada con éxito con ID: " + promocionActualizada.getIdPromocion());

                return ResponseEntity.ok(response);
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(Collections.singletonMap("error", "Error al actualizar la promocion"));
            }

        } catch (Exception e) {
            e.printStackTrace();  // Imprimir el error completo
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar la promocion: " + e.getMessage()));
        }
    }

    // Delete
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deletePromocion(@PathVariable int id) {
        boolean eliminado = promocionService.deletePromocion(id);

        if (eliminado) {
            System.out.println("Promocion eliminada: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo eliminar la Promocion: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

    @PostMapping("/mensaje")
    public ResponseEntity<?> mensaje(@RequestBody Promocion promocion, @RequestParam String nombreProducto) {
        try {
            List<Usuario> usuarios = iUsuarioService.getUsuario();

            for (Usuario usuario : usuarios) {
                String mensaje = promocionService.mensajePredeterminado(
                        usuario.getNombreUsuario(),
                        nombreProducto,
                        promocion.getFechaInicioPromocion(),
                        promocion.getFechaFinPromocion(),
                        promocion.getMontoPromocion()
                );
                promocionService.enviarMensaje(
                        usuario.getCorreoUsuario(),
                        "Nueva Promoción: " + promocion.getDescripcionPromocion(),
                        mensaje
                );
            }

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Correos enviados correctamente");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al enviar los correos: " + e.getMessage()));
        }
    }

    @PutMapping("/activar/{id}")
    public ResponseEntity<Boolean> activarPromocion(@PathVariable int id) {
        boolean estado = promocionService.activarPromocion(id);

        if (estado) {
            System.out.println("Estado de la promocion modificado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo modificar el estado de la promocion: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }
}
