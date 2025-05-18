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

import com.bendicion.la.carniceria.carniceria.domain.Rol;
import com.bendicion.la.carniceria.carniceria.service.IRolService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/rol")
public class RolController {

    @Autowired
    IRolService iRolService;

    @GetMapping("/")
    public ResponseEntity<List<Rol>> listRol() {
        List<Rol> roles = iRolService.getRol();
        System.out.println("Listando todas las categorias: " + roles.size() + " roles encontradas.");
        return ResponseEntity.ok(iRolService.getRol());
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addRol(@RequestBody Rol rol) {
        try {
            Rol nuevoRol = iRolService.addRol(rol);
            System.out.println("Rol agregado: ID -->" + rol.getIdRol() + ", Nombre -->" + rol.getNombreRol() + ", Descripcion -->" + rol.getDescripcionRol() + rol.isEstadoRol());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Rol guardado con éxito con ID: " + nuevoRol.getIdRol());
            response.put("id", nuevoRol.getIdRol());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al guardar el rol: " + e.getMessage()));
        }

    }

    @PutMapping("/actualizar")
    public ResponseEntity<?> updateRol(@RequestBody Rol rol) {
        try {
            Rol rolActualizado = iRolService.updateRol(rol);
            System.out.println("Rol actualizada: ID -->" + rol.getIdRol() + ", Nombre -->" + rol.getNombreRol() + ", Descripcion -->" + rol.getDescripcionRol() + rol.isEstadoRol());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Rol actualizado con éxito con ID: " + rolActualizado.getIdRol());
            response.put("id", rolActualizado.getIdRol());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al guardar el rol: " + e.getMessage()));
        }

    }

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
