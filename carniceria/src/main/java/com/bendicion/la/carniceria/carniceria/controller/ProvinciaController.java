package com.bendicion.la.carniceria.carniceria.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.domain.Provincia;
import com.bendicion.la.carniceria.carniceria.service.IProvinciaService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/provincia")
public class ProvinciaController {

    @Autowired
    IProvinciaService iProvinciaService;

    @GetMapping("/leer")
    public ResponseEntity<List<Provincia>> listCanton() {
        List<Provincia> provincia = iProvinciaService.getProvincia();
        System.out.println("Listando todas las provincias: " + provincia.size() + " provincias encontradas.");
        return ResponseEntity.ok(iProvinciaService.getProvincia());
    }
}
