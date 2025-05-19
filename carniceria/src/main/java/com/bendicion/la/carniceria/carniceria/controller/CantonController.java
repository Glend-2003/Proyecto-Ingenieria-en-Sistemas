package com.bendicion.la.carniceria.carniceria.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bendicion.la.carniceria.carniceria.domain.Canton;
import com.bendicion.la.carniceria.carniceria.service.ICantonService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/canton")
public class CantonController {

    @Autowired
    ICantonService iCantonService;

    @GetMapping("/leerPorProvincia/{idProvincia}")
    public ResponseEntity<List<Canton>> listCanton(@PathVariable("idProvincia") int idProvincia) {
        List<Canton> cantones = iCantonService.getCanton(idProvincia);
        System.out.println("Cantones encontrados");
        return ResponseEntity.ok(cantones);
    }
}
