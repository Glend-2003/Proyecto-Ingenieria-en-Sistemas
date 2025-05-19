package com.bendicion.la.carniceria.carniceria.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
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
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.service.IComentarioService;
import com.bendicion.la.carniceria.carniceria.service.IUsuarioService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/comentario")
public class ComentarioController {

    @Autowired
    IComentarioService iComentarioService;
    @Autowired
    IUsuarioService iUsuarioService;

    @GetMapping("/admin")
    public ResponseEntity<List<Map<String, Object>>> listComentariosAdmin() {
        List<Map<String, Object>> comentarios = iComentarioService.getComentariosAdmin();
        System.out.println("Listando todos los comentarios: " + comentarios.size() + " comentarios encontrados.");
        return ResponseEntity.ok(comentarios);
    }

    @GetMapping("/usuario")
    public ResponseEntity<List<Map<String, Object>>> listComentariosUsuario() {
        try {

            List<Comentario> comentarios = iComentarioService.getComentariosUsuario();
            System.out.println("Listando todos los comentarios: " + comentarios.size() + " comentarios encontrados.");

            List<Map<String, Object>> comentariosConUsuario = new ArrayList<>();

            for (Comentario comentario : comentarios) {
                Map<String, Object> comentarioMap = new HashMap<>();
                comentarioMap.put("idComentario", comentario.getIdComentario());
                comentarioMap.put("descripcionComentario", comentario.getDescripcionComentario());
                comentarioMap.put("fechaComentario", comentario.getFechaComentario());
                comentarioMap.put("numCalificacion", comentario.getNumCalificacion());
                comentarioMap.put("verificacion", comentario.getVerificacion());

                if (comentario.getUsuario() != null) {
                    try {

                        int idUsuario = comentario.getUsuario().getIdUsuario();

                        Usuario usuarioCompleto = iUsuarioService.getUsuarioById(idUsuario);

                        if (usuarioCompleto != null) {

                            Map<String, Object> usuarioMap = new HashMap<>();
                            usuarioMap.put("idUsuario", usuarioCompleto.getIdUsuario());
                            usuarioMap.put("nombre", usuarioCompleto.getNombreUsuario());
                            usuarioMap.put("correo", usuarioCompleto.getCorreoUsuario());

                            comentarioMap.put("usuario", usuarioMap);

                            comentarioMap.put("nombre", usuarioCompleto.getNombreUsuario());
                            comentarioMap.put("email", usuarioCompleto.getCorreoUsuario());
                        } else {
                            System.out.println("No se encontró el usuario con ID: " + idUsuario);
                            comentarioMap.put("usuario", null);
                            comentarioMap.put("nombre", "Usuario Anónimo");
                            comentarioMap.put("email", "");
                        }
                    } catch (Exception e) {
                        System.out.println("Error al obtener el usuario: " + e.getMessage());
                        comentarioMap.put("usuario", null);
                        comentarioMap.put("nombre", "Usuario Anónimo");
                        comentarioMap.put("email", "");
                    }
                } else {
                    comentarioMap.put("usuario", null);
                    comentarioMap.put("nombre", "Usuario Anónimo");
                    comentarioMap.put("email", "");
                }

                comentariosConUsuario.add(comentarioMap);
            }

            return ResponseEntity.ok(comentariosConUsuario);
        } catch (Exception e) {
            System.out.println("Error al listar comentarios: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.emptyList());
        }
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addComentario(@RequestBody Comentario comentario) {
        try {

            if (comentario == null) {
                System.out.println("Error: El comentario es nulo");
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "Error al procesar el comentario");
                return ResponseEntity.badRequest().body(errorResponse);
            }

            comentario.setFechaComentario(LocalDateTime.now());

            System.out.println("Comentario recibido: " + comentario);
            System.out.println("Usuario asociado: " + (comentario.getUsuario() != null ? comentario.getUsuario().getIdUsuario() : "Usuario es null"));

            System.out.println("Datos del comentario recibidos: " + comentario);

            Comentario nuevoComentario = iComentarioService.addComentario(comentario);
            if (nuevoComentario != null) {
                Map<String, String> response = new HashMap<>();
                response.put("message", "Comentario guardado con éxito con ID: " + nuevoComentario.getIdComentario());
                return ResponseEntity.ok(response);
            } else {
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "Error al agregar el comentario");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Error al agregar el comentario: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @PutMapping("/actualizar")
    public ResponseEntity<?> updateComentario(@RequestBody Comentario comentario) {
        try {

            if (comentario == null) {
                System.out.println("Error: El comentario es nulo");
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "Error al procesar el comentario");
                return ResponseEntity.badRequest().body(errorResponse);
            }

            Comentario comentarioActualizado = iComentarioService.updateComentario(comentario);

            if (comentarioActualizado != null) {
                Map<String, Object> response = new HashMap<>();
                response.put("message", "Comentario actualizado con éxito con ID: " + comentarioActualizado.getIdComentario());
                response.put("id", comentarioActualizado.getIdComentario());
                return ResponseEntity.ok(response);
            } else {
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "No se pudo actualizar el comentario");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
            }
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Error al actualizar el comentario: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // Delete
    @DeleteMapping("/activar/{id}")
    public ResponseEntity<Boolean> activarComentario(@PathVariable int id) {
        boolean eliminado = iComentarioService.activarComentario(id);

        if (eliminado) {
            System.out.println("comentario eliminado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo eliminar el comentario: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

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
