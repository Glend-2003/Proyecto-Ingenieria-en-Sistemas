package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;

import jakarta.transaction.Transactional;

public interface ICategoriaService {

    public Categoria addCategoria(Categoria categoria);

    @Transactional
    public Categoria updateCategoria(Categoria categoria);

    public List<Categoria> getCategoria(Boolean estadoCategoria);

    public Categoria getCategoriaById(int id);

    @Transactional
    public boolean deleteCategoria(int id);

    @Transactional
    public boolean activarCategoria(int id);
}
