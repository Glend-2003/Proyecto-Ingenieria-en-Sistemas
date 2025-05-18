package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Producto;

import jakarta.transaction.Transactional;

public interface IProductoService {

    @Transactional
    public Producto addProducto(Producto producto);

    @Transactional
    public Producto updateProducto(Producto producto);

    public List<Producto> getProducto(boolean estadoProducto);

    @Transactional
    public boolean deleteProducto(int id);

    public Producto buscarUsuario(int id);

    @Transactional
    public boolean activarProducto(int id);
}
