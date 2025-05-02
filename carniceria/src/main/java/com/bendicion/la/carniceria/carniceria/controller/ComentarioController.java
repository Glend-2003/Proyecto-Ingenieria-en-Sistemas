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
            // Obtener los comentarios verificados
            List<Comentario> comentarios = iComentarioService.getComentariosUsuario();
            System.out.println("Listando todos los comentarios: " + comentarios.size() + " comentarios encontrados.");
            
            // Lista para almacenar los comentarios enriquecidos con datos de usuario
            List<Map<String, Object>> comentariosConUsuario = new ArrayList<>();
            
            // Iterar sobre cada comentario para obtener datos completos del usuario
            for (Comentario comentario : comentarios) {
                Map<String, Object> comentarioMap = new HashMap<>();
                comentarioMap.put("idComentario", comentario.getIdComentario());
                comentarioMap.put("descripcionComentario", comentario.getDescripcionComentario());
                comentarioMap.put("fechaComentario", comentario.getFechaComentario());
                comentarioMap.put("numCalificacion", comentario.getNumCalificacion());
                comentarioMap.put("verificacion", comentario.getVerificacion());
                
                // Verificar si el comentario tiene usuario asociado
                if (comentario.getUsuario() != null) {
                    try {
                        // Obtener el ID del usuario
                        int idUsuario = comentario.getUsuario().getIdUsuario();
                        
                        // Obtener datos completos del usuario
                        Usuario usuarioCompleto = iUsuarioService.getUsuarioById(idUsuario);
                        
                        if (usuarioCompleto != null) {
                            // Crear un Map con los datos del usuario para no exponer datos sensibles
                            Map<String, Object> usuarioMap = new HashMap<>();
                            usuarioMap.put("idUsuario", usuarioCompleto.getIdUsuario());
                            usuarioMap.put("nombre", usuarioCompleto.getNombreUsuario());
                            usuarioMap.put("correo", usuarioCompleto.getCorreoUsuario());
                            // Agregar otros campos necesarios pero evitar datos sensibles como contraseña
                            
                            // Agregar el usuario completo al comentario
                            comentarioMap.put("usuario", usuarioMap);
                            
                            // Agregar datos del usuario directamente al comentario para facilitar
                            // su uso en el frontend
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
                
                // Agregar el comentario enriquecido a la lista
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
            // Validaciones simplificadas para evitar errores
            if (comentario == null) {
                System.out.println("Error: El comentario es nulo");
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "Error al procesar el comentario");
                return ResponseEntity.badRequest().body(errorResponse);
            }
            
            // Agrega la fecha actual al comentario
            comentario.setFechaComentario(LocalDateTime.now());
            
            System.out.println("Comentario recibido: " + comentario);
            System.out.println("Usuario asociado: " + (comentario.getUsuario() != null ? comentario.getUsuario().getIdUsuario() : "Usuario es null"));
            
            // Log para verificar los datos recibidos
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
            e.printStackTrace();  // Imprimir el error completo
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Error al agregar el comentario: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    
    // Método para actualizar Comentario
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateComentario(@RequestBody Comentario comentario) {
        try {
            // Validación mínima sin getters para evitar NullPointerException
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
