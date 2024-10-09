package com.bendicion.la.carniceria.carniceria.controller;
import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import com.bendicion.la.carniceria.carniceria.service.ICategoriaService;
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
@RequestMapping("/categoria")
public class CategoriaController {
    
    @Autowired
    ICategoriaService iCategoriaService;
    
    // Read
    @GetMapping("/")
    public ResponseEntity<List<Categoria>> listCategoria() {
        List<Categoria> categorias = iCategoriaService.getCategoria();
        System.out.println("Listando todas las categorias: " + categorias.size() + " categorias encontradas.");
        return ResponseEntity.ok(iCategoriaService.getCategoria());
    }

    // Add
    @PostMapping("/agregar")
    public ResponseEntity<?> addCategoria(@RequestBody Categoria categoria) {
        Categoria nuevaCategoria = iCategoriaService.addCategoria(categoria);
        System.out.println("Categoria agregada: " + categoria.getNombreCategoria() + " - " + categoria.getDescripcionCategoria());
        return ResponseEntity.ok(nuevaCategoria);  
    }

    // Update
    @PutMapping("/actualizar")
    public ResponseEntity<?> updateCategoria(@RequestBody Categoria categoria) {
        Categoria categoriaActualizada = iCategoriaService.updateCategoria(categoria); 
        System.out.println("Categoria actualizada: ID -->" + categoria.getIdCategoria() + ", Nombre -->" + categoria.getNombreCategoria() + ", Descripcion -->" + categoria.getDescripcionCategoria());
        return ResponseEntity.ok(categoriaActualizada); 
    }

    // Delete
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deleteCategoria(@PathVariable int id) {
        boolean eliminado = iCategoriaService.deleteCategoria(id); 
        if (eliminado) {
             System.out.println("Categoria eliminada: ID -->" + id);
            return ResponseEntity.ok().build(); 
        } else {
            System.out.println("No se pudo eliminar la categoría: ID -->" + id + " no encontrado.");
            return ResponseEntity.notFound().build(); 
        }
    }
}
