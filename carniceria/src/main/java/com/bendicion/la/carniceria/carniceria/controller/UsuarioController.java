package com.bendicion.la.carniceria.carniceria.controller;

import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.service.IUsuarioService;
import java.util.List;
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
import org.springframework.web.bind.annotation.RestController;

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

    // Leer todos los usuarios
    @GetMapping("/")
    public ResponseEntity<List<Usuario>> listUsuarios() {
        List<Usuario> usuarios = iUsuarioService.getUsuario();  // Traer todos los usuarios
        System.out.println("Listando todos los usuarios: " + usuarios.size() + " usuarios encontrados.");
        return ResponseEntity.ok(usuarios);
    }

    // Agregar un nuevo usuario con dirección
    @PostMapping("/agregar")
    public ResponseEntity<?> addUsuario(@RequestBody Usuario usuario) {
        Usuario nuevoUsuario = iUsuarioService.addUsuario(usuario);
        System.out.println("Usuario agregado: " + usuario.getNombreUsuario() + " " + usuario.getPrimerApellido() + " " + usuario.getSegundoApellido());
        return ResponseEntity.ok(nuevoUsuario);
    }

    // Actualizar un usuario existente
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateUsuario(@RequestBody Usuario usuario) {
        Usuario usuarioActualizado = iUsuarioService.updateUsuario(usuario);
        System.out.println("Usuario actualizado: ID -->" + usuario.getIdUsuario() + ", Nombre -->" + usuario.getNombreUsuario());
        return ResponseEntity.ok(usuarioActualizado);
    }

    // Eliminar un usuario por su ID
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

}
