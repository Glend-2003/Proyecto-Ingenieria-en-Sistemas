package com.bendicion.la.carniceria.carniceria.jpa;

import com.bendicion.la.carniceria.carniceria.domain.Producto;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface ProductoRepository extends JpaRepository<Producto, Integer>{
    
    // Sp Add
    @Modifying
    @Query(value = "{call spAgregarProducto(:nombreProducto, :imgProducto, :montoPrecioProducto, :descripcionProducto, :idCategoria, :estadoProducto)}", nativeQuery = true)
    void saveProcedureProducto(
        @Param("nombreProducto") String nombreProducto, 
        @Param("imgProducto") String imgProducto,
        @Param("montoPrecioProducto") BigDecimal montoPrecioProducto,
        @Param("descripcionProducto") String descripcionProducto,
        @Param("idCategoria") Integer idCategoria,
        @Param("estadoProducto") boolean estadoProducto
    );
    
// -----------------------------------------------------------------------------
    
    // Sp Update
    @Modifying
    @Query(value = "{call spActualizarProducto(:idProducto, :nombreProducto, :imgProducto, :montoPrecioProducto, :descripcionProducto, :idCategoria, :estadoProducto)}", nativeQuery = true)
    void updateProcedureProducto(
        @Param("idProducto") Integer idProducto,
        @Param("nombreProducto") String nombreProducto, 
        @Param("imgProducto") String imgProducto,
        @Param("montoPrecioProducto") BigDecimal montoPrecioProducto,
        @Param("descripcionProducto") String descripcionProducto,
        @Param("idCategoria") Integer idCategoria,
        @Param("estadoProducto") boolean estadoProducto
    );

   
// -----------------------------------------------------------------------------   
    
    // SP Read
    @Query(value = "{call spLeerProducto()}", nativeQuery = true)
    List<Producto> listProcedureProducto();
    
// -----------------------------------------------------------------------------     
    
    // Sp Delete
    @Query(value = "{call spEliminarProducto(:idProducto)}", nativeQuery = true)
    void deleteProcedureProducto(@Param("idProducto") Integer idProducto);
    
    
}