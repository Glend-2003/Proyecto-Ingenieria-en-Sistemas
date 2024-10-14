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

import com.bendicion.la.carniceria.carniceria.Logic.JwtService;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.service.IUsuarioService;

import jakarta.servlet.http.HttpServletRequest;

/**
 *
 * @author Jamel Sandí
 */

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/usuario")
public class UsuarioController {

    @Autowired
    IUsuarioService iUsuarioService;
    
    @Autowired
    private JwtService jwtService;  // Asegúrate de tener este Autowired

    // Read
    // Lee todos los usuarios existentes, trayendo hasta la dirección (Para vista Admin)
    @GetMapping("/")
    public ResponseEntity<List<Usuario>> listUsuarios() {
        List<Usuario> usuarios = iUsuarioService.getUsuario();
        System.out.println("Listando todos los usuarios: " + usuarios.size() + " usuarios encontrados.");
        return ResponseEntity.ok(usuarios);
    }

// -----------------------------------------------------------------------------    
    
    // Add
    // Agregar usuarios en vista Admin
    @PostMapping("/agregar")
    public ResponseEntity<?> addUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario nuevoUsuario = iUsuarioService.addUsuario(usuario);
            System.out.println("Usuario agregado: ID -->" + usuario.getIdUsuario() + ", Nombre -->" + usuario.getNombreUsuario() + ", Apellidos -->" + usuario.getPrimerApellido() + " " + usuario.getSegundoApellido());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Usuario guardado con exito con ID: " + nuevoUsuario.getIdUsuario());
            response.put("id", nuevoUsuario.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el usuario: " + e.getMessage()));
        }
    }

// -----------------------------------------------------------------------------
    
    // Registrarse como nuevo usuario
    @PostMapping("/registrar")
    public ResponseEntity<?> registerUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario nuevoResgistroUsuario = iUsuarioService.registerUsuario(usuario);
            System.out.println("Usuario registrado: ID -->" + usuario.getIdUsuario() + ", Correo -->" + usuario.getCorreoUsuario());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Usuario guardado con exito con ID: " + nuevoResgistroUsuario.getIdUsuario());
            response.put("id", nuevoResgistroUsuario.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el usuario: " + e.getMessage()));
        }
    }
    
// -----------------------------------------------------------------------------    
    
    // Update
    // Actualizar usuarios 
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario usuarioActualizado = iUsuarioService.updateUsuario(usuario);
            System.out.println("Usuario actualizado: ID -->" + usuario.getIdUsuario() + ", Nombre -->" + usuario.getNombreUsuario() + ", Apellidos -->" + usuario.getPrimerApellido() + " " + usuario.getSegundoApellido());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Usuario actualizado con exito con ID: " + usuarioActualizado.getIdUsuario());
            response.put("id", usuarioActualizado.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar el usuario: " + e.getMessage()));
        }
    }
    
// -----------------------------------------------------------------------------       

    // Delete
    // Eliminar usuarios
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deleteUsuario(@PathVariable int id) {
        boolean eliminado = iUsuarioService.deleteUsuario(id);
        if (eliminado) {
            System.out.println("Usuario eliminado: ID -->" + id);
            return ResponseEntity.ok().build();
        } else {
           
            System.out.println("No se pudo eliminar el usuario: ID -->" + id + " no encontrado.");
            return ResponseEntity.notFound().build();
        }
    }

// -----------------------------------------------------------------------------       
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginRequest) {

        String correo = loginRequest.get("correoUsuario");
        String contrasenia = loginRequest.get("contraseniaUsuario");
        
        if (correo == null || correo.trim().isEmpty()) {
            System.out.println("Error: El campo de correo está vacío o es nulo");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("El campo de correo no puede estar vacío");
        }

        Usuario usuario = iUsuarioService.validateLogin(correo, contrasenia);

        if (usuario != null) {
            System.out.println("Usuario autenticado:");
            System.out.println("ID: " + usuario.getIdUsuario());
            System.out.println("Correo: " + usuario.getCorreoUsuario());
            System.out.println("Nombre: " + usuario.getNombreUsuario());

            if (usuario.getRol() != null) {
                System.out.println("Rol: " + usuario.getRol().getNombreRol());
            } else {
                System.out.println("Rol no asignado");
            }
            return ResponseEntity.ok(usuario);
        } else {
            System.out.println("Error de autenticación: Credenciales incorrectas para el correo: " + correo);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales incorrectas");
        }
    }
    
   @GetMapping("/datos")
    public ResponseEntity<?> obtenerDatosUsuario(HttpServletRequest request) {
        String token = request.getHeader("Authorization").substring(7); // Eliminar "Bearer "

        if (jwtService.verifyToken(token)) {
            // Extraer datos del usuario desde el token
            String correoUsuario = jwtService.getCorreoUsuario(token);
            Usuario usuario = iUsuarioService.searchCorreoUsuario(correoUsuario);

            if (usuario != null) {
                return ResponseEntity.ok(usuario);
            }
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido o expirado");
    }

}
