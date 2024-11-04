package com.bendicion.la.carniceria.carniceria.service;
import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;

import jakarta.transaction.Transactional;

/**
 *
 * @author Jamel Sandí
 */

public interface ICategoriaService {
    
    public Categoria addCategoria(Categoria categoria);
    
    @Transactional // Asegúrate de que esté anotado
    public Categoria updateCategoria(Categoria categoria);
    
    public List<Categoria> getCategoria();

    public Categoria getCategoriaById(int id);
    
    @Transactional
    public boolean deleteCategoria(int id);
    
}
