package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.jpa.CarritoRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class CarritoService implements ICarritoService{
    @Autowired
    private CarritoRepository carritoRepo;

    @Override
    @Transactional
    public Carrito addCarrito(Carrito carrito) {
        if (carrito.getUsuario() == null) {
            throw new IllegalArgumentException("El carrito debe estar asociado a un usuario");
        }
        if (carrito.getCantidadCarrito() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }
        if (carrito.getMontoTotalCarrito() == null) {
            throw new IllegalArgumentException("El monto total del carrito no puede estar vacío");
        }

        carritoRepo.saveProcedureCarrito(
                carrito.getUsuario().getIdUsuario(),
                carrito.getMontoTotalCarrito(),
                carrito.isEstadoCarrito(),
                carrito.getCantidadCarrito()
        );
        System.out.println("Datos recibidos: " + carrito.toString());
        return carrito;
    }

    @Transactional
    public Carrito updateCarrito(Carrito carrito) {
        if (carrito.getUsuario() == null) {
            throw new IllegalArgumentException("El carrito debe estar asociado a un usuario");
        }
        if (carrito.getCantidadCarrito() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }
        if (carrito.getMontoTotalCarrito() == null) {
            throw new IllegalArgumentException("El monto total del carrito no puede estar vacío");
        }

        carritoRepo.updateProcedureCarrito(
            carrito.getIdCarrito(),
            carrito.getUsuario() != null ? carrito.getUsuario().getIdUsuario() : null,
            carrito.getMontoTotalCarrito(),
            carrito.isEstadoCarrito(),
            carrito.getCantidadCarrito()
        );

        return carrito;
    }

    @Override
    @Transactional 
    public List<Carrito> getCarrito(boolean estadoCarrito) {
        return carritoRepo.listProcedureCarrito(estadoCarrito);
    }

    @Override
    public boolean deleteCarrito(int idCarrito) {
        try {
            Carrito carrito = carritoRepo.findById(idCarrito).orElse(null);
            if (carrito == null) {
                System.out.println("Carrito con ID " + idCarrito + " no encontrado.");
                return false;
            }
            carritoRepo.deleteProcedureCarrito(idCarrito);
            return true;
        } catch (Exception e) {
            System.out.println("Error al eliminar el carrito con ID: " + idCarrito);
            e.printStackTrace();
            return false;
        }
    }
}
