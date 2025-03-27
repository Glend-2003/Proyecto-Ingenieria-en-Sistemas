package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.CarritoProducto;
import com.bendicion.la.carniceria.carniceria.jpa.CarritoProductoRepository;
import com.bendicion.la.carniceria.carniceria.jpa.CarritoRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class CarritoProductoService implements ICarritoProductoService {
    
    @Autowired
    private CarritoProductoRepository carritoProductoRepo;
    
    @Autowired
    private CarritoRepository carritoRepo;

    @Override
    @Transactional
    public CarritoProducto addProductoAlCarrito(CarritoProducto carritoProducto) {
        if (carritoProducto.getCarrito() == null) {
            throw new IllegalArgumentException("El producto debe estar asociado a un carrito");
        }
        if (carritoProducto.getIdProducto() <= 0) {
            throw new IllegalArgumentException("ID de producto inválido");
        }
        if (carritoProducto.getCantidadProducto() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }

        carritoProductoRepo.saveProcedureCarritoProducto(
            carritoProducto.getCarrito().getIdCarrito(),
            carritoProducto.getIdProducto(),
            carritoProducto.getCantidadProducto()
        );
        
        actualizarTotalesCarrito(carritoProducto.getCarrito().getIdCarrito());
        
        return carritoProducto;
    }

    @Override
    @Transactional
    public CarritoProducto updateProductoEnCarrito(CarritoProducto carritoProducto) {
        if (carritoProducto.getCarrito() == null) {
            throw new IllegalArgumentException("El producto debe estar asociado a un carrito");
        }
        if (carritoProducto.getIdProducto() <= 0) {
            throw new IllegalArgumentException("ID de producto inválido");
        }
        if (carritoProducto.getCantidadProducto() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }

        carritoProductoRepo.updateProcedureCarritoProducto(
            carritoProducto.getIdCarritoProducto(),
            carritoProducto.getCarrito().getIdCarrito(),
            carritoProducto.getIdProducto(),
            carritoProducto.getCantidadProducto()
        );
        
        actualizarTotalesCarrito(carritoProducto.getCarrito().getIdCarrito());
        
        return carritoProducto;
    }

    @Override
    public List<CarritoProducto> getProductosEnCarrito(int idCarrito) {
        return carritoProductoRepo.findByCarrito(idCarrito);
    }

    @Override
    @Transactional
    public boolean removeProductoDeCarrito(int idCarritoProducto) {
        try {
            CarritoProducto cp = carritoProductoRepo.findById(idCarritoProducto).orElse(null);
            if (cp == null) return false;
            
            int idCarrito = cp.getCarrito().getIdCarrito();
            
            carritoProductoRepo.deleteProcedureCarritoProducto(idCarritoProducto);
            
            actualizarTotalesCarrito(idCarrito);
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void actualizarTotalesCarrito(int idCarrito) {
        // Implementar lógica para recalcular montoTotalCarrito y cantidadCarrito
        // basado en los productos actuales del carrito
        // Esto podría requerir un procedimiento almacenado adicional
    }
}
