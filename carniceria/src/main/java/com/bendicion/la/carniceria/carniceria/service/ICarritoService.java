package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;
import java.util.Map;

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

    @Transactional
    Map<String, List<Object[]>> obtenerCarritosUsuario(Integer usuarioId);

    Carrito obtenerCarritoPorId(Integer idCarrito);
}
