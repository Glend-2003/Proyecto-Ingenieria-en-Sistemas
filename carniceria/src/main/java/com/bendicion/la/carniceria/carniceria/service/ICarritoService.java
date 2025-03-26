package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;

import jakarta.transaction.Transactional;

public interface ICarritoService {
    @Transactional
    public Carrito addCarrito(Carrito carrito);

    @Transactional 
    public Carrito updateCarrito(Carrito carrito);
    
    public List<Carrito> getCarrito(boolean estadoCarrito);   
    
    @Transactional
    public boolean deleteCarrito(int id);
}
