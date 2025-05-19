package com.bendicion.la.carniceria.carniceria.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.service.IDireccionService;

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
            case 0 ->
                ResponseEntity.badRequest().body("Distrito no válido");
            case 1 ->
                ResponseEntity.ok("Dirección actualizada");
            case 2 ->
                ResponseEntity.ok("Dirección creada");
            default ->
                ResponseEntity.internalServerError().body("Error desconocido");
        };
    }

    @GetMapping("/buscar-por-correo")
    public ResponseEntity<?> buscarDireccionPorCorreo(@RequestParam String correoUsuario) {
        try {
            Map<String, Object> direccion = iDireccionService.buscarDireccionPorCorreo(correoUsuario);

            if (direccion == null || direccion.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("No se encontró información de dirección para el usuario con correo: " + correoUsuario);
            }

            return ResponseEntity.ok(direccion);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error al obtener la dirección: " + e.getMessage());
        }
    }
}
