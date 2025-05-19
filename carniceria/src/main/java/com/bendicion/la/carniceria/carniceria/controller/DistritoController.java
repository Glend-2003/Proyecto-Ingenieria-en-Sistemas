package com.bendicion.la.carniceria.carniceria.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.domain.Distrito;
import com.bendicion.la.carniceria.carniceria.service.IDistritoService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/distrito")
public class DistritoController {

    @Autowired
    IDistritoService iDistritoService;

    @GetMapping("/")
    public ResponseEntity<List<Distrito>> listDistrito() {
        List<Distrito> distritos = iDistritoService.getDistrito();
        System.out.println("Listando todos los distritos: " + distritos.size() + " distritos encontradas.");
        return ResponseEntity.ok(iDistritoService.getDistrito());
    }

    @GetMapping("/leerPorCanton/{idCanton}")
    public ResponseEntity<List<Distrito>> listDistritos(@PathVariable("idCanton") int idCanton) {
        List<Distrito> distritos = iDistritoService.getDistritos(idCanton);
        System.out.println("Listando todos los distritos: " + distritos.size() + " distritos encontradas.");
        return ResponseEntity.ok(distritos);
    }

}
