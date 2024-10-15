package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface ICategoriaService {
    
    public Categoria addCategoria(Categoria categoria);
    
    @Transactional // Asegúrate de que esté anotado
    public Categoria updateCategoria(Categoria categoria);
    
    public List<Categoria> getCategoria();
    
    @Transactional
    public boolean deleteCategoria(int id);
    
}
