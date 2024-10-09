package com.bendicion.la.carniceria.carniceria.controller;
import com.bendicion.la.carniceria.carniceria.domain.Rol;
import com.bendicion.la.carniceria.carniceria.service.IRolService;
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
@RequestMapping("/rol")
public class RolController {
    
    @Autowired
    IRolService iRolService;
    
    // Read
    @GetMapping("/")
    public ResponseEntity<List<Rol>> listRol() {
        List<Rol> roles = iRolService.getRol();
        System.out.println("Listando todas las categorias: " + roles.size() + " roles encontradas.");
        return ResponseEntity.ok(iRolService.getRol());
    }

    // Add
    @PostMapping("/agregar")
    public ResponseEntity<?> addRol(@RequestBody Rol rol) {
        Rol nuevoRol = iRolService.addRol(rol);
        System.out.println("Rol agregada: " + rol.getNombreRol() + " - " + rol.getDescripcionRol());
        return ResponseEntity.ok(nuevoRol);  
    }

    // Update
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateRol(@RequestBody Rol rol) {
        Rol rolActualizado = iRolService.updateRol(rol); 
        System.out.println("Rol actualizada: ID -->" + rol.getIdRol() + ", Nombre -->" + rol.getNombreRol() + ", Descripcion -->" + rol.getDescripcionRol());
        return ResponseEntity.ok(rolActualizado); 
    }

    // Delete
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deleteRol(@PathVariable int id) {
        boolean eliminado = iRolService.deleteRol(id); 
        if (eliminado) {
             System.out.println("Rol eliminado: ID -->" + id);
            return ResponseEntity.ok().build(); 
        } else {
            System.out.println("No se pudo eliminar el rol: ID -->" + id + " no encontrado.");
            return ResponseEntity.notFound().build(); 
        }
    }
}
