package com.bendicion.la.carniceria.carniceria.controller;
import java.util.Arrays;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Jamel Sandí
 */

@RestController
public class InformeLoginController {
     
    @GetMapping("/informe")
    public ResponseEntity<List<String>> messages() {
        return ResponseEntity.ok(Arrays.asList("first", "second"));
    }
}
