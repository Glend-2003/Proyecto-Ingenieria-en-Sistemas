package com.bendicion.la.carniceria.carniceria.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Producto;
import com.bendicion.la.carniceria.carniceria.jpa.ProductoRepository;

import jakarta.transaction.Transactional;

/**
 *
 * @author Jamel Sandí
 */

@Service
@Primary
public class ProductoService implements IProductoService{

    @Autowired
    private ProductoRepository productoRepo;

    // Método para agregar un producto
    @Override
    @Transactional
    public Producto addProducto(Producto producto) {
        // Validaciones
        if (producto.getNombreProducto() == null || producto.getNombreProducto().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del producto no puede estar vacío");
        }
        if (producto.getCantidadProducto() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }
        if (producto.getTipoPesoProducto() == null || producto.getTipoPesoProducto().trim().isEmpty()) {
            throw new IllegalArgumentException("El tipo de peso del producto no puede estar vacío");
        }
        if (producto.getCodigoProducto() == null || producto.getCodigoProducto().trim().isEmpty()) {
            throw new IllegalArgumentException("El código del producto no puede estar vacío");
        }
        if (producto.getStockProducto() < 0) {
            throw new IllegalArgumentException("El stock debe ser igual o mayor a cero");
        }
        if (producto.getMontoPrecioProducto() == null || producto.getMontoPrecioProducto().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("El precio debe ser mayor a cero");
        }
        if (producto.getCategoria() == null || producto.getCategoria().getIdCategoria() <= 0) {
            throw new IllegalArgumentException("La categoría es inválida");
        }
        if (producto.getImgProducto() == null || (!producto.getImgProducto().endsWith(".jpg") && !producto.getImgProducto().endsWith(".png") && !producto.getImgProducto().endsWith(".jpeg"))) {
            throw new IllegalArgumentException("Formato de imagen inválido. Debe ser .jpg, .png o .jpeg");
        }

        // Llamada al stored procedure para guardar
        productoRepo.saveProcedureProducto(
                producto.getNombreProducto(),
                producto.getImgProducto(),
                producto.getMontoPrecioProducto(),
                producto.getDescripcionProducto(),
                producto.getCantidadProducto(),
                producto.getTipoPesoProducto(),
                producto.getCodigoProducto(),
                producto.getStockProducto(),
                producto.getCategoria().getIdCategoria(),
                producto.isEstadoProducto()
        );
        System.out.println("Datos recibidos: " + producto.toString());
        return producto;
    }

    //Método para obtener por id
    public Producto ObtenerPorId(int id) {
        return productoRepo.buscarProducto(id);
    }
    // Método para actualizar un producto
    @Transactional
    public Producto updateProducto(Producto producto) {
        
        // Validaciones
        if (producto.getIdProducto() <= 0) {
            throw new IllegalArgumentException("ID de producto inválido");
        }
        if (producto.getNombreProducto() != null && producto.getNombreProducto().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del producto no puede estar vacío");
        }
        if (producto.getCantidadProducto() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }
        if (producto.getTipoPesoProducto() == null || producto.getTipoPesoProducto().trim().isEmpty()) {
            throw new IllegalArgumentException("El tipo de peso del producto no puede estar vacío");
        }
        if (producto.getCodigoProducto() == null || producto.getCodigoProducto().trim().isEmpty()) {
            throw new IllegalArgumentException("El código del producto no puede estar vacío");
        }
        if (producto.getStockProducto() < 0) {
            throw new IllegalArgumentException("El stock debe ser igual o mayor a cero");
        }
        if (producto.getMontoPrecioProducto() != null && producto.getMontoPrecioProducto().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("El precio debe ser mayor a cero");
        }
        if (producto.getCategoria() != null && producto.getCategoria().getIdCategoria() <= 0) {
            throw new IllegalArgumentException("La categoría es inválida");
        }
        if (producto.getImgProducto() != null && (!producto.getImgProducto().endsWith(".jpg") && !producto.getImgProducto().endsWith(".png") && !producto.getImgProducto().endsWith(".jpeg"))) {
            throw new IllegalArgumentException("Formato de imagen inválido. Debe ser .jpg, .png o .jpeg");
        }

        // Llamada al stored procedure para actualizar
        productoRepo.updateProcedureProducto(
                producto.getIdProducto(),
                producto.getNombreProducto(),
                producto.getImgProducto(),
                producto.getMontoPrecioProducto(),
                producto.getDescripcionProducto(),
                producto.getCantidadProducto(),
                producto.getTipoPesoProducto(),
                producto.getCodigoProducto(),
                producto.getStockProducto(),
                producto.getCategoria() != null ? producto.getCategoria().getIdCategoria() : null,
                producto.isEstadoProducto()
        );

        return producto;
    }

    // Método para listar productos
    @Override
    @Transactional 
    public List<Producto> getProducto(boolean estadoProducto) {
        return productoRepo.listProcedureProducto(estadoProducto);
    }

    // Método para eliminar un producto
    @Override
    public boolean deleteProducto(int idProducto) {
        try {
            Producto producto = productoRepo.findById(idProducto).orElse(null);
            if (producto == null) {
                System.out.println("Producto con ID " + idProducto + " no encontrado.");
                return false;
            }
            productoRepo.deleteProcedureProducto(idProducto);
            return true;
        } catch (Exception e) {
            System.out.println("Error al eliminar el producto con ID: " + idProducto);
            e.printStackTrace();
            return false;
        }
    }
 
        @Override
    public Producto buscarUsuario(int id) {
        Producto producto = productoRepo.buscarProducto(id);

        if (producto == null) {
            System.out.println("Usuario no encontrado para el id: " + id);
            return null;
        }

        return producto;
    }
    
     @Override
     @Transactional 
    public boolean activarProducto(int id) {
        try {
            // Verificar si el comentario existe
            if (!productoRepo.existsById(id)) { // Verifica si el producto existe
                System.err.println("El prodcuto con ID: " + id + " no existe.");
                return false; // Retorna false si no existe
            }

            System.out.println("activando producto con ID: " + id);
            productoRepo.activarProducto(id);
            return true; 
        } catch (Exception e) {
            System.err.println("Error al activar el producto con ID: " + id + ". Detalles: " + e.getMessage());
            return false; // Retorna false en caso de error
        }
    }



}
