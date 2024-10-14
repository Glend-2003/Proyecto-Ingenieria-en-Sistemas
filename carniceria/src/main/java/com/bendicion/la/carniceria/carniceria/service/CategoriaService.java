package com.bendicion.la.carniceria.carniceria.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import com.bendicion.la.carniceria.carniceria.jpa.CategoriaRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

/**
 *
 * @author Jamel Sandí
 */

@Service
@Primary
public class CategoriaService implements ICategoriaService {

    @Autowired
    private CategoriaRepository categoriaRep;


     @PersistenceContext
    private EntityManager entityManager;
    
    // Aquí en vez de llamar el mae .save se llama el SP (igual co los demás)
    
    @Override
    public Categoria addCategoria(Categoria categoria) {
        System.out.println("Agregando categoría con nombre: " + categoria.getNombreCategoria());
        categoriaRep.saveProcedureCategoria(categoria.getNombreCategoria(), categoria.getDescripcionCategoria());
        return categoria;
    }

     @Override
    public Categoria updateCategoria(Categoria categoria) {


        try {
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("spActualizarCategoria");
            query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);

            query.setParameter(1, categoria.getIdCategoria());
            query.setParameter(2, categoria.getNombreCategoria());
            query.setParameter(3, categoria.getDescripcionCategoria());
           
            

            query.execute();
        } catch (Exception e) {
            System.err.println("Error al ejecutar el procedimiento almacenado: " + e.getMessage());
            throw e;
        }

        return categoria;
    }


    @Override
    public List<Categoria> getCategoria() {
        return categoriaRep.listProcedureCategoria();
    }

    @Override
    public boolean deleteCategoria(int id) {
    try {
        System.out.println("Eliminando categoría con ID: " + id);
        categoriaRep.deleteProcedureCategoria(id);
        return true;
    } catch (Exception e) {
        System.err.println("Error al eliminar la categoría con ID: " + id + ". Detalles: " + e.getMessage());
        return false;
    }
    }

}
