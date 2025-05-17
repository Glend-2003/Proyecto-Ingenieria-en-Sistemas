package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;
import com.bendicion.la.carniceria.carniceria.domain.CarritoProducto;
import jakarta.transaction.Transactional;

public interface ICarritoProductoService {

    @Transactional
    public CarritoProducto addProductoAlCarrito(CarritoProducto carritoProducto);

    @Transactional
    public CarritoProducto updateStock(CarritoProducto carritoProducto);

    @Transactional
    public CarritoProducto updateProductoEnCarrito(CarritoProducto carritoProducto);

    public List<CarritoProducto> getProductosEnCarrito(int idCarrito);

    @Transactional
    public boolean removeProductoDeCarrito(int idCarritoProducto);
}
