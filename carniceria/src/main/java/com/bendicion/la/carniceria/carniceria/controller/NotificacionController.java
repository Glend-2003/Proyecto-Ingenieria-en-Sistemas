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
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.domain.Notificacion;
import com.bendicion.la.carniceria.carniceria.service.INotificacionService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/notificacion")
public class NotificacionController {

    @Autowired
    INotificacionService notificacionService;

    @GetMapping("/")
    public ResponseEntity<List<Notificacion>> listNotificacion(Boolean leidos) {
        List<Notificacion> notificacion = notificacionService.getNotificacion(leidos);
        System.out.println("Listando todas las notificaciones: " + notificacion.size() + " categorias encontradas.");
        return ResponseEntity.ok(notificacionService.getNotificacion(leidos));
    }

    @PutMapping("/leer/{id}")
    public ResponseEntity<Boolean> leerNotificacion(@PathVariable int id) {
        boolean estado = notificacionService.leerNotificacion(id);

        if (estado) {
            System.out.println("Estado de notificacion modificado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo modificar el estado de la notificacion: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deleteCNotificacion(@PathVariable int id) {
        boolean eliminado = notificacionService.deleteNotificacion(id);

        if (eliminado) {
            System.out.println("Notificacion eliminada: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo eliminar la notificacion: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addNotificacion(@RequestBody Notificacion notificacion) {
        try {
            Notificacion nuevaNotificacion = notificacionService.addNotificacion(notificacion);

            Map<String, Object> response = new HashMap<>();
            response.put("id", nuevaNotificacion.getIdNotificacion());
            response.put("mensaje", "Notificación creada correctamente.");

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar la notificación: " + e.getMessage()));
        }
    }

}
