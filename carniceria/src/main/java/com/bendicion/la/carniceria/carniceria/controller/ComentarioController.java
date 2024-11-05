/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.controller;

import java.time.LocalDateTime;
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

import com.bendicion.la.carniceria.carniceria.domain.Comentario;
import com.bendicion.la.carniceria.carniceria.service.IComentarioService;

/**
 *
 * @author Dilan Gutierrez
 */
@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/comentario")
public class ComentarioController {

    @Autowired
    IComentarioService iComentarioService;

    @GetMapping("/admin")
    public ResponseEntity<List<Comentario>> listComentariosAdmin() {
        List<Comentario> comentarios = iComentarioService.getComentariosAdmin();
        System.out.println("Listando todos los comentarios: " + comentarios.size() + " comentarios encontrados.");
        return ResponseEntity.ok(comentarios);
    }
    
     @GetMapping("/usuario")
    public ResponseEntity<List<Comentario>> listComentariosUsuario() {
        List<Comentario> comentarios = iComentarioService.getComentariosUsuario();
        System.out.println("Listando todos los comentarios: " + comentarios.size() + " comentarios encontrados.");
        return ResponseEntity.ok(comentarios);
    }

    @PostMapping("/agregar")
public ResponseEntity<?> addComentario(@RequestBody Comentario comentario) {
    try {
        // Agrega la fecha actual al comentario
        comentario.setFechaComentario(LocalDateTime.now());

        // Log para verificar los datos recibidos
        System.out.println("Datos del comentario recibidos: " + comentario);

        Comentario nuevoComentario = iComentarioService.addComentario(comentario);

        if (nuevoComentario != null) {
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Comentario guardado con éxito con ID: " + nuevoComentario.getIdComentario());

            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el comentario"));
        }

    } catch (Exception e) {
        e.printStackTrace();  // Imprimir el error completo
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Collections.singletonMap("error", "Error al agregar el comentario: " + e.getMessage()));
    }
}



    @PutMapping("/actualizar")
    public ResponseEntity<?> updateComentario(@RequestBody Comentario comentario) {
        try {
            Comentario comentarioActualizado = iComentarioService.updateComentario(comentario);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Comentario actualizado con éxito con ID: " + comentarioActualizado.getIdComentario());
            response.put("id", comentarioActualizado.getIdComentario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar el comentario: " + e.getMessage()));
        }
    }

    // Delete
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deleteComentario(@PathVariable int id) {
        boolean eliminado = iComentarioService.deleComentario(id);

        if (eliminado) {
            System.out.println("comentario eliminado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo eliminar el comentario: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }
    
    // Verificar comentarios
    @PutMapping("/verificar/{id}")
    public ResponseEntity<Boolean> verificarComentario(@PathVariable int id) {
        boolean eliminado = iComentarioService.mostrarComentario(id);

        if (eliminado) {
            System.out.println("comentario verificado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo verificar el comentario: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }
}
