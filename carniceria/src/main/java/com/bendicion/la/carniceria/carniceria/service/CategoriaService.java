package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import com.bendicion.la.carniceria.carniceria.jpa.CategoriaRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class CategoriaService implements ICategoriaService {

    @Autowired
    private CategoriaRepository categoriaRep;

    @Override
    public Categoria addCategoria(Categoria categoria) {
        System.out.println("Agregando categoría con nombre: " + categoria.getNombreCategoria());
        categoria.setEstadoCategoria(true);
        categoriaRep.saveProcedureCategoria(categoria.getNombreCategoria(), categoria.getDescripcionCategoria(), categoria.isEstadoCategoria());
        return categoria;
    }

    @Override
    @Transactional
    public Categoria updateCategoria(Categoria categoria) {
        System.out.println("Actualizando categoria con ID: " + categoria.getIdCategoria());
        categoria.setEstadoCategoria(true);
        categoriaRep.updateProcedureCategoria(categoria.getIdCategoria(), categoria.getNombreCategoria(), categoria.getDescripcionCategoria(), categoria.isEstadoCategoria());
        return categoria;
    }

    @Override
    @Transactional
    public List<Categoria> getCategoria(Boolean estadoCategoria) {
        return categoriaRep.listProcedureCategoria(estadoCategoria);
    }

    @Override
    public Categoria getCategoriaById(int id) {
        return categoriaRep.listProcedureCategoriaById(id);
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

    @Override
    @Transactional
    public boolean activarCategoria(int id) {
        try {

            if (!categoriaRep.existsById(id)) {
                System.err.println("El prodcuto con ID: " + id + " no existe.");
                return false;
            }

            System.out.println("activando categoria con ID: " + id);
            categoriaRep.activarCategoria(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al activar la categoria con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }
}
