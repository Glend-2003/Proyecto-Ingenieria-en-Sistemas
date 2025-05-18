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

import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import com.bendicion.la.carniceria.carniceria.service.ICategoriaService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/categoria")
public class CategoriaController {

    @Autowired
    ICategoriaService iCategoriaService;

    @GetMapping("/")
    public ResponseEntity<List<Categoria>> listCategoria(Boolean estadoCategoria) {
        List<Categoria> categorias = iCategoriaService.getCategoria(estadoCategoria);
        System.out.println("Listando todas las categorias: " + categorias.size() + " categorias encontradas.");
        return ResponseEntity.ok(iCategoriaService.getCategoria(estadoCategoria));
    }

    @GetMapping("obtenerPorId/{id}")
    public ResponseEntity<Categoria> listCategoriaById(@PathVariable int id) {
        Categoria categoria = iCategoriaService.getCategoriaById(id);
        if (categoria != null) {
            System.out.println("Categoria encontrada: ID -->" + categoria.getIdCategoria() + ", Nombre -->" + categoria.getNombreCategoria() + ", Descripcion -->" + categoria.getDescripcionCategoria() + categoria.isEstadoCategoria());
            return ResponseEntity.ok(categoria);
        } else {
            System.out.println("Categoria no encontrada: ID -->" + id);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping("/agregar")
    public ResponseEntity<?> addCategoria(@RequestBody Categoria categoria) {
        try {
            Categoria nuevaCategoria = iCategoriaService.addCategoria(categoria);
            System.out.println("Categoria agregada: ID -->" + categoria.getIdCategoria() + ", Nombre -->" + categoria.getNombreCategoria() + ", Descripcion -->" + categoria.getDescripcionCategoria() + categoria.isEstadoCategoria());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Categoria guardada con exito con ID: " + nuevaCategoria.getIdCategoria());
            response.put("id", nuevaCategoria.getIdCategoria());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar la categoria: " + e.getMessage()));
        }
    }

    @PutMapping("/actualizar")
    public ResponseEntity<?> updateCategoria(@RequestBody Categoria categoria) {
        try {
            Categoria categoriaActualizada = iCategoriaService.updateCategoria(categoria);
            System.out.println("Categoria actualizada: ID -->" + categoria.getIdCategoria() + ", Nombre -->" + categoria.getNombreCategoria() + ", Descripcion -->" + categoria.getDescripcionCategoria() + categoria.isEstadoCategoria());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "Categoria actualizada con exito con ID: " + categoriaActualizada.getIdCategoria());
            response.put("id", categoriaActualizada.getIdCategoria());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al actualizar la categoria: " + e.getMessage()));
        }
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deleteCategoria(@PathVariable int id) {
        boolean eliminado = iCategoriaService.deleteCategoria(id);

        if (eliminado) {
            System.out.println("Categoria eliminada: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo eliminar la categoría: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

    @PutMapping("/activar/{id}")
    public ResponseEntity<Boolean> activarCategoria(@PathVariable int id) {
        boolean estado = iCategoriaService.activarCategoria(id);

        if (estado) {
            System.out.println("Estado de categoria modificado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo modificar el estado de la categoria: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }

}
