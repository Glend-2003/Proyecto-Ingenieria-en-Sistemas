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

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/usuario")
public class UsuarioController {

    @Autowired
    IUsuarioService iUsuarioService;

    @Autowired
    private JwtService jwtService;

    @GetMapping("/")
    public ResponseEntity<List<Usuario>> listUsuarios() {
        List<Usuario> usuarios = iUsuarioService.getUsuario();
        System.out.println("Listando todos los usuarios: " + usuarios.size() + " usuarios encontrados.");
        return ResponseEntity.ok(usuarios);
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario nuevoUsuario = iUsuarioService.addUsuario(usuario);
            System.out.println("Usuario agregado: ID -->" + usuario.getIdUsuario() + ", Nombre -->" + usuario.getNombreUsuario() + ", Apellidos -->" + usuario.getPrimerApellido() + " " + usuario.getSegundoApellido() + usuario.isEstadoUsuario());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Usuario guardado con exito con ID: " + nuevoUsuario.getIdUsuario());
            response.put("id", nuevoUsuario.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el usuario: " + e.getMessage()));
        }
    }

    @PostMapping("/registrar")
    public ResponseEntity<?> registrarUsuario(@RequestBody Usuario usuario) {
        try {
            System.out.println("Datos del usuario recibidos: " + usuario);
            iUsuarioService.registerUsuario(usuario);
            return ResponseEntity.ok("Usuario registrado con éxito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error al registrar el usuario: " + e.getMessage());
        }
    }

    @PutMapping("/actualizar")
    public ResponseEntity<?> updateUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario usuarioActualizado = iUsuarioService.updateUsuario(usuario);
            System.out.println("Usuario actualizado: ID -->" + usuario.getIdUsuario() + ", Nombre -->" + usuario.getNombreUsuario() + ", Apellidos -->" + usuario.getPrimerApellido() + " " + usuario.getSegundoApellido() + usuario.isEstadoUsuario());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Usuario actualizado con exito con ID: " + usuarioActualizado.getIdUsuario());
            response.put("id", usuarioActualizado.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar el usuario: " + e.getMessage()));
        }
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deleteUsuario(@PathVariable int id) {
        boolean eliminado = iUsuarioService.deleteUsuario(id);
        if (eliminado) {
            System.out.println("Usuario eliminado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {

            System.out.println("No se pudo eliminar el usuario: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

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

            String correoUsuario = jwtService.getCorreoUsuario(token);
            Usuario usuario = iUsuarioService.searchCorreoUsuario(correoUsuario);

            if (usuario != null) {
                return ResponseEntity.ok(usuario);
            }
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido o expirado");
    }

    @PutMapping("/actualizarContrasena")
    public ResponseEntity<?> updateContrasena(@RequestBody Usuario usuario) {
        try {
            Usuario usuarioActualizado = iUsuarioService.actualizarContrasena(usuario);
            System.out.println("Contraseña actualizada con exito del Usuario: ID -->" + usuario.getIdUsuario());

            Map<String, Object> response = new HashMap<>();
            response.put("message", " Contraseña actualizada con exito del Usuario actualizado: " + usuarioActualizado.getIdUsuario());
            response.put("id", usuarioActualizado.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar la contraseña: " + e.getMessage()));
        }
    }

    @GetMapping("obtenerPorId/{id}")
    public ResponseEntity<Usuario> listUsuarioById(@PathVariable int id) {
        Usuario usuario = iUsuarioService.getUsuarioById(id);
        if (usuario != null) {
            System.out.println("Usuario encontrada: ID -->" + usuario.getIdUsuario() + ", Nombre -->" + usuario.getNombreUsuario());
            return ResponseEntity.ok(usuario);
        } else {
            System.out.println("Usuario no encontrada: ID -->" + id);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PutMapping("/activar/{id}")
    public ResponseEntity<Boolean> activarUsuario(@PathVariable int id) {
        boolean estado = iUsuarioService.activarUsuario(id);

        if (estado) {
            System.out.println("usuario activado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo activar el usuario: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

    @PostMapping("/verificarCambioContrasena")
    public ResponseEntity<?> verificarCorreoYEnviarCodigo(@RequestBody Map<String, String> request) {
        try {
            String correoUsuario = request.get("correoUsuario");

            if (correoUsuario == null || correoUsuario.trim().isEmpty()) {
                return ResponseEntity.badRequest().body("El campo de correo no puede estar vacío");
            }

            iUsuarioService.getCodigo(correoUsuario);

            return ResponseEntity.ok("Código de verificación enviado al correo: " + correoUsuario);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/cambiarContrasena")
    public ResponseEntity<?> cambiarContrasenaConCodigo(@RequestBody Map<String, String> request) {
        try {
            String numCodigo = request.get("numCodigo");
            String nuevaContrasenia = request.get("nuevaContrasenia");

            if (numCodigo == null || nuevaContrasenia == null) {
                return ResponseEntity.badRequest().body("El código y la nueva contraseña son requeridos");
            }

            if (nuevaContrasenia.length() < 8) {
                return ResponseEntity.badRequest().body("La contraseña debe tener al menos 8 caracteres");
            }

            iUsuarioService.cambiarContrasenaConCodigo(numCodigo, nuevaContrasenia);

            return ResponseEntity.ok("Contraseña cambiada con éxito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PutMapping("/actualizarCredenciales")
    public ResponseEntity<?> actualizarCredenciales(@RequestBody Usuario usuario) {
        try {
            Usuario nuevosCredenciales = iUsuarioService.actualizarCredenciales(usuario);

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Credenciales actualizados con exito: " + nuevosCredenciales.getIdUsuario());
            response.put("id", nuevosCredenciales.getIdUsuario());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar los credenciales: " + e.getMessage()));
        }
    }

}
