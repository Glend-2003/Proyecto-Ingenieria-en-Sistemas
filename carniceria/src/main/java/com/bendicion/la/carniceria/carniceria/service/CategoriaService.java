package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import com.bendicion.la.carniceria.carniceria.jpa.CategoriaRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jamel Sandí
 */

@Service
@Primary
public class CategoriaService implements ICategoriaService {

    @Autowired
    private CategoriaRepository categoriaRep;
    
    // Aquí en vez de llamar el mae .save se llama el SP (igual co los demás)
    
    public Categoria addCategoria(Categoria categoria) {
        System.out.println("Agregando categoría con nombre: " + categoria.getNombreCategoria());
        categoriaRep.saveProcedureCategoria(categoria.getNombreCategoria(), categoria.getDescripcionCategoria());
        return categoria;
    }

    @Override
    public Categoria updateCategoria(Categoria categoria) {
        System.out.println("Actualizando categoría con ID: " + categoria.getIdCategoria());
        categoriaRep.updateProcedureCategoria(categoria.getIdCategoria(), categoria.getNombreCategoria(), categoria.getDescripcionCategoria());
        return categoria;
    }

    @Override
    public List<Categoria> getCategoria() {
        return categoriaRep.listProcedureCategoria();
    }

    @Override
    public boolean deleteCategoria(int id) {
        System.out.println("Eliminando categoría con ID: " + id);
        categoriaRep.deleteProcedureCategoria(id);
        return true;
    }
}
