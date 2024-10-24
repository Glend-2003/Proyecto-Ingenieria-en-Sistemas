package com.bendicion.la.carniceria.carniceria.controller;

import com.bendicion.la.carniceria.carniceria.security.CookieService;
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

import com.bendicion.la.carniceria.carniceria.security.TokenService;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.service.IUsuarioService;
import jakarta.servlet.http.Cookie;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Optional;

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
    private TokenService jwtService;  // Asegúrate de tener este Autowired

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
            System.out.println("Usuario agregado: ID -->" + usuario.getIdUsuario() + ", Nombre -->"
                    + usuario.getNombreUsuario() + ", Apellidos -->" + usuario.getPrimerApellido() + " "
                    + usuario.getSegundoApellido() + usuario.isEstadoUsuario());

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
    @PostMapping("/registrar")
    public ResponseEntity<?> registrarUsuario(@RequestBody Usuario usuario) {
        try {

            iUsuarioService.registerUsuario(usuario);
            return ResponseEntity.ok("Usuario registrado con éxito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error al registrar el usuario: " + e.getMessage());
        }
    }

// -----------------------------------------------------------------------------    
    // Update
    // Actualizar usuarios 
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario usuarioActualizado = iUsuarioService.updateUsuario(usuario);
            System.out.println("Usuario actualizado: ID -->" + usuario.getIdUsuario() + ", Nombre -->"
                    + usuario.getNombreUsuario() + ", Apellidos -->" + usuario.getPrimerApellido() + " "
                    + usuario.getSegundoApellido() + usuario.isEstadoUsuario());

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

// -----------------------------------------------------------------------------       
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginRequest, HttpServletResponse response) {
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

            // Configurar las cookies para el accessToken y refreshToken
            CookieService.addCookie(response, "accessToken", usuario.getToken(), 900, true); // 15 minutos
            CookieService.addCookie(response, "refreshToken", jwtService.generateRefreshToken(usuario.getCorreoUsuario()), 604800, true); // 7 días

            // Retornar el objeto Usuario, incluyendo el token en la respuesta
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("usuario", usuario);
            responseData.put("accessToken", usuario.getToken());

            return ResponseEntity.ok(responseData);
        } else {
            System.out.println("Error de autenticación: Credenciales incorrectas para el correo: " + correo);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales incorrectas");
        }
    }


// -----------------------------------------------------------------------------
    
    @PostMapping("/cierresesion")
    public ResponseEntity<?> logout(HttpServletResponse response) {

        CookieService.deleteCookie(response, "accessToken");
        CookieService.deleteCookie(response, "refreshToken");

        return ResponseEntity.ok(Collections.singletonMap("message", "Cierre de sesión exitoso"));
    }

// -----------------------------------------------------------------------------    
    
    @PostMapping("/refrescar")
    public ResponseEntity<?> refresh(HttpServletRequest request, HttpServletResponse response) {
        Optional<Cookie> refreshTokenCookie = CookieService.getCookie(request, "refreshToken");

        if (refreshTokenCookie.isPresent()) {
            String refreshToken = refreshTokenCookie.get().getValue();

            if (jwtService.verifyToken(refreshToken) && !jwtService.isTokenExpired(refreshToken)) {
                String correoUsuario = jwtService.getCorreoUsuario(refreshToken);

                String newAccessToken = jwtService.generateAccessToken(correoUsuario);

                CookieService.addCookie(response, "accessToken", newAccessToken, 900, true); // 15 minutos

                return ResponseEntity.ok(Collections.singletonMap("message", "Token de acceso renovado"));
            }

            CookieService.deleteCookie(response, "refreshToken");
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token de refresco inválido o expirado");
    }

// -----------------------------------------------------------------------------    
    
    @GetMapping("/datos")
    public ResponseEntity<?> obtenerDatosUsuario(HttpServletRequest request) {
        // Obtener el token desde la cookie del accessToken
        Optional<Cookie> accessTokenCookie = CookieService.getCookie(request, "accessToken");
        String token = accessTokenCookie.map(Cookie::getValue).orElse(null);

        if (token != null && jwtService.verifyToken(token) && !jwtService.isTokenExpired(token)) {
            // Extraer el correo del usuario desde el token
            String correoUsuario = jwtService.getCorreoUsuario(token);
            Usuario usuario = iUsuarioService.searchCorreoUsuario(correoUsuario);

            if (usuario != null) {
                return ResponseEntity.ok(usuario);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuario no encontrado");
            }
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido o expirado");
    }



}
