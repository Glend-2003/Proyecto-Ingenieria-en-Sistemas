package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface ICategoriaService {
    
    public void addCategoria(Categoria categoria);
    
    public void updateCategoria(Categoria categoria);
    
    public List<Categoria> getCategoria();
    
    @Transactional
    public boolean deleteCategoria(int id);
    
}
