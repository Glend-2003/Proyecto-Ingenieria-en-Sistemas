package com.bendicion.la.carniceria.carniceria.controller;
import com.bendicion.la.carniceria.carniceria.service.IDireccionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Jamel Sandí
 */

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/direccion")
public class DireccionController {
    
    @Autowired
    IDireccionService iDireccionService;
    
    @PostMapping("/guardar")
    public ResponseEntity<String> guardarDireccion(
            @RequestParam int idUsuario,
            @RequestParam String descripcion,
            @RequestParam(required = false) String codigoPostal,
            @RequestParam int idDistrito) {
        
        int resultado = iDireccionService.addDireccionUsuario(
            idUsuario,
            descripcion,
            codigoPostal,
            idDistrito
        );

        return switch (resultado) {
            case 0 -> ResponseEntity.badRequest().body("Distrito no válido");
            case 1 -> ResponseEntity.ok("Dirección actualizada");
            case 2 -> ResponseEntity.ok("Dirección creada");
            default -> ResponseEntity.internalServerError().body("Error desconocido");
        };
    }
}
