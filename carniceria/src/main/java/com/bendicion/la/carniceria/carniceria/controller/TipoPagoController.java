package com.bendicion.la.carniceria.carniceria.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.domain.TipoPago;
import com.bendicion.la.carniceria.carniceria.service.ITipoPagoService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/tipopago")
public class TipoPagoController {

    @Autowired
    ITipoPagoService iTipoPagoService;

    @GetMapping("/")
    public ResponseEntity<List<TipoPago>> listTipoPago() {
        List<TipoPago> categorias = iTipoPagoService.getTipoPago();
        System.out.println("Listando todos los tipos de pago: " + categorias.size() + " categorias encontradas.");
        return ResponseEntity.ok(iTipoPagoService.getTipoPago());
    }

    @GetMapping("obtenerPorId/{id}")
    public ResponseEntity<TipoPago> listTipoPagoById(@PathVariable int id) {
        TipoPago tipoPago = iTipoPagoService.getTipoPagoById(id);
        if (tipoPago != null) {
            System.out.println("TipoPago encontrado: ID -->" + tipoPago.getIdTipoPago() + ", Descripcion -->" + tipoPago.getDescripcionTipoPago() + tipoPago.isEstadoTipoPago());
            return ResponseEntity.ok(tipoPago);
        } else {
            System.out.println("TipoPago no encontrado: ID -->" + id);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addTipoPago(@RequestBody TipoPago tipoPago) {
        try {
            TipoPago nuevoTipoPago = iTipoPagoService.addTipoPago(tipoPago);
            System.out.println("Tipo de pago agregado: ID --> " + tipoPago.getIdTipoPago()
                    + ", Descripción --> " + tipoPago.getDescripcionTipoPago()
                    + ", Estado --> " + tipoPago.isEstadoTipoPago());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Tipo de pago guardado con éxito con ID: " + nuevoTipoPago.getIdTipoPago());
            response.put("id", nuevoTipoPago.getIdTipoPago());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el tipo de pago: " + e.getMessage()));
        }
    }

    @PutMapping("/actualizar")
    public ResponseEntity<?> updateTipoPago(@RequestBody TipoPago tipoPago) {
        try {
            TipoPago tipoPagoActualizado = iTipoPagoService.updateTipoPago(tipoPago);
            System.out.println("Tipo de pago actualizado: ID --> " + tipoPago.getIdTipoPago()
                    + ", Descripción --> " + tipoPago.getDescripcionTipoPago()
                    + ", Estado --> " + tipoPago.isEstadoTipoPago());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Tipo de pago actualizado con éxito con ID: " + tipoPagoActualizado.getIdTipoPago());
            response.put("id", tipoPagoActualizado.getIdTipoPago());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar el tipo de pago: " + e.getMessage()));
        }
    }

    @PutMapping("/activar/{id}")
    public ResponseEntity<Boolean> activarTipoPago(@PathVariable int id) {
        boolean estado = iTipoPagoService.activarTipoPago(id);

        if (estado) {
            System.out.println("Estado del tipo pago modificado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo modificar el estado del tipo pago: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }
}
